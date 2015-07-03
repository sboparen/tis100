#!/usr/bin/env python2
"""
Parse records from the TIS-100 "save.dat" save file.
"""
from collections import defaultdict
import os


METRICS = ['cycles', 'nodes', 'instructions']


def parse(data, puzzles=None):
    constructor = lambda: defaultdict(lambda: None)
    ret = defaultdict(constructor)
    solutions = defaultdict(lambda: defaultdict(constructor))
    for line in data.split('\n'):
        lhs, value = line.split(' = ')
        if lhs.startswith('Best.'):
            best, number, key = lhs.split('.')
            key = key.lower()
            assert key in METRICS, key
            assert key not in ret[number]
            ret[number][key] = int(value)
        elif lhs.startswith('Last.'):
            best, number, slot, key = lhs.split('.')
            key = key.lower()
            assert key in METRICS, key
            assert key not in solutions[number][slot]
            solutions[number][slot][key] = int(value)
    if puzzles is not None:
        # For any solutions tied for a given metric,
        # also record the product of all metrics.
        for puzzle in puzzles:
            number = puzzle['number']
            for solution in solutions[number].values():
                cost = solution['cycles']
                cost *= solution['nodes']
                cost *= solution['instructions']
                for key in METRICS:
                    if solution[key] == puzzle[key]:
                        old_cost = ret[number]['%s_cost' % key]
                        if old_cost is None or cost < old_cost:
                            ret[number]['%s_cost' % key] = cost
    return ret


if __name__ == '__main__':
    # Assume save.dat or a symlink to it is in the directory with
    # this script.  Assume the reddit thread has already been
    # fetched as "reddit.html" in the current directory.
    import reddit
    path = os.path.join(os.path.dirname(__file__), 'reddit.html')
    puzzles = reddit.parse(open(path).read())
    path = os.path.join(os.path.dirname(__file__), 'save.dat')
    records = parse(open(path).read(), puzzles=puzzles)
    for key, record in sorted(records.items()):
        print key, record

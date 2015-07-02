#!/usr/bin/env python2
"""
Parse records from the TIS-100 "save.dat" save file.
"""
import os


METRICS = ['cycles', 'nodes', 'instructions']
class record(object):
    pass


def parse(data, puzzles=None):
    ret = {}
    solutions = {}
    for line in data.split('\n'):
        if line.startswith('Best.'):
            lhs, value = line.split(' = ')
            value = int(value)
            best, number, key = lhs.split('.')
            if number not in ret:
                ret[number] = record()
            key = key.lower()
            assert key in METRICS, key
            assert key not in ret[number].__dict__
            setattr(ret[number], key, value)
        elif line.startswith('Last.'):
            lhs, value = line.split(' = ')
            value = int(value)
            best, number, slot, key = lhs.split('.')
            if number not in solutions:
                solutions[number] = {}
            if slot not in solutions[number]:
                solutions[number][slot] = record()
            key = key.lower()
            assert key in METRICS, key
            assert key not in solutions[number][slot].__dict__
            setattr(solutions[number][slot], key, value)
    if puzzles is not None:
        # For any solutions tied for a given metric,
        # also record the product of all metrics.
        for puzzle in puzzles:
            for solution in solutions.get(puzzle.number, {}).values():
                cost = solution.cycles * solution.nodes * solution.instructions
                for key in METRICS:
                    if getattr(solution, key) == getattr(puzzle, key):
                        setattr(ret[puzzle.number], '%s_cost' % key, cost)
    return ret


if __name__ == '__main__':
    # Assume save.dat or a symlink to it is in the directory with
    # this script.
    path = os.path.join(os.path.dirname(__file__), 'save.dat')
    records = parse(open(path).read())
    for key, r in sorted(records.items()):
        print key, r.__dict__

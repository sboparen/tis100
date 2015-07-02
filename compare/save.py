#!/usr/bin/env python2
"""
Parse records from the TIS-100 "save.dat" save file.
"""
import os


class record(object):
    pass


def parse(data):
    ret = {}
    for line in data.split('\n'):
        if not line.startswith('Best.'):
            continue
        lhs, value = line.split(' = ')
        value = int(value)
        best, number, key = lhs.split('.')
        if number not in ret:
            ret[number] = record()
        key = key.lower()
        assert key in ['cycles', 'nodes', 'instructions'], key
        assert key not in ret[number].__dict__
        setattr(ret[number], key, value)
    return ret


if __name__ == '__main__':
    # Assume save.dat or a symlink to it is in the directory with
    # this script.
    path = os.path.join(os.path.dirname(__file__), 'save.dat')
    records = parse(open(path).read())
    for key, r in sorted(records.items()):
        print key, r.__dict__

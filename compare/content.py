#!/usr/bin/env python2
"""
Build HTML for the table of records.
"""
from lxml.builder import E


CHECKMARK = u'\u2713'


def table(puzzles, records):
    columns = ['Segment', 'Cycles', 'Nodes', 'Instructions']
    table = E.table(E.tr(*[E.th(name) for name in columns]))
    for puzzle in puzzles:
        row = E.tr()
        row.append(E.td(puzzle.name))
        for key in ['cycles', 'nodes', 'instructions']:
            best_known = getattr(puzzle, key)
            personal_best = None
            if puzzle.number in records:
                personal_best = getattr(records[puzzle.number], key, None)
            text = None
            if personal_best is None:
                text = '---'
            elif personal_best < best_known:
                text = '%d better!' % (best_known - personal_best)
            elif personal_best == best_known:
                text = CHECKMARK
            else:
                if key == 'cycles':
                    n = (personal_best - best_known) * 100
                    d = best_known
                    percent = (n + d - 1) / d
                    text = '+%d%%' % percent
                else:
                    text = '+%d' % (personal_best - best_known)
            row.append(E.td(text, style='text-align: center'))
        table.append(row)
    return table

#!/usr/bin/env python2
"""
Build HTML for the table of records.
"""
from lxml.builder import E


CHECKMARK = u'\u2713'
RECORD_HOLDER = u'\u2605'


def table(puzzles, records, username):
    columns = ['Segment', 'Cycles', 'Nodes', 'Instructions']
    table = E.table(E.tr(*[E.th(name) for name in columns]))
    for puzzle in puzzles:
        number = puzzle['number']
        row = E.tr()
        row.append(E.td(puzzle['name']))
        for key in ['cycles', 'nodes', 'instructions']:
            best_known = puzzle[key]
            personal_best = records[number][key]
            text = None
            cost_text = None
            if personal_best is None:
                text = '---'
            elif personal_best < best_known:
                text = '%d better!' % (best_known - personal_best)
            elif personal_best == best_known:
                text = CHECKMARK
                if puzzle['%s_name'] == username:
                    text = RECORD_HOLDER
                cost = records[number]['%s_cost' % key]
                best_cost = puzzle['%s_cost' % key]
                if cost is None:
                    cost_text = '(unknown cost)'
                elif cost > best_cost:
                    n = (cost - best_cost) * 100
                    d = best_cost
                    percent = (n + d - 1) / d
                    cost_text = 'cost +%d%%' % percent
                elif cost == best_cost:
                    cost_text = None
                else:
                    cost_text = '%d better cost!' % (best_cost - cost)
            else:
                if key == 'cycles':
                    n = (personal_best - best_known) * 100
                    d = best_known
                    percent = (n + d - 1) / d
                    text = '+%d%%' % percent
                else:
                    text = '+%d' % (personal_best - best_known)
            cell = E.td(text, style='text-align: center')
            if cost_text is not None:
                cell.append(E.br())
                cell.append(E.span(cost_text))
            row.append(cell)
        table.append(row)
    return table

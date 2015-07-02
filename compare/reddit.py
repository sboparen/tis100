#!/usr/bin/env python2
"""
Parse records from the reddit leaderboards.
"""
import os
import urllib2
from lxml import etree

URL = 'http://www.reddit.com/r/tis100/comments/391heb/'


class puzzle(object):
    pass


def parse(data):
    root = etree.HTML(data)
    tables = root.xpath("//table[preceding::h1]")
    tables = [table for table in tables if
              table.getprevious().text == 'Legit Solutions']
    table, = tables
    ret = []
    for body in table.findall('tbody'):
        for row in body.getchildren():
            p = puzzle()
            name, cycles, nodes, instructions = \
                [el.text for el in row.getchildren()]
            if name == 'Totals':
                continue
            p.number = name[:name.index(' ')]
            p.name = name[name.index(' ')+1:]
            cycles = [int(x) for x in cycles.split(' - ')[-1].split('/')]
            p.cycles = cycles[0]
            p.cycles_cost = cycles[0] * cycles[1] * cycles[2]
            nodes = [int(x) for x in nodes.split(' - ')[-1].split('/')]
            p.nodes = nodes[1]
            p.nodes_cost = nodes[0] * nodes[1] * nodes[2]
            instructions = [int(x) for x in instructions.split(' - ')[-1].split('/')]
            p.instructions = instructions[2]
            p.instructions_cost = instructions[0] * instructions[1] * instructions[2]
            ret.append(p)
    return ret


if __name__ == '__main__':
    h = {'User-Agent': 'tis100 comparison by /u/sboparen'}
    data = urllib2.urlopen(urllib2.Request(URL, headers=h)).read()
    path = os.path.join(os.path.dirname(__file__), 'reddit.html')
    with open(path, 'w') as f:
        f.write(data)
    puzzles = parse(data)
    for p in puzzles:
        print p.__dict__

#!/usr/bin/env python2
"""
Parse records from the reddit leaderboards.
"""
import os
import urllib2
from lxml import etree

URL = 'http://www.reddit.com/r/tis100/comments/391heb/'
METRICS = ['cycles', 'nodes', 'instructions']
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
            cells = [el.text for el in row.getchildren()]
            assert len(cells) == 4
            name = cells[0]
            if name == 'Totals':
                continue
            p.number = name[:name.index(' ')]
            p.name = name[name.index(' ')+1:]
            for index, key in enumerate(METRICS):
                if ' - ' in cells[index+1]:
                    name, score = cells[index+1].split(' - ')
                else:
                    name = None
                    score = cells[index+1]
                score = [int(x) for x in score.split('/')]
                setattr(p, key, score[index])
                setattr(p, '%s_cost' % key, score[0] * score[1] * score[2])
                setattr(p, '%s_name' % key, name)
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

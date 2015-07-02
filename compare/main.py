#!/usr/bin/env python2
"""
Creates a page which compares your scores against the best known.
"""
from lxml import etree
from lxml.builder import E
import content
import datetime
import os
import reddit
import save

STYLE = '''
table {
  border-spacing: 0;
  border-color: #000;
  border-width: 1px 1px 0 0;
  border-style: solid;
}
td, th {
  margin: 0;
  border-color: #000;
  border-width: 0 0 1px 1px;
  border-style: solid;
  padding: 0.3em;
}
'''


def makepage(puzzles, records):
    now = datetime.datetime.now()
    page_title = 'TIS-100 Comparison'
    content_type = E.meta(
        {'http-equiv': 'Content-Type'},
        content='text/html;charset=utf-8')
    head = E.head(content_type, E.title(page_title))
    head.append(E.style(STYLE))
    head.append(E.meta(
        name='viewport', content='width=device-width initial-scale=1'))
    body = E.body()
    body.append(E.h1(page_title))
    body.append(content.table(puzzles, records))
    body.append(E.p('This page was generated\n' +
                now.strftime('on %A, %d %B %Y at %I:%M:%S %p\n')))
    page = E.html(head, body)
    doctype = '<!DOCTYPE html>'
    return etree.tostring(
        page, doctype=doctype, method='html', pretty_print=True)


if __name__ == '__main__':
    # Assume save.dat or a symlink to it is in the directory with
    # this script.  Assume the reddit thread has already been
    # fetched as "reddit.html" in the current directory.
    path = os.path.join(os.path.dirname(__file__), 'reddit.html')
    puzzles = reddit.parse(open(path).read())
    path = os.path.join(os.path.dirname(__file__), 'save.dat')
    records = save.parse(open(path).read())
    outpath = os.path.join(os.path.dirname(__file__), 'comparison.html')
    with open(outpath, 'w') as f:
        f.write(makepage(puzzles, records))

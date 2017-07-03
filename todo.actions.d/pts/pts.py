import sys
import os
import re


def main(todo_dir, ptsDefault=0):

    f = open(os.path.join(todo_dir, 'todo.txt'))
    lines = f.readlines()

    ptsDone = 0
    ptsTotal = 0
    for line in lines:
        m = re.search("pts:\d*", line)
        if m is None:
            val = ptsDefault
        else:
            val = re.search("\d*$", m.group())
            val = int(val.group())

        complete = re.match("x ", line)
        if complete is not None:
            ptsDone += val
        ptsTotal += val

    ptsString = '%i/%i' % (ptsDone, ptsTotal)
    print ptsString


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: pts.py TODO_DIR [default_pts]")
        sys.exit(1)

    if os.path.isdir(sys.argv[1]):
        if len(sys.argv) is 3:
            main(sys.argv[1], int(sys.argv[2]))
        else:
            main(sys.argv[1])

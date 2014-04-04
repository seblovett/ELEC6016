#!/bin/bash
# @file make.sh
# Date Created: Tue 01 Apr 2014 19:46:45 BST by seblovett on seblovett-Ubuntu
# <+Last Edited: Fri 04 Apr 2014 10:34:52 BST by hl13g10 on octopus +>

pdflatex report
pdflatex report
texcount -v -html -inc report.tex > count.html

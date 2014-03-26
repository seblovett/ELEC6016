#!/usr/bin/python 

import os
from optparse import OptionParser
import re
import string
opcodes = {
    }

def ConvertToBin(x, length):
        if type(x) == str:
                val = int(x)
        else:
                val = x
        mask = 1 << length - 1
        binary = ""
        while mask > 0:
                if mask & val:
                        binary+="1"
                else:
                        binary+="0"
                mask >>= 1
        return binary
    
def assembleLine(Line):
    """ to assemble a single line"""
    #Line = Line.split(" ") #split at white space
    Line = re.split(";| ", Line)
    
    print Line
    maccode = opcodes[Line[0]] #opcode is the fist. get the machine code for it
    maccode = maccode * 16 #shift it up to top nibble
    if (Line[0] == "WAIT0" ) or (Line[0] == "WAIT1"):
        print("No argument to instruction read")
    else: #should have an argument
        if Line[1][0] == "R":
            Line[1] = Line[1][1:]
        maccode = maccode + int(Line[1])
    print maccode
    bincode = ConvertToBin(maccode,8)
    print bincode
    hexline = ''.join("%x" % string.atoi(bincode,2))
    print hexline
    return hexline
def assemble(infile, outfile):
        infile = open(options.input, 'r')
        indata = infile.read()
        infile.close()
        indata = indata.split("\n")
        #print indata
        outfile = open(options.output, 'w')
        for Line in indata:
                print Line
                if Line != "":
                        hexout = assembleLine(Line)
                        hexout = hexout + "  // " + Line + "\n"
                        outfile.write(hexout)
        outfile.close()

def getOpcodes():
        opcodessvh_f = open("opcodes.sv", 'r')
        opcodessv = opcodessvh_f.read()
        print opcodessv
        m = re.search("typedef enum logic \[3.*opcodes_t;", opcodessv, re.DOTALL)
        if m:
                #print m.group()
                td = m.group()
                td = "".join(td.split())
                td = td.replace("typedefenumlogic[3:0]{", '')
                td = td.replace("}opcodes_t;", '')
                td = td.replace("4'd", "")
                td = td.split(",")
                
                print td
                for t in td:
                        print t
                        if t[0] != '/': #we haven't previously removed it
                                op = t.split("=") #split on the equals
                                opcodes[op[0]] = int(op[1])
                print opcodes
        else:
                print("Nothing found")
if "__main__" == __name__:
    parser = OptionParser()
    parser.add_option("-i", "--asm", dest="input",
                  help="input asm file to assemble", metavar="FILE")
    parser.add_option("-o", "--hex", dest="output",
                  help="output hex file to write to. default is input with .hex extentsion", metavar="FILE")
    
    (options, args) = parser.parse_args()

    options.input = "transform.asm"
    if (options.input == None):
        print("No Input file given")
        parser.print_help()
        exit(1)
    print "Input File = %s" % options.input
    if (options.output == None):
        print("No Output file given")
        opfile = options.input.split(".")
        opfile[-1]="hex"
        opfile = ".".join(opfile)
        options.output = opfile
    print options.output
    getOpcodes()
    assemble(options.input, options.output)
    

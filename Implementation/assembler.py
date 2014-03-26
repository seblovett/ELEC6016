import os
from optparse import OptionParser
import re
import string
opcodes = {
    "WAIT0" : 2,
    "WAIT1" : 3,
    "STSW" : 4,
    "JMPA" : 6,
    "PASSA" : 8,
    "LUI" : 9,
    "ADD" : 10,
    "ADDI" : 11,
    "MULT" : 12,
    "STACC" :14,

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

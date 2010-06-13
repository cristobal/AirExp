#!/usr/bin/env python
#
# Modified version of Michel Boyer pfb2otf python script part.
#
# (c) 2007-2009, Michel Boyer
# GNU Licensed
# boyer@iro.umontreal.ca     http://www.iro.umontreal.ca/~boyer

import fontforge
import sys, os, re


"""
	Globals
"""
c				 	= re.compile(r"(afm|pfb|pfm)$", re.I)
valid			= lambda f: c.search(f)


"""
	Process directory
	
	@param filepath	The directory to process
"""			
def process_dir(dirpath):
	# Loop over directory 1st level only
	# If the filepath is a file and has the valid fonttype extension
	# Process it.
	for filename in os.listdir(dirpath):
		filepath = dirpath + os.path.sep + filename
		if os.path.isfile(filepath):
			if valid(filepath):
				convert(filepath)
	pass


"""
	Process filepath
	
	@param filepath	The file to process
"""
def process_file(filepath):
	if valid(filepath):
		convert(filepath)
	pass


"""
	Convert font
	
	@param filepath The absolute filepath of the font file to convert
"""
def convert(filepath):
	dirpath	  = os.path.dirname(filepath)
	
	font 		  = fontforge.open(filepath)
	fontpath	= dirpath + os.path.sep + font.fontname + ".otf"
	
	font.mergeFeature( filepath )
	font.encoding = "unicode"
	font.generate( fontpath )
	font.close()
	pass


"""
	Main entry
"""
def main():
	file_list = sys.argv[1:]
	for filepath in file_list:
		if os.path.isdir(filepath) == True:
			process_dir(filepath)
		else:
			process_file(filepath)

print """This file was called...."""
if __name__ == "__main__":
	main()
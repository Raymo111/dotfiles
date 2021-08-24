#!/bin/bash
curl -sL "$1" | tee >(pdftotext - - | sed 's/\t/ /g' > pdf.txt) | pdfimages -all -pdf

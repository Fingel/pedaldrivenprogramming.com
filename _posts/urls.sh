#!/bin/bash
#for i in *.html; do
#    sed -i 's/src="\/img/src="https:\/\/s3-us-west-2.amazonaws.com\/pedaldp\//g' $i
#done
for i in *.html; do
    sed -i 's/pedaldp\/\//pedaldp\//g' $i
done

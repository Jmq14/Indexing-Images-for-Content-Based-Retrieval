#!/usr/bin/env sh

./build/tools/caffe test -model examples/ADS_Project_2/solver.prototxt -weights examples/ADS_Project_2/bvlc_alexnet.caffemodel

sleep 180
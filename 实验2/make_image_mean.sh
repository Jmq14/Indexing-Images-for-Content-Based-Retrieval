#!/usr/bin/env sh
# Compute the mean image from the imagenet training lmdb
# N.B. this is available in data/ilsvrc12

DATA=data/ADS_Project_2_re/train4613
TEST=data/ADS_Project_2_re/val1000

EXAMPLE=examples/ADS_Project_2

TOOLS=build/tools


$TOOLS/compute_image_mean $EXAMPLE/img_train4613_lmdb \
  $DATA/train4613_mean.binaryproto

$TOOLS/compute_image_mean $EXAMPLE/img_val1000_lmdb \
  $TEST/val1000_mean.binaryproto

echo "Done."

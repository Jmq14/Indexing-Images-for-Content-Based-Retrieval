#!/usr/bin/env sh
MY=examples/ADS_Project_2

echo "Create train lmdb.."
rm -rf $MY/img_train4613_lmdb
build/tools/convert_imageset \
--shuffle \
--resize_height=256 \
--resize_width=256 \
/Users/mengqingjiang/Desktop/file/Project/DL/caffe/data/ADS_Project_2_re/train4613/ \
$MY/train4613.txt  \
$MY/img_train4613_lmdb

echo "Create test lmdb.."
rm -rf $MY/img_val1000_lmdb
build/tools/convert_imageset \
--shuffle \
--resize_height=256 \
--resize_width=256 \
/Users/mengqingjiang/Desktop/file/Project/DL/caffe/data/ADS_Project_2_re/val1000/ \
$MY/val1000.txt  \
$MY/img_val1000_lmdb

echo "All Done.."
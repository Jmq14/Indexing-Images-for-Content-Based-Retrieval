#!/usr/bin/env sh
DATA=data/ADS_Project_2_re/train4613
TEST=data/ADS_Project_2_re/val1000
MY=examples/ADS_Project_2

echo "Create train.txt..."
rm -rf $MY/train4613.txt
find $DATA -name '*n01613177_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 0/">>$MY/train4613.txt
find $DATA -name '*n01923025_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 1/">>$MY/train4613.txt
find $DATA -name '*n02278980_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 2/">>$MY/train4613.txt
find $DATA -name '*n03767203_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 3/">>$MY/train4613.txt
find $DATA -name '*n03877845_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 4/">>$MY/train4613.txt
find $DATA -name '*n04515003_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 5/">>$MY/train4613.txt
find $DATA -name '*n04583620_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 6/">>$MY/train4613.txt
find $DATA -name '*n07897438_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 7/">>$MY/train4613.txt
find $DATA -name '*n10247358_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 8/">>$MY/train4613.txt
find $DATA -name '*n11669921_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 9/">>$MY/train4613.txt

echo "Create test.txt..."
rm -rf $MY/val1000.txt
find $TEST -name '*n01613177_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 0/">>$MY/val1000.txt
find $TEST -name '*n01923025_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 1/">>$MY/val1000.txt
find $TEST -name '*n02278980_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 2/">>$MY/val1000.txt
find $TEST -name '*n03767203_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 3/">>$MY/val1000.txt
find $TEST -name '*n03877845_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 4/">>$MY/val1000.txt
find $TEST -name '*n04515003_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 5/">>$MY/val1000.txt
find $TEST -name '*n04583620_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 6/">>$MY/val1000.txt
find $TEST -name '*n07897438_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 7/">>$MY/val1000.txt
find $TEST -name '*n10247358_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 8/">>$MY/val1000.txt
find $TEST -name '*n11669921_*.JPEG' | cut -d '/' -f4 | sed "s/$/ 9/">>$MY/val1000.txt

echo "All done"
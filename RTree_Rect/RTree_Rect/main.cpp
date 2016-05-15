//
// Test.cpp
//
// This is a direct port of the C version of the RTree test program.
//
//
// Test.cpp
//
// This is a direct port of the C version of the RTree test program.
//

#include "RTree.h"

#define DIMENSION  9
#define EXTENSION  3000

struct Rect
{
	Rect(){}

	Rect(double a[])
	{
		for (int i = 0; i < DIMENSION; i++)
		{
			min[i] = a[i] - EXTENSION;
			max[i] = a[i] + EXTENSION;
		}
	}

	double min[DIMENSION], max[DIMENSION];
};


bool MySearchCallback(int id, void* arg) 
{
	printf("Hit data rect %d\n", id);
	return true; // keep going
}


void main()
{
	RTree<int, double, DIMENSION, double> tree;
	int n;
	ifstream fin("color_feature.txt");
	fin >> n;
	Rect *rects = new Rect[n];
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < DIMENSION; j++)
		{
			fin >> rects[i].min[j];
			rects[i].max[j] = rects[i].min[j] + EXTENSION;
			rects[i].min[j] -= EXTENSION;
		}
	}
	printf("nrects = %d\n", n);

	for(int i = 0; i < n; i++)
	{
		tree.Insert(rects[i].min, rects[i].max, i); // Note, all values including zero are fine in this version
	}

	double a[] = {6, 4, 10, 6, 6, 4, 10, 6, 0};
	Rect search_rect(a); // search will find above rects that this one overlaps

	printf("Search resulted in %d hits\n", tree.Search(search_rect.min, search_rect.max, MySearchCallback, NULL));
	delete []rects;
}
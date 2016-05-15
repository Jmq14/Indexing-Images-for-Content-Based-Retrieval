//
// Test.cpp
//
// This is a direct port of the C version of the RTree test program.
//

#include <stdio.h>
#include "RTree.h"

struct Rect
{
	Rect()  {
		R = RADIUS;
	}

	Rect(double a[])
	{
		for (int i = 0; i < DIMENSION; i++)
		{
			center[i] = a[i];
		}
		R = RADIUS;
	}

	double center[DIMENSION];
	double R;
};


bool MySearchCallback(int id, void* arg) 
{
	printf("Hit data rect %d\n", id);
	return true; // keep going
}


void main()
{
	RTree<int, double, double> tree;
	int n;
	ifstream fin("color_feature.txt");
	fin >> n;
	n = 2500;
	Rect *rects = new Rect[n];
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < DIMENSION; j++)
		{
			fin >> rects[i].center[j];
		}
	}
	printf("nrects = %d\n", n);

	for(int i = 0; i < n; i++)
	{
		tree.Insert(rects[i].center, rects[i].R, i); // Note, all values including zero are fine in this version
		cout << i << endl;
	}

	double a[] = {6, 4, 10, 6, 6, 4, 10, 6, 0};
	Rect search_rect(a); // search will find above rects that this one overlaps

	printf("Search resulted in %d hits\n", tree.Search(search_rect.center, search_rect.R, MySearchCallback, NULL));
	delete []rects;
}
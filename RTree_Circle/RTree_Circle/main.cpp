//
// Test.cpp
//
// This is a dicircle port of the C version of the RTree test program.
//

#include <stdio.h>
#include "RTree.h"

struct Circle
{
	Circle()  {
		R = RADIUS;
	}

	Circle(double a[])
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
	printf("Hit data circle %d\n", id);
	return true; // keep going
}


void main()
{
	RTree<int, double, double> tree;
	int n;
	ifstream fin("color_feature.txt");
	fin >> n;
	Circle *circles = new Circle[n];
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < DIMENSION; j++)
		{
			fin >> circles[i].center[j];
		}
	}
	printf("ncircles = %d\n", n);

	for(int i = 0; i < n; i++)
	{
		tree.Insert(circles[i].center, circles[i].R, i); // Note, all values including zero are fine in this version
	}

	double a[] = {6, 4, 10, 6, 6, 4, 10, 6, 0};
	Circle search_circle(a); // search will find above circles that this one overlaps

	printf("Search resulted in %d hits\n", tree.Search(search_circle.center, search_circle.R + 2000, MySearchCallback, NULL));
	delete []circles;
}
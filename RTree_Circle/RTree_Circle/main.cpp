//
// Test.cpp
//
// This is a dicircle port of the C version of the RTree test program.
//

#include <stdio.h>
#include "RTree.h"

#define OUTPUTNUM 50
#define RADIUS    5000

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

struct Link
{
	Circle circle;
	int id;

	Link *next;
	Link *last;
};

struct LinkList
{
	Link* head;
	Link* tail;

	int num;

	LinkList(){
		head = NULL;
		tail = head;
		num = 0;
	}
};

double a[] = {1553, 4367, 6897, 2239, 3278, 2712, 3094, 3553, 3062};
Circle *circles, search(a);
LinkList list;

bool MySearchCallback(int id, void* arg) 
{
	if (!list.head)
	{
		list.head = new Link;
		list.head->circle = circles[id];
		list.head->id = id;
		list.head->next = NULL;
		list.head->last = NULL;
		list.tail = list.head;
		list.num = 1;
	}
	else
	{
		Link *p = new Link, *q = list.head;
		p->circle = circles[id];
		p->id = id;
		double d = getDis(q->circle.center, search.center), d1 = getDis(p->circle.center, search.center);
		while (q->next && d1 >= d)
		{
			q = q->next;
			d = getDis(q->circle.center, search.center);
		}
		if (q->next || d1 < d)
		{
			//如果p要插入的位置不是最后一个
			if (q->last)
			{
				Link *temp;
				temp = q->last;
				temp->next = p;
				p->last = temp;
			}
			else 
			{
				list.head = p;
				p->last = NULL;
			}
			p->next = q;
			q->last = p;
		}
		else
		{
			//如果p要插入的位置是最后一个
			q->next = p;
			p->last = q;
			p->next = NULL;
			list.tail = p;
		}
		if (list.num == OUTPUTNUM)
		{
			list.tail = list.tail->last;
			delete list.tail->next;
			list.tail->next = NULL;
		}
		else
		{
			list.num++;
		}
	}
	return true; // keep going
}


void main()
{
	RTree<int, double, double> tree;
	int n;
	ifstream fin("color_feature.txt");
	fin >> n;
	circles = new Circle[n];
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

	int hits = tree.Search(search.center, search.R, MySearchCallback, NULL);

	Link *p = list.head, *q;
	while (p)
	{
		cout << p->id << endl;
		q = p;
		p = p->next;
		delete []q;
	}

	printf("Search resulted in %d hits\n", hits);

	delete []circles;
	getchar();
}
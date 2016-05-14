// LoadImage.cpp : Defines the entry point for the console application.
//

#define _AFXDLL
#include <afx.h>
#include <iostream>
#include "atlimage.h"
#include <tchar.h>
#include <fstream>
#include <vector>


using namespace std;

vector<double> color_histogram_RGB(char* inputfnam, int grpnum_R, int grpnum_G, int grpnum_B);

int init_image(char* ouputfname) {
	CFileFind files;
	fstream output(ouputfname);
	if (!output.is_open()) {cout << "Not found output file." << endl; return 1;}
	char* input = "image\\*.JPEG";
	BOOL res = files.FindFile(input);
	int i = 0;
	while(res)
	{
		i++;
		res = files.FindNextFile();
		input = "image\\" + files.getFileName();
		if(!files.IsDirectory() && !files.IsDots())//如果是文件
		{
			vector<double> feature_vector = color_histogram_RGB(input, 2, 2, 2);
			for (auto each: feature_vector) output << each << ' ';
			output << endl;
			cout << i << " file has done." << endl;
		}
	}
	output << i << endl;
	files.Close();
	cout << "successfully done." << endl;
	return 0;
}

vector<double> color_histogram_RGB(char* inputfname, int grpnum_R, int grpnum_G, int grpnum_B) {
	CImage image;
	

	int iHeight, iWidth;
	BYTE byteR, byteG, byteB;
	int r, g, b;
	int range_r = 256 / grpnum_R, range_g = 256 / grpnum_G, range_b = 256 / grpnum_B;
	if (256 % grpnum_R > 0) grpnum_R++;
	if (256 % grpnum_G > 0) grpnum_G++;
	if (256 % grpnum_B > 0) grpnum_B++;

	vector<double> featrue(grpnum_R*grpnum_G*grpnum_B,0);
	image.Load(inputfname);  

	iHeight = image.GetHeight();
	iWidth = image.GetWidth();

	for ( int iRow=0; iRow<iWidth; iRow++)
		for ( int iCol=0; iCol<iHeight; iCol++ )
		{
			COLORREF colorref = image.GetPixel( iRow, iCol );

			if ( colorref==CLR_INVALID )
			{
				printf("Out of range!");
				continue;
			}

			byteR =  GetRValue( colorref );
			byteG =  GetGValue( colorref );
			byteB =  GetBValue( colorref );


			//for (r = 0; r < grpnum_R; r++) {
			//	if (range_r*r <= byteR && byteR < range_r*(r+1)) break;
			//}

			//for (g = 0; g < grpnum_G; g++) {
			//	if (range_g*g <= byteG && byteG < range_g*(g+1)) break;
			//}

			//for (b = 0; b < grpnum_B; b++) {
			//	if (range_b*b <= byteB && byteB < range_b*(b+1)) break;
			//}

			r = byteR / range_r;
			g = byteG / range_g;
			b = byteB / range_b;

			featrue[r*grpnum_G*grpnum_B + g*grpnum_B + b] ++;

			//printf("%Pixel at (%d,%d) is: R=0x%x,G=0x%x,B=0x%x\n",iRow, iCol, byteR, byteG, byteB);			
		}

	image.GetBits();
	image.Destroy();

	//for (int i = 0; i <grpnum_R*grpnum_G*grpnum_B; i++) cout << featrue[i] << ' '; 
	//getchar();
	return featrue;
}


int color_histogram_cluster_RGB() {
	return 0;
}



int main()
{
	init_image("histgram.txt");
	getchar();
	return 0;
}

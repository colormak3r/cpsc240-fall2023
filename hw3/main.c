/* 
Program name: "Sort Array". This program sort an array using modular
components that manage, input, output and sort the array.
Copyright (C) <2023>  <Dang Khoa Nguyen>

This file is part of the software program "Sort Array".

Sort Array is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Sort Array is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>. 

Author information
  Author name : Dang Khoa Nguyen
  Author email: colormak3r@csu.fullerton.edu
  Author CWID : 885089755
*/

#include "stdio.h"

extern unsigned long *director();

int main()
{
    printf("Welcome to a great program developed by Dang Khoa Nguyen at colormak3r@csu.fullerton.edu.\n");

    unsigned long *mydata = director();
    unsigned long count = (unsigned long)mydata[0];     // First cell contains the count of the nicearray
    double **mynumbers = (double**)mydata[1];           // Second cell contains the address of the nicearray

    printf("The main function received this array\n");
    for (int i = 0; i < count; i++)
        printf("%1.2f\n", *(mynumbers[i]));
    
    // Ending sequence
    printf("Please consider buying more software from our suite of commercial programs.\n");
    printf("A zero will be returned to the operating system. Bye\n");

    return 0;
}
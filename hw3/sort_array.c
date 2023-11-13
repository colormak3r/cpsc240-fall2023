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

#include <stdbool.h>
#include <stdio.h>
 
void swap_pointers(double** elem1, double** elem2)
{
    double* temp = *elem1;
    *elem1 = *elem2;
    *elem2 = temp;
}

void sort_array(double *myarray[], unsigned long count)            
{   
    if (count == 0)
        return;  

    // Sort array using bubble sort
    int i, j;
    bool swapped;

    for (i = 0; i < count - 1; i++) {
        swapped = false;
        for (j = 0; j < count - i - 1; j++) {
            if (*myarray[j] > *myarray[j + 1]) {
                swap_pointers(&myarray[j], &myarray[j + 1]);
                swapped = true;
            }
        }

        // If no number is swapped, it means the array is sorted
        //  => break out of the loop
        if (!swapped)
            break;
    }
}
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

#include <iostream>
#include <iomanip>

extern "C" unsigned long* director();

using namespace std;

int main()
{
    cout << "Welcome to a great program developed by Dang Khoa Nguyen at colormak3r@csu.fullerton.edu." << endl;

    unsigned long* mydata = director();
    unsigned long count = (unsigned long)(mydata[0]);    // First cell contains the count of the nicearray
    double** mynumbers = (double**)(mydata[1]);     // Second cell contains the address of the nicearray

    cout << "The main function received this array" << endl;
    for (unsigned long i = 0; i < count; i++)
        cout << fixed << setprecision(2) << *(mynumbers[i]) << endl;
    
    cout << "Please consider buying more software from our suite of commercial programs." << endl;
    cout << "A zero will be returned to the operating system. Bye" << endl;

    return 0;
}
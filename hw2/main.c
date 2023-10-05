// Author: Dang Khoa Nguyen
// CWID: 885089755

// Disclaimer: This repository is for my personal use only. 
// You can research as you please, but DO NOT COPY WORD FOR WORD what I wrote. 
// Remember, I have the commit history to prove the timeline. 
// Avoid academic dishonesty.

#include "stdio.h"

extern unsigned long *manage();

int main()
{
    printf("Welcome to Array Management System\n");
    printf("This product is maintained by Dang Khoa Nguyen at colormak3r@csu.fullerton.edu\n\n");

    unsigned long *mydata = manage();
    unsigned long count = (unsigned long)mydata[0];     // First cell contains the count
    double *mynumbers = (double*)mydata[1];             // Second cell contains the address of the sendback array

    printf("The main function received this array\n");
    for (int i = 0; i < count; i++)
        printf("%1.2f\n", mynumbers[i]);
    
    // Ending sequence
    printf("Please consider buying more software from our suite of commercial programs.\n");
    printf("A zero will be returned to the operating system. Bye\n");

    return 0;
}
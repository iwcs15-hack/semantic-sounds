// Levenstein Distance Algorithms Module
//
// Contains functions to do "Inexact Alphanumeric Comparisons".  The original
// concept for this code came from "The C Users Journal", May 1991, starting
// on page 127.  The author was Hans Z. Zwakenberg.
//
// These routines have been modified so they do not need to use double
// subscripted arrays in the CUJ code.  An additional function was created to
// "look up" a word from a list, returning the most likely matches.
//
// Written initailly by R. Bruce Roberts, MCI Systems Engineering, 1/7/93
// Compiled with Borland C++, V3.1
//
//---------------------------------------------------------------------------
// Revision History:
//
// Date     Ini   Comments
// -------- ---   ---------------
// 30/07/03 DMJ   Made stand alone and tidyied up a few things
// 01/08/93 RBR   Module initially created and tested.
//
//---------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include "string.h"

#define MAX_LDIST_LEN      35 // max word len to compair

#define ADDITION           1  // penality for needing to add a character
#define CHANGE             1  // penality for needing to modify a character
#define DELETION           1  // penality for needing to delete a character

#define MIN(x, y) ((x < y) ? x : y)
#define SMALLEST_OF(x, y, z) ((x<y) ? MIN(x, z) : MIN(y, z))
#define ZERO_IF_EQUAL(ch1, ch2) ((ch1==ch2) ? 0 : CHANGE)

char str_1[MAX_LDIST_LEN],
     str_2[MAX_LDIST_LEN];
int len1,
    len2;

/*
 * Optimized for repeatedly calling with the same first string
 *
 * int lev_dist(char *str_1, int len_str_1, char *str_2)
 */
int lev_dist(void)
{
const int len1= strlen(str_1);
const int len2= strlen(str_2);
int i,
    j;
unsigned int dist_im1[MAX_LDIST_LEN+1];
unsigned int dist_i_j,
	     dist_i_jm1,
	     dist_j0;
char *p1,
     *p2;

dist_im1[0]=0;
for (i=1; i<=MAX_LDIST_LEN; i++)
   dist_im1[i] = dist_im1[i-1] + ADDITION;
   
dist_j0 = 0;
for (i=1, p1=str_1; i<=len1; i++, p1++)
   {
   dist_i_jm1 = dist_j0 += DELETION;
   for (j=1, p2=str_2; j<=len2; j++, p2++)
      {
      dist_i_j = SMALLEST_OF(dist_im1[j-1] + ZERO_IF_EQUAL(*p1, *p2),
                             dist_i_jm1    + ADDITION,
                             dist_im1[j]   + DELETION );
      dist_im1[j-1] = dist_i_jm1;
      dist_i_jm1 = dist_i_j;
      }
   dist_im1[j] = dist_i_j;
   }

return dist_i_j;
}


int main(void)
{
int max_len;
float str_dist;

scanf("%s %s ", str_1, str_2);

len1= strlen(str_1);
len2= strlen(str_2);
str_dist=lev_dist();

if (len1 < len2)
   max_len=len2;
else
   max_len=len1;

printf("%s,%s,%4.3f,%4.3f\n", str_1, str_2, str_dist, 1-str_dist/max_len);
}




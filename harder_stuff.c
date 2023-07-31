#include <stdio.h>
#include <math.h>

int sumr(int k);
int weekday(int day);
typedef struct;
void initArray(Array *a, size_t initialSize);
void insertArray(Array *a, int element);
void freeArray(Array *a);
void address(int num);
double add(int num, int num2);
double subt(int num, int num2);
double multi(int num, int num2);
double divi(int num, int num2);

int main() {
	int n, i, j, space, rows, k = 0, count = 0, count1 = 0, coef = 1, number = 1;
	char input, alphabet = 'A';
	
   // printf() displays the string inside quotation
   printf("Hello, World!");
   printf(multi(5,5));
   printf("%f", sqrt(16));
   printf("%f", ceil(1.4));
	printf("%f", floor(1.4));
   printf("%f", pow(4, 3));
   
	// dynamic array
	Array a;
	
	printf("Enter day number: ");
	scanf("%d",&n);
	weekday(n);

	initArray(&a, 5);  // initially 5 elements
	for (i = 0; i < 100; i++)
		insertArray(&a, i);  // automatically resizes as necessary
	printf("%d\n", a.array[9]);  // print 10th element
	printf("%d\n", a.used);  // print number of elements
	freeArray(&a);
	
	// break and continue
	// break - leaves loop
	// continue - breaks one iteration
	for (i = 0; i < 10; i++) {
  if (i == 4) {
    break;
  }
  printf("%d\n", i);
}

for (i = 0; i < 10; i++) {
  if (i == 4) {
    continue;
  }
  printf("%d\n", i);
}

   
   // half pyramid
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = 1; i <= rows; ++i) {
      for (j = 1; j <= i; ++j) {
         printf("* ");
      }
      printf("\n");
   }
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = 1; i <= rows; ++i) {
      for (j = 1; j <= i; ++j) {
         printf("%d ", j);
      }
      printf("\n");
   }

	printf("Enter an uppercase character you want to print in the last row: ");
   scanf("%c", &input);
   for (i = 1; i <= (input - 'A' + 1); ++i) {
      for (j = 1; j <= i; ++j) {
         printf("%c ", alphabet);
      }
      ++alphabet;
      printf("\n");
   }
   
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = rows; i >= 1; --i) {
      for (j = 1; j <= i; ++j) {
         printf("* ");
      }
      printf("\n");
   }
   
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = rows; i >= 1; --i) {
      for (j = 1; j <= i; ++j) {
         printf("%d ", j);
      }
      printf("\n");
   }
   
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = 1; i <= rows; ++i, k = 0) {
      for (space = 1; space <= rows - i; ++space) {
         printf("  ");
      }
      while (k != 2 * i - 1) {
         printf("* ");
         ++k;
      }
      printf("\n");
   }
   
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = 1; i <= rows; ++i) {
      for (space = 1; space <= rows - i; ++space) {
         printf("  ");
         ++count;
      }
      while (k != 2 * i - 1) {
         if (count <= rows - 1) {
            printf("%d ", i + k);
            ++count;
         } else {
            ++count1;
            printf("%d ", (i + k - 2 * count1));
         }
         ++k;
      }
      count1 = count = k = 0;
      printf("\n");
   }
   
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = rows; i >= 1; --i) {
      for (space = 0; space < rows - i; ++space)
         printf("  ");
      for (j = i; j <= 2 * i - 1; ++j)
         printf("* ");
      for (j = 0; j < i - 1; ++j)
         printf("* ");
      printf("\n");
   }
   
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = 0; i < rows; i++) {
      for (space = 1; space <= rows - i; space++)
         printf("  ");
      for (j = 0; j <= i; j++) {
         if (j == 0 || i == 0)
            coef = 1;
         else
            coef = coef * (i - j + 1) / j;
         printf("%4d", coef);
      }
      printf("\n");
   }
   printf("Enter the number of rows: ");
   scanf("%d", &rows);
   for (i = 1; i <= rows; i++) {
      for (j = 1; j <= i; ++j) {
         printf("%d ", number);
         ++number;
      }
      printf("\n");
   }
   
   return 0;
}



typedef struct {
  int *array;
  size_t used;
  size_t size;
} Array;

void initArray(Array *a, size_t initialSize) {
  a->array = malloc(initialSize * sizeof(int));
  a->used = 0;
  a->size = initialSize;
}

void insertArray(Array *a, int element) {
  // a->used is the number of used entries, because a->array[a->used++] updates a->used only *after* the array has been accessed.
  // Therefore a->used can go up to a->size 
  if (a->used == a->size) {
    a->size *= 2;
    a->array = realloc(a->array, a->size * sizeof(int));
  }
  a->array[a->used++] = element;
}

void freeArray(Array *a) {
  free(a->array);
  a->array = NULL;
  a->used = a->size = 0;
}

void address(int num) {
	int myNum = num;
	printf("%p", &myNum);
}

double multi(int num, int num2) {
	return num = num * num2;
}

double subt(int num, int num2) {
	return num = num - num2;
}

double add(int num, int num2) {
	return num = num + num2;
}

double divi(int num, int num2) {
	return num = num / num2;
}

int weekday(int day){
	switch (day) {
  case 1:
    printf("Monday");
    break;
  case 2:
    printf("Tuesday");
    break;
  case 3:
    printf("Wednesday");
    break;
  case 4:
    printf("Thursday");
    break;
  case 5:
    printf("Friday");
    break;
  case 6:
    printf("Saturday");
    break;
  case 7:
    printf("Sunday");
    break;
}
}

// recursion
int sumr(int k) {
  if (k > 0) {
    return k + sum(k - 1);
  } else {
    return 0;
  }
}


//abs(x)	Returns the absolute value of x
//acos(x)	Returns the arccosine of x
//asin(x)	Returns the arcsine of x
//atan(x)	Returns the arctangent of x
//cbrt(x)	Returns the cube root of x
//cos(x)	Returns the cosine of x
//exp(x)	Returns the value of Ex
//sin(x)	Returns the sine of x (x is in radians)
//tan(x)	Returns the tangent of an angle


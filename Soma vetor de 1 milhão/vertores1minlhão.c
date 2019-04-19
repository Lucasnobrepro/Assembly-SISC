#include <stdio.h>
#include <time.h>

int* soma(int* v1, int* v2);

int main(int argc, char const *argv[])
{
	int vet1 [1000000];

	int vet2 [1000000];

	for (int i = 0; i < 1000000; ++i)
	{
		vet1[i] = i+20;
		vet2[i] = i+30;
	}

	int* res;

	res = soma(vet1,vet2);

	for (int i = 0; i < 1000000; ++i)
	{
		/* code */
		printf("%d\n",*(res+i));
	}
	
	
	return 0;
}
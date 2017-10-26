/**
 *    Nada funciona aqui :D
 *    Vários seg fault :--D
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/**			Parte 1			**/

//" comparison between pointer and integers" erro
int size(float* vetor) {
	int result = (int)(sizeof(vetor)/sizeof((vetor)[0]) +1);
	return result;
}

float norma(float* vetor) {
	float soma = 0;
	int size1 = size(vetor);
	for (int i = 0; i < size; ++i)
		soma += vetor[i]*vetor[i];
	return sqrt(soma);
}

float* multEscalar(float* vetor, float escalar) {
	int size1 = size(vetor);
	for (int i = 0; i < size; ++i)
		vetor[i] *= escalar;
	return vetor;
}

float* adicionarVetores(float* v1, float* v2) {
	int size1 = size(v1);
	int size2 = size(v2);
	float vetor[size1];
	if (size1 != size2) return vetor;
	for (int i = 0; i < size1; ++i) {
		vetor[i] += v1[i] + v2[i];
	}
	return vetor;
}

float prodEscalar(float* v1, float* v2) {
	float produto = 0;
	int size1 = size(v1);
	int size2 = size(v2);
	if (size1 != size2) return produto;
	for (int i = 0; i < size1; ++i)
		produto += v1[i] * v2[i];
	return produto;
}

float* prodVetorial(float* v1, float* v2) {
	int size1 = size(v1);
	int size2 = size(v2);
	float vetor[size1];
	if (size1 != 3 ||  size2 != 3) return vetor;
	vetor[0] = (v1[1] * v2[2]) - (v2[1]*v1[2]);
	vetor[1] = (v1[0] * v2[2]) - (v2[0]*v1[2]);
	vetor[2] = (v1[0] * v2[1]) - (v2[0]*v1[1]);
	return vetor;
}

/**			Parte 2			**/

int main() {
	float v1[2] = {1,1};
	float v2[2] = {2,2};
	float v3* = adicionarVetores(v1, v2);
	printf("alo\n");
	printf("%lf\n", v3[0]);
}

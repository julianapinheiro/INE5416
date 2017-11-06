/**
 *	Relatório 8 - INE5416/2017.2
 * 	Juliana Silva Pinheiro
 *	16100735
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define size(x) (sizeof(x)/sizeof((x)[0]))+1 

/**			
	Parte 1 - Vetores
 */

float norma(const float* vetor) {
	float soma = 0;
	int size1 = size(vetor);
	for (int i = 0; i < size1; ++i)
		soma += vetor[i]*vetor[i];
	return sqrt(soma);
}

float* multVEscalar(float* vetor, const float escalar) {
	int size1 = size(vetor);
	for (int i = 0; i < size1; ++i)
		vetor[i] *= escalar;
	return vetor;
}

float* adicionarVetores(const float* v1, const float* v2) {
	int size1 = size(v1);
	int size2 = size(v2);
	float *vetor = malloc(size1);
	if (size1 != size2) return vetor;
	for (int i = 0; i < size1; ++i) {
		vetor[i] += v1[i] + v2[i];
	}
	return vetor;
}

float prodEscalar(const float* v1, const float* v2) {
	float produto = 0;
	int size1 = size(v1);
	int size2 = size(v2);
	if (size1 != size2) return produto;
	for (int i = 0; i < size1; ++i)
		produto += v1[i] * v2[i];
	return produto;
}

float* prodVetorial(const float* v1, const float* v2) {
	int size1 = size(v1);
	int size2 = size(v2);
	float *vetor = malloc(size1);
	if (size1 != 3 ||  size2 != 3) return vetor;
	vetor[0] = (v1[1] * v2[2]) - (v2[1]*v1[2]);
	vetor[1] = (v1[0] * v2[2]) - (v2[0]*v1[2]);
	vetor[2] = (v1[0] * v2[1]) - (v2[0]*v1[1]);
	return vetor;
}

void vtoString(const float* v) {
	int s = size(v);
	printf("{");
	for (int i = 0; i < s; ++i)
		if (i < s - 1) printf("%.0f, ", v[i]);
		else printf("%.0f", v[i]);
	printf("} \n");
}

/**			
	Parte 2 - Matrizes
 */

void mtoString(int linhas, int colunas, int m[linhas][colunas]) {
	for (int i = 0; i < linhas; ++i) {
		for (int j = 0; j < colunas; ++j) {
			printf("%d ", m[i][j]);
		}
		printf("\n");
	}
}

void toString(const int* v) {
	int s = size(v)+1;
	for (int i = 0; i < s; ++i) {
		if (i == s/2) printf("\n%d ", v[i]);
		else printf("%d ", v[i]);
	}
	printf("\n");
}

void transposta(int linhas, int colunas, int m[linhas][colunas]) {
	int aux;
	for (int i = 0; i < linhas/2; ++i) {
		for (int j = 0; j < colunas; ++j) {
			if (i != j) {
				aux = m[i][j];
				m[i][j] = m[j][i];
				m[j][i] = aux;
			}
		}
	}
}

void multMEscalar(int linhas, int colunas, int m[linhas][colunas],
					int e) {
	for (int i = 0; i < linhas; ++i)
		for (int j = 0; j < colunas; ++j)
			m[i][j] *= e;
}

int* adicionarMatrizes(int linhas, int colunas, int m1[linhas][colunas],
					int m2[linhas][colunas]) {
	int *matriz = (int *)malloc(linhas * colunas * sizeof(int));
	int offset = 0;
	for (int i = 0; i < linhas; ++i) {
		offset = i * linhas;
		for (int j = 0; j < colunas; ++j) {
			offset += j;
			matriz[offset] = m1[i][j] + m2[i][j];
		}
	}
	return matriz;
}

int* multMatrizes(int l1, int c1, int l2, int c2, int m1[l1][c1],
					int m2[l2][c2]) {
	int *matriz = (int *)calloc(l1*c2, l1 * c2 * sizeof(int));
	int offset;
	for (int i = 0; i < l1; ++i) {
		offset = i * l1;
		for (int j = 0; j < c2; ++j) {
			offset += j;
			for (int k = 0; k < c1; ++k) {
				matriz[offset] += m1[i][k] * m2[k][j];
			}
		}
	}
	return matriz;
}

// Apenas para matrizes 3x3, usando a regra de Sarrus, e 2x2
int determinante(int linhas, int colunas, int a[linhas][colunas]) {
	if (linhas == 3 && colunas == 3) {
		int primeiro_termo = a[0][0] * a[1][1] * a[2][2] +
						 	a[0][1] * a[1][2] * a[2][0] +
						 	a[0][2] * a[1][0] * a[2][1];
		int segundo_termo =  a[0][2] * a[1][1] * a[2][0] +
						 	a[0][0] * a[1][2] * a[2][1] +
						 	a[0][1] * a[1][0] * a[2][2];
		return primeiro_termo - segundo_termo;
	} else if (linhas == 2 && colunas == 2) {
		return a[0][0]*a[1][1] - a[0][1]*a[1][0];
	} else {
		return 0;
	}
}

/**
	Main
 */
int main() {
	// Testes de vetores

	float v1[3] = {1,2,3};
	float v2[3] = {3,2,1};
	float v3[1] = {1};
	printf("Norma(v1): %.3f \n", norma(v1));
	printf("Mult v1 por 2: ");
	vtoString(multVEscalar(v1,2));
	printf("Adicionar v1 e v2: ");
	vtoString(adicionarVetores(v1, v2));
	printf("Produto escalar v1 e v2: %.1f\n", prodEscalar(v1, v2));
	printf("Produto vetorial v1 e v2: ");
	vtoString(prodVetorial(v1,v2));

	// Testes de matrizes
	int m1[2][2] = {{1,1}, {1,2}};
	int m2[2][2] = {{1,1}, {1,1}};
	int m3[3][3] = {{1,3,1}, {1,1,2}, {2,3,4}};
	transposta(2,2,m1);
	multMEscalar(2,2,m1,3);
	int *m4 = adicionarMatrizes(2,2,m1, m2);
	int *m5 = multMatrizes(2,2,2,2,m1,m2);
	printf("Det(m1) %d\n", determinante(3,3,m3));
}	

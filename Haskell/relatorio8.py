'''
	Relatório 8 - INE5416/2017.2
	Juliana Silva Pinheiro
	16100735
'''

'''
	Parte 1 - Vetores
'''

def norma(vetor):
	soma = 0
	for i in vetor:
		soma += i**2
	return soma ** 1/2


def mult_vet_escalar(vetor, escalar):
	return [i * escalar for i in vetor]


def adicionar_vetores(v1, v2):
	if (len(v1) != len(v2)): return []
	return [v1[i] + v2[i] for i in range(len(v1))]


def prod_escalar(v1, v2):
	produto = 0
	if (len(v1) != len(v2)): return 0
	for i in range(len(v1)):
		produto += v1[i] * v2[i]
	return produto


def prod_vetorial(v1, v2):
	vetor = [0] * 3
	if (len(v1) != 3 or  len(v2) != 3): return vetor
	vetor[0] = (v1[1] * v2[2]) - (v2[1]*v1[2])
	vetor[1] = (v1[0] * v2[2]) - (v2[0]*v1[2])
	vetor[2] = (v1[0] * v2[1]) - (v2[0]*v1[1])
	return vetor

'''
	Parte 2 - Matrizes
'''

def transposta(a):
	return [list(i) for i in zip(*a)]

def mult_matriz_escalar(a, escalar):
	return [mult_vet_escalar(i, escalar) for i in a]

def adicionar_matrizes(a, b):
	if (len(a) != len(b)): return []
	return [adicionar_vetores(v1, v2) for v1, v2 in zip(a, b)]

def mult_matrizes(a, b):
	return [[sum(x*y for x,y in zip(a_row, b_col)) for b_col in zip(*b)] \
	for a_row in a]

# Apenas para matrizes 3x3, usando a regra de Sarrus, e 2x2
def determinante(a):
	if (len(a) == 3):
		primeiro_termo = a[0][0] * a[1][1] * a[2][2] + \
						 a[0][1] * a[1][2] * a[2][0] + \
						 a[0][2] * a[1][0] * a[2][1]
		segundo_termo =  a[0][2] * a[1][1] * a[2][0] + \
						 a[0][0] * a[1][2] * a[2][1] + \
						 a[0][1] * a[1][0] * a[2][2]
		return primeiro_termo - segundo_termo
	elif (len(a) == 2):
		return a[0][0]*a[1][1] - a[0][1]*a[1][0]
	else:
		return 0;

# Apenas para matrizes 3x3
def adjunta(a):
	adj = [[0 for x in range(3)] for y in range(3)]
	adj[0][0] = a[1][1]*a[2][2] - a[2][1]*a[1][2]
	adj[0][1] = a[1][0]*a[2][2] - a[2][0]*a[1][2]
	adj[0][2] = a[1][0]*a[2][1] - a[2][0]*a[1][1]
	adj[1][0] = a[0][1]*a[2][2] - a[2][1]*a[0][2]
	adj[1][1] = a[0][0]*a[2][2] - a[2][0]*a[0][2]
	adj[1][2] = a[0][0]*a[2][1] - a[2][0]*a[0][1]
	adj[2][0] = a[0][1]*a[1][2] - a[1][1]*a[0][2]
	adj[2][1] = a[0][0]*a[1][2] - a[1][0]*a[0][2]
	adj[2][2] = a[0][0]*a[1][1] - a[1][0]*a[0][1]
	for i in range(len(adj)):
		for j in range(len(adj[0])):
			adj[i][j] = adj[i][j]*(-1)**(i+j)
	return transposta(adj)

def inversa(a):
	return mult_matriz_escalar(adjunta(a), determinante(a)**(-1))

'''
	Main
'''
def main():
	# Testes de vetores
	vetor1 = [1,2,3]
	vetor2 = [3,2,1]
	print("Vetor 1: " + str(vetor1))
	print("Vetor 2: " + str(vetor2))
	print("Norma(vetor2): " + str(norma(vetor2)))
	print("Mult vetor 1 por 5: " + str(mult_vet_escalar(vetor1, 5)))
	print("Vetor 1 + Vetor 2: " + str(adicionar_vetores(vetor1, vetor2)))
	print("Produto escalar: " + \
		str(prod_escalar(vetor1, vetor2)))
	print("Produto vetorial: " + \
		str(prod_vetorial(vetor1, vetor2)))
	
	# Testes de matrizes
	A = [[1,1], [2,2]]
	B = [[3,3], [3,3]]
	C = [[1,3,1], [1,1,2], [2,3,4]]
	print("A: " + str(A))
	print("B: " + str(B))
	print("C: " + str(C))
	print("Transposta de A: " + \
		str(transposta(A)))
	print("Mult A por 2: " + \
		str(mult_matriz_escalar(A, 2)))
	print("Adicionar A e B: " + \
		str(adicionar_matrizes(A, B)))
	print("Multiplicar A e B: " + \
		str(mult_matrizes(A, B)))
	print("Determinante de C: " + \
		str(determinante(C)))
	print("Inversa de C: " + \
		str(inversa(C)))

if __name__ == '__main__':
	main()


#include <stdio.h>
#include <string.h>

int criptografia(char key,char* name);

int descriptografar(char key, char* name);

int main(){
	int opcao = 100;
	char name[100];
	char key;
		printf("1 - Para codificar:\n");
		printf("2 - Para decodificar:\n");
		scanf(" %i",&opcao);

		printf("Digite o nome do arquivo:");
		scanf(" %s",name);
		printf("Digite a chave:");
		scanf(" %c",&key);

		if(opcao == 1){
        	criptografia( key, name);
		}else if(opcao == 2){
		descriptografar( key, name);
		}	
	
return 0;
}

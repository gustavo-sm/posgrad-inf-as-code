# posgrad-inf-as-code
Tarefa pós-graduação para aplicação de práticas de IaC com Terraform.

## Arquitetura do trabalho:
![trabalho](https://user-images.githubusercontent.com/80229794/202351584-c5b8e045-8005-4e02-9e81-67b688ec57ff.png)

### **Configuração do projeto**:  
* Server01 (Run Deck – Debian) – **GCP**;
* Server02 (Jenkins – Amazon Linux) – **AWS**;
* Server03 (LAMP – Ubuntu) – **AWS**;
* Um bucket em cada provedor.

Para cada provedor escolhido, foram criadas duas pastas, um para cada provedor e seus respectivos recursos.

### **Passo a passo para execução do projeto**:

1) Na AWS, criar um usuário com acesso programático e fazendo parte de um grupo com as seguintes as roles **AmazonEC2FullAccess** e **AmazonS3FullAccess**.
No GCP, deve-se criar um projeto novo e uma conta de serviço com permissões de acesso ao **compute engine** e **storage**.

![image](https://user-images.githubusercontent.com/80229794/203906523-2c6e241e-ac69-4114-bdc7-2ad61ee3042d.png)

Após a criação, um JSON será baixado, renomeie-o para “**credentials.json**” e então, mova-o 	para o diretório ~/.gcp (criar caso não exista).

2) Estamos lidando com 2 provedores cloud, então as credenciais devem ser armazenadas da 	seguinte forma, para a AWS, caso não possua o CLI, deve-se criar dois arquivos (credentials e config) no diretório ~/.aws, com as informações do usuário que serão utilizadas, respectivamente:

![image](https://user-images.githubusercontent.com/80229794/203906293-190607d9-04f6-4b7d-b5bd-3c21d7277676.png)

![image](https://user-images.githubusercontent.com/80229794/203906306-c328b4b4-697a-4d4b-b977-cbb863c3b6bb.png)

*Descrever o nome do profile e então caso utilize algo diferente de default, alterar o atributo profile 	no provider “aws”, no arquivo provider.tf. 

A autenticação para o GCP acontecerá com base no credentials.json conforme descrito no passo 1.


3) Clonar o projeto, e então, no diretório do projeto, entrar no diretorio 	gcp/modules/variables, editar os arquivos vm-user.tf e project.tf, colocando o nome de usuário da 	sua conta na variavel vm-user e ID de seu projeto na variavel project_id. 


4) Executar os comandos **terraform -chdir=aws init** e **terraform -chdir=gcp init** para a inicialização dos modulos de ambos os provedores.


5) Executar **terraform -chdir=aws plan** e **terraform -chdir=gcp plan** para conferir as infraestruturas a serem criadas.


6)  Aplicar com **terraform -chdir=aws apply** e **terraform -chdir=gcp apply**.

Observação: durante a criação das instâncias de VM (ec2 e compute engine), as chaves privadas 	serão armazenadas da seguinte maneira localmente: 	<dir_do_provedor>/keys/instance_key_<id_da_chave>*

*o par de chaves está sendo criado com o recurso **tls_private_key**, ao executar o destroy nas instancias, a chave também será deletada do diretorio keys/ local.

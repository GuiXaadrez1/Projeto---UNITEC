import psycopg2
import pprint

def conf_conexao():
    try:

        connection = psycopg2.connect(
            user="postgres",
            password=input("Digite a Senha do Banco:"),
            host="localhost",
            port="5432",
            database="unitec"
        )
        
        cursor = connection.cursor()
        print("Conexão com PostgreSQL estabelecida com sucesso")

        # Executar uma consulta
        #cursor.execute("SELECT * FROM pessoa")
        #cursor.execute("SELECT * FROM login_aluno;")
        #records = cursor.fetchall()  # Pega todas as linhas da tabela

        # Pega o nome das colunas da tabela
        #colunas = [desc[0] for desc in cursor.description]

        # Exibe o cabeçalho da tabela
        #print(f"{' | '.join(colunas)}")
        #print('-' * 50)  # Uma linha separadora

        # Exibe os registros formatados
        #for record in records:
            #print(" | ".join(map(str, record)))

    except (Exception, psycopg2.Error) as error:
        print("Erro ao conectar ao PostgreSQL", error)
        cursor.close()
        connection.close()
        print("Conexão com PostgreSQL fechada")
            
            

# Chama a função
#conexao()

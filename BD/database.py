import psycopg2


def conf_conexao():
    try:
        connection = psycopg2.connect(
            user="postgres",
            password="32481024",
            host="localhost",
            port="5432",
            database="unitec"
        )
        print("Conexão com PostgreSQL estabelecida com sucesso")
        return connection  # Retorna a conexão
    except (Exception, psycopg2.Error) as error:
        print("Erro ao conectar ao PostgreSQL", error)
        raise  # Relança o erro para tratamento externo


def inserir_pessoa(connection, nome, telefone, email, cpf, rg):
    try:
        # Cria o cursor a partir da conexão
        cursor = connection.cursor()
        query = "INSERT INTO pessoa (nome, telefone, email, cpf, rg) VALUES (%s, %s, %s, %s, %s);"
        cursor.execute(query, (nome, telefone, email, cpf, rg))
        connection.commit()  # Confirma a transação
    except Exception as e:
        print(f"Erro ao inserir pessoa: {e}")
        connection.rollback()  # Reverte em caso de erro
    finally:
        cursor.close()  # Garante que o cursor será fechado

from flask import Blueprint, render_template

home_route = Blueprint('index',__name__) 

@home_route.route('/index')
def index():
    return render_template('index.html')

'''
Leia o arquivo Blueprint.txt pata você entender como funciona o Bluprint no Flask
    Basicamente funciona como se fosse o decorador @app.route('<diretório_nome ou símbolo>')
    Porém um pouco diferente.

    Veja! 
            # inicializando flask
        app = Flask(__name__)
        # "mydb: Estabelece a conexão com o banco de dados utilizando a função conf_conexao()."
        mydb = conf_conexao()

        # @ é um decorador que define as rotas (caminhos na URL) da aplicação.
        @app.route('/') # o diretório raiz da nossa página web
        def raiz(): #função que retonar um página na web
        return '<h1><strong>Você está na raiz<strong><h1>'
'''
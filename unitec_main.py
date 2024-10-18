# importando módulos flask, suas bibliotecas e nossos módulos
from flask import Flask
''' 
render_template: é usado para renderizar páginas HTML do diretório 'templates'.
request: é utilizado para obter dados de requisições HTTP (como formulários e parâmetros).
jsonify: converte dados Python para o formato JSON, retornando como resposta na API.
BD: módulo que criei para o nosso banco de dados
'''
from flask import render_template, request, jsonify

from BD.database import conf_conexao

from routes.login import login_route
from routes.recuperar_pw import recuperar_pw_route
from routes.home  import home_route

# inicializando flask
app = Flask(__name__)
# "mydb: Estabelece a conexão(local) com o banco de dados(local) utilizando a função conf_conexao()."
mydb = conf_conexao()

# @ é um decorador que define as rotas (caminhos na URL) da aplicação.
@app.route('/')
def raiz():
    return '<h1><strong>Você está na raiz<strong><h1>'

# Registrando os Blueprint no arquivo principal

app.register_blueprint(login_route)
app.register_blueprint(recuperar_pw_route)
app.register_blueprint(home_route)

# Ativando o modo desenvolvedor e iniciando o servidor local
if(__name__ ==  '__main__'):
    app.run(debug = True)
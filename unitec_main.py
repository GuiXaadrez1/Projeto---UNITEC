# importando módulos flask
from flask import Flask
''' 
render_template é usado para renderizar páginas HTML do diretório 'templates'.
request é utilizado para obter dados de requisições HTTP (como formulários e parâmetros).
jsonify converte dados Python para o formato JSON, retornando como resposta na API.
'''
from flask import render_template, request, jsonify

# inicializando flask
app = Flask(__name__)

# @ é um decorador que define as rotas (caminhos na URL) da aplicação.
@app.route('/')
def index():
    return 'HELLOW WOLD'



# Ativando o modo desenvolvedor e iniciando o servidor local
if(__name__ ==  '__main__'):
    app.run(debug = True)
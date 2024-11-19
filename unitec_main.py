# importando módulos flask, suas bibliotecas e nossos módulos
from flask import Flask

''' 
request: é utilizado para obter dados de requisições HTTP (como formulários e parâmetros).
BD: módulo que criei para o nosso banco de dados
'''
from flask import render_template, request, jsonify

from BD.database import conf_conexao

# Importando diretamente na pasta routes as variáveis que comportam as blueprints!
from routes.raiz import raiz_route
from routes.login import login_route
from routes.recuperar_pw import recuperar_pw_route
from routes.home  import home_route
from routes.admin import admin_route
from routes.materia import materia_route
from routes.atividade import atividade_route
from routes.perfil_aluno import perfil_aluno_route
from routes.postar_atividade import post_atividade_route
# inicializando flask
app = Flask(__name__)
# "mydb: Estabelece a conexão(local) com o banco de dados(local) utilizando a função conf_conexao()."
mydb = conf_conexao()

# @ é um decorador que define as rotas (caminhos na URL) da aplicação.
'''
@app.route('/')
def raiz():
    return '<h1><strong>Você está na raiz<strong><h1>'
'''
# Registrando os Blueprint no arquivo principal, vamos usar muito no projeto!
app.register_blueprint(raiz_route)

app.register_blueprint(login_route, url_prefix = '/login')
app.register_blueprint(recuperar_pw_route, url_prefix ='/recuperar_senha')
app.register_blueprint(home_route, url_prefix = '/home')
app.register_blueprint(admin_route, url_prefix ='/admin')
app.register_blueprint(materia_route, url_prefix = '/')
app.register_blueprint(atividade_route, url_prefix='/materias')
app.register_blueprint(perfil_aluno_route, url_prefix ='/perfil_aluno')
app.register_blueprint(post_atividade_route, url_prefix='/atividades')
# Ativando o modo desenvolvedor e iniciando o servidor local
if(__name__ ==  '__main__'):
    app.run(debug = True)
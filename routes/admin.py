from flask import Blueprint, render_template, redirect, url_for

admin_route = Blueprint('admin',__name__)

@admin_route.route('/')
def admin_raiz():
     return "Tela_painel_admin"
     
@admin_route.route('/cadastrar_pessoa')
def cadastro_pessoa():
     return render_template('cadastro_pessoa.html')
 
@admin_route.route('/cadastrar_admin')
def cadastro():
    return render_template('cadastro_admin.html')


from flask import Blueprint, render_template

# vaiavél que comporta a função que cria Blueprint
usuarios_route = Blueprint('usuarios',__name__) 
                            #nome_agrupamento
@usuarios_route.route('/usuarios')
def usuarios():
    ls_us=[
        {"nome":"João"},
        {"nome":"Maria"},
        {"nome":"Pedro"},
        {"nome":"Guilherme"}
        ]                                                  
    return render_template('lista_us.html',lista = ls_us)
    # x = variável de contexto que vai ser chamada no html 

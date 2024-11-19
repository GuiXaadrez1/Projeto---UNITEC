from flask import Blueprint, render_template, redirect, url_for

post_atividade_route = Blueprint('postar_atividade',__name__)

@post_atividade_route.route('/postar')
def postar_atividade():
     return render_template('postar_atividade.html')
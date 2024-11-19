from flask import Blueprint, render_template, redirect, url_for

atividade_route = Blueprint('atividade',__name__)


@atividade_route.route('/atividades')
def atividades():
     return render_template('tela_atividades.html')


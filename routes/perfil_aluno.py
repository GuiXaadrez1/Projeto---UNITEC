from flask import Blueprint, render_template

perfil_aluno_route = Blueprint('aluno',__name__)

@perfil_aluno_route.route('/')
def perfil_aluno():
    return render_template('perfil_aluno.html')
from flask import Blueprint, render_template

perfil_professor_route = Blueprint('perfil_professor',__name__)

@perfil_professor_route.route('/')
def perfil():
    return render_template('perfil_professor.html')

@perfil_professor_route.route('/editar')
def editar():
    return render_template('perfil_professor_editar.html')
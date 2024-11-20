from flask import Blueprint, render_template, redirect, url_for

materia_route = Blueprint('materia',__name__)

@materia_route.route('/materia')
def materias():
     return render_template('tela_materia.html')
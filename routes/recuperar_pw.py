from flask import Blueprint, render_template

recuperar_pw_route = Blueprint('recuperar_senha',__name__)

@recuperar_pw_route.route('/recuperar_senha')
def recuperar_senha():
    return render_template('recuperar_senha.html')
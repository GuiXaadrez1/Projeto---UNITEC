from flask import Blueprint, render_template

# vaiavél que comporta a função que cria Blueprint
login_route = Blueprint('login',__name__) 
                        
@login_route.route('/login')
def login():                                                 
    return render_template('login.html')
    
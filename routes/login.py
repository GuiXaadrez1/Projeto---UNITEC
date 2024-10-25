from flask import Blueprint, render_template, request
# vaiavél que comporta a função que cria Blueprint
login_route = Blueprint('login',__name__) 
                        
@login_route.route('/')
def login():                                                 
    return render_template('login.html')
    
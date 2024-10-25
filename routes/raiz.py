from flask import Blueprint

raiz_route = Blueprint('raiz',__name__)

@raiz_route.route('/')
def login():                                                 
    return "<h1> Você está na raiz do website <h1>"

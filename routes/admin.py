from flask import Blueprint, render_template, redirect, url_for, request, flash
from BD.database import inserir_pessoa, conf_conexao

mydb = conf_conexao()

admin_route = Blueprint('admin',__name__)

@admin_route.route('/')
def admin_raiz():
     return "Tela_painel_admin"
     
@admin_route.route('/cadastrar_pessoa', methods=['GET', 'POST'])
def cadastro_pessoa():
    if request.method == 'POST':
        # Captura os dados do formulário
        nome = request.form.get('nome')
        telefone = request.form.get('telefone')
        email = request.form.get('email')
        cpf = request.form.get('cpf')
        rg = request.form.get('rg')

        # Valida os dados antes de inserir no banco
        if not nome or not telefone or not cpf or not rg:
            flash('Todos os campos são obrigatórios!', 'error')
            return render_template('cadastro_pessoa.html')

        # Inserir no banco de dados (chama sua função)
        try:
            inserir_pessoa(mydb, nome, telefone, email, cpf, rg)  # Adiciona a conexão como primeiro argumento
            flash('Pessoa cadastrada com sucesso!', 'success')
            return redirect(url_for('admin.cadastro_pessoa'))  # Redireciona para evitar reenvio do formulário
        except Exception as e:
            flash(f'Ocorreu um erro: {e}', 'error')
            return render_template('cadastro_pessoa.html')

    # Renderiza o formulário para GET
    return render_template('cadastro_pessoa.html')
 
@admin_route.route('/cadastrar_admin')
def cadastro():
    return render_template('cadastro_admin.html')


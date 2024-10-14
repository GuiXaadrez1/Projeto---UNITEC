CREATE TABLE pessoa(
	id_pessoa SERIAL PRIMARY KEY,
	nome VARCHAR(45) NOT NULL,
	telefone VARCHAR(45) NOT NULL,
	email VARCHAR(75) NOT NULL,
	cpf CHAR(11) NOT NULL UNIQUE,
	rg CHAR(20) NOT NULL UNIQUE
);


CREATE TABLE administrador (
	id_admin SERIAL PRIMARY KEY,
	id_pessoa INT NOT NULL,
	senha_hash VARCHAR(255) NOT NULL UNIQUE,
	nivel_acesso VARCHAR(20) DEFAULT 'Maximo' CHECK (nivel_acesso IN ('Maximo')),
	FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE semestre(
	id_semestre SERIAL PRIMARY KEY,
	id_admin INT NOT NULL,
	data_semestre TIMESTAMP DEFAULT NOW(),
	nome_semestre VARCHAR(20),
	FOREIGN KEY (id_admin) REFERENCES administrador(id_admin)
);

CREATE TABLE forum(
	id_forum SERIAL PRIMARY KEY,
	id_admin INT NOT NULL,
	id_semestre INT NOT NULL,
	FOREIGN KEY (id_admin) REFERENCES administrador(id_admin),
	FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre)
);

CREATE TABLE curso(
	id_curso SERIAL PRIMARY KEY,
	id_admin INT NOT NULL,
	id_semestre INT NOT NULL,
	nome_curso VARCHAR(45),
	FOREIGN KEY (id_admin) REFERENCES administrador(id_admin),
	FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre)
);

CREATE TABLE turma(
	id_turma SERIAL PRIMARY KEY,
	id_admin INT NOT NULL,
	id_semestre INT NOT NULL,
	id_curso INT NOT NULL,
	nome_turma VARCHAR(45),
	FOREIGN KEY (id_admin) REFERENCES administrador(id_admin),
	FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre),
	FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE disciplina(
	id_disciplina SERIAL PRIMARY KEY,
	id_admin INT NOT NULL,
	id_semestre INT NOT NULL,
	id_curso INT NOT NULL,
	id_turma INT NOT NULL,
	nome_disciplina VARCHAR(45),
	FOREIGN KEY (id_admin) REFERENCES administrador(id_admin),
	FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre),
	FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
	FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

CREATE TABLE professor(
	id_professor SERIAL PRIMARY KEY,
	id_pessoa INT NOT NULL,
	id_forum INT NOT NULL,
	id_semestre INT NOT NULL,
	matricula_proof VARCHAR(25) NOT NULL UNIQUE,
	senha_hash VARCHAR(255) NOT NULL UNIQUE,
	nivel_acesso VARCHAR(20) DEFAULT 'Medio' CHECK (nivel_acesso IN ('Medio')),
	FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
	FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre),
	FOREIGN KEY (id_forum) REFERENCES forum(id_forum)
);

CREATE TABLE professor_disciplina(
	id_professor INT NOT NULL,
	id_disciplina INT NOT NULL,
	PRIMARY KEY(id_professor, id_disciplina),
	FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
	FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE aluno(
	id_aluno SERIAL PRIMARY KEY,
	id_pessoa INT NOT NULL,
	id_curso INT NOT NULL,
	id_turma INT NOT NULL,
	id_semestre INT NOT NULL,
	id_forum INT NOT NULL,
	matricula_aluno VARCHAR(25),
	nivel_acesso VARCHAR(20) DEFAULT 'Minimo' CHECK (nivel_acesso IN ('Minimo')),
	senha_hash VARCHAR(255),
	FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
	FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
	FOREIGN KEY (id_turma) REFERENCES turma(id_turma),
	FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre),
	FOREIGN KEY (id_forum) REFERENCES forum(id_forum) 
);

CREATE TABLE notas(
	id_notas SERIAL PRIMARY KEY,
	id_aluno INT NOT NULL,
	id_professor INT NOT NULL,
	id_disciplina INT NOT NULL,
	data_registro_nota TIMESTAMP DEFAULT NOW(),
	valor_nota DECIMAL(5, 2) NOT NULL DEFAULT 0 CHECK(valor_nota >= 0),
	FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
	FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
	FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE faltas(
	id_faltas SERIAL PRIMARY KEY,
	id_aluno INT NOT NULL,
	id_professor INT NOT NULL,
	id_disciplina INT NOT NULL,
	data_registro_falta TIMESTAMP DEFAULT NOW(),
	data_falta DATE DEFAULT CURRENT_DATE,
	status VARCHAR(20) NOT NULL CHECK (status IN ('Presente', 'Ausente')),
	quantidade INT NOT NULL DEFAULT 0 CHECK (quantidade >= 0),
	FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
	FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
	FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE atividade(
	id_atividade SERIAL PRIMARY KEY, 
	id_aluno INT, -- Permite que a atividade exista antes de um aluno ser associado
	id_professor INT NOT NULL,	
	tipo_atividade VARCHAR(20) CHECK (tipo_atividade IN ('Leitura','Exercício','Trabalho','Prova','Video')),
	material_atividade VARCHAR(20) CHECK (material_atividade IN ('PDF','Txt','Word','Img','Video')),
	data_criacao TIMESTAMP DEFAULT NOW(),
	data_entrega TIMESTAMP,
	FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
	FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

CREATE TABLE comentario (
    id_comentario SERIAL PRIMARY KEY,
    id_forum INT NOT NULL,
    id_aluno INT,
    id_professor INT,
    conteudo TEXT NOT NULL,
    data_comentario TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (id_forum) REFERENCES forum(id_forum),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
    CHECK (
        (id_aluno IS NOT NULL AND id_professor IS NULL) OR
        (id_professor IS NOT NULL AND id_aluno IS NULL)
    )
);

CREATE TABLE login_admin(
	id_login SERIAL PRIMARY KEY,
	id_admin INT NOT NULL,
	data_login TIMESTAMP DEFAULT NOW(),
	nome_admin VARCHAR(45) NOT NULL,
	FOREIGN KEY (id_admin) REFERENCES administrador(id_admin)
);

CREATE TABLE login_professor(
	id_login SERIAL PRIMARY KEY,
	id_professor INT NOT NULL,
	data_login TIMESTAMP DEFAULT NOW(),
	nome_professor VARCHAR(45) NOT NULL,
	matricula_proof VARCHAR(25) NOT NULL UNIQUE,
	FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

CREATE TABLE login_aluno(
	id_login SERIAL PRIMARY KEY,
	id_aluno INT NOT NULL,
	data_login TIMESTAMP DEFAULT NOW(),
	nome_aluno VARCHAR(45) NOT NULL,
	matricula_aluno VARCHAR(25) NOT NULL UNIQUE,
	FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

CREATE TABLE historico_login (
	id_historico SERIAL PRIMARY KEY,
	id_login_admin INT,
	id_login_professor INT,
	id_login_aluno INT,
	data_login TIMESTAMP DEFAULT NOW(),
	nome_usuario VARCHAR(45) NOT NULL,
	FOREIGN KEY (id_login_admin) REFERENCES login_admin(id_login),
	FOREIGN KEY (id_login_professor) REFERENCES login_professor(id_login),
	FOREIGN KEY (id_login_aluno) REFERENCES login_aluno(id_login),
	CHECK (
		(id_login_admin IS NOT NULL AND id_login_professor IS NULL AND id_login_aluno IS NULL) OR
		(id_login_professor IS NOT NULL AND id_login_admin IS NULL AND id_login_aluno IS NULL) OR
		(id_login_aluno IS NOT NULL AND id_login_admin IS NULL AND id_login_professor IS NULL)
	)
);


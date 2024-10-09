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
	comentario VARCHAR(255),
	data_comentario TIMESTAMP DEFAULT NOW(),
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

SELECT * FROM pessoa;

INSERT INTO pessoa (nome, telefone, email, cpf, rg) VALUES
('Renato Silva', '61991543224', 'renato.silva@gmail.com', '12345678911', '123458'),
('Maria Oliveira', '61991654321', 'maria.oliveira@gmail.com', '23456789112', '234567'),
('Carlos Pereira', '61991765432', 'carlos.pereira@gmail.com', '34567891213', '345678'),
('Ana Souza', '61991876543', 'ana.souza@gmail.com', '45678912314', '456780'),
('Lucas Santos', '61991987654', 'lucas.santos@gmail.com', '56789123415', '567891'),
('Juliana Costa', '61992098765', 'juliana.costa@gmail.com', '67891234516', '678902'),
('Fernando Almeida', '61992109876', 'fernando.almeida@gmail.com', '78912345617', '789013'),
('Mariana Lima', '61992210987', 'mariana.lima@gmail.com', '89123456718', '890124'),
('Roberto Ferreira', '61992321098', 'roberto.ferreira@gmail.com', '91234567819', '901235'),
('Patrícia Rocha', '61992432109', 'patricia.rocha@gmail.com', '02345678920', '012346'),
('Gustavo Martins', '61992543210', 'gustavo.martins@gmail.com', '13456789021', '123457'),
('Fernanda Nascimento', '61992654321', 'fernanda.nascimento@gmail.com', '24567890122', '234568'),
('Tiago Mendes', '61992765432', 'tiago.mendes@gmail.com', '35678901223', '345679'),
('Tatiane Carvalho', '61992876543', 'tatiane.carvalho@gmail.com', '46789012324', '456781'),
('Leonardo Silva', '61992987654', 'leonardo.silva@gmail.com', '57890123425', '567892'),
('Guilherme Henrique','61991543213','guix1@gmail.com','12345678912','123456');

SELECT * FROM pessoa;
SELECT * FROM pessoa WHERE nome = 'Guilherme Henrique';

-- DEELETANDO TODOS OS DADOS DA TABELA PESSOA
DELETE FROM pessoa;

-- Verificar o último valor da sequência da PRIMARY KEY
SELECT LAST_VALUE FROM pessoa_id_pessoa_seq;

-- Reiniciar a sequência
ALTER SEQUENCE pessoa_id_pessoa_seq RESTART WITH 1;

-- Opcional: Verificar o novo valor da sequência
SELECT nextval('pessoa_id_pessoa_seq');

INSERT INTO administrador (id_pessoa, senha_hash)
SELECT id_pessoa, md5('123457')
FROM pessoa
WHERE cpf = '12345678911';

CREATE VIEW dados_admin AS 
	SELECT p.*, ad.nivel_acesso, ad.senha_hash FROM pessoa AS p
	INNER JOIN administrador AS ad 
	ON (p.id_pessoa = ad.id_pessoa);

DROP VIEW dados_admin;

-- DEELETANDO TODOS OS DADOS DA TABELA PESSOA
DELETE FROM pessoa;

-- Verificar o último valor da sequência da PRIMARY KEY
SELECT LAST_VALUE FROM pessoa_id_pessoa_seq;

-- Reiniciar a sequência
ALTER SEQUENCE pessoa_id_pessoa_seq RESTART WITH 1;

-- Opcional: Verificar o novo valor da sequência
SELECT nextval('pessoa_id_pessoa_seq');

-- DROP TABLE administrador;

-- Exemplo de inserções e seleção

/*
INSERT INTO pessoa(nome, telefone, email, cpf, rg)
VALUES ('Renato', '61991543224', 'renatimx1delas@gmail.com', '12345678911', '123457');

SELECT * FROM pessoa;

INSERT INTO administrador (id_pessoa, senha_hash)
SELECT id_pessoa, md5('123457')
FROM pessoa
WHERE cpf = '12345678911';

SELECT * FROM administrador;

CREATE VIEW dados_admin AS 
	SELECT p.*, ad.nivel_acesso, ad.senha_hash FROM pessoa AS p
	INNER JOIN administrador AS ad 
	ON (p.id_pessoa = ad.id_pessoa);

UPDATE administrador SET senha_hash = md5('123456') WHERE id_admin = 1;
*/

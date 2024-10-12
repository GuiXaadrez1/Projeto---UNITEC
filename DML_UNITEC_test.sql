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

/*
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
*/

INSERT INTO administrador (id_pessoa, senha_hash)
SELECT id_pessoa, md5('123457')
FROM pessoa
WHERE cpf = '12345678911';

CREATE VIEW dados_admin AS 
	SELECT p.*, ad.nivel_acesso, ad.senha_hash FROM pessoa AS p
	INNER JOIN administrador AS ad 
	ON (p.id_pessoa = ad.id_pessoa);

-- DROP VIEW dados_admin;

-- DEELETANDO TODOS OS DADOS DA TABELA PESSOA
-- DELETE FROM pessoa;

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

SELECT * FROM administrador;
SELECT * FROM semestre;


/*INSERINDO o ADMIN QUE CRIOU O SEMESTRE*/
INSERT INTO semestre(id_admin,nome_semestre)
	SELECT id_admin,'Primeiro Semestre'
		FROM administrador
			WHERE id_admin = 1;

/*
--DELETE FROM semestre corrigindo sequencia da primary key;
ALTER SEQUENCE semestre_id_semestre_seq  RESTART WITH 1;
SELECT LAST_VALUE FROM semestre_id_semestre_seq;
*/

SELECT * FROM administrador;

-- INSERINDO Forum, semestre que ele pertence e o administrador que criou ele
INSERT INTO forum (id_admin,id_semestre)
	SELECT ad.id_admin, s.id_semestre FROM administrador AS ad
	INNER JOIN semestre AS s ON(ad.id_admin = s.id_admin)
	WHERE ad.id_admin = 1;

CREATE VIEW admin_criou_forum AS
		SELECT f.id_forum, ad.id_admin AS num_admin, p.nome AS nome_admin, s.nome_semestre AS forum_semestre
			FROM forum AS f 
				INNER JOIN administrador AS ad ON(f.id_admin = ad.id_admin)
				JOIN semestre AS s ON(f.id_semestre = s.id_semestre)
				JOIN pessoa AS p ON(p.id_pessoa = ad.id_pessoa);

SELECT * FROM curso;

-- INSERINDO o curso, o admin, o semestre e o nome dele
INSERT INTO curso (id_admin,id_semestre,nome_curso)
	SELECT ad.id_admin, s.id_semestre, 'Banco de Dados' 
		FROM administrador AS ad
		JOIN semestre AS s ON( ad.id_admin = s.id_admin)
		WHERE admin = 1;
		
CREATE VIEW admin_criou_curso AS  
		SELECT c.id_curso AS num_curso, ad.id_admin AS num_admin, p.nome AS nome_admin, s.nome_semestre AS semestre_curso FROM curso AS c
		JOIN administrador AS ad ON(ad.id_admin = c.id_admin)
		JOIN semestre AS s ON(c.id_semestre = s.id_semestre)
		JOIN pessoa AS p ON(p.id_pessoa = ad.id_pessoa);
		
SELECT * FROM turma;

INSERT INTO turma(id_admin,id_semestre,id_curso, nome_turma)
SELECT ad.id_admin,s.id_semestre,c.id_curso,'A406'
	FROM administrador AS ad
	JOIN curso AS c ON (c.id_admin = ad.id_admin)
	JOIN semestre AS s 	ON (s.id_admin = ad.id_admin)
	WHERE ad.id_admin = 1;
	
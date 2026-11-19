-- ============================================================
-- DDL do Sistema de Controle de Academia de Ginástica
-- Atividade Formativa de Engenharia de Software - UniRuy Wyden
-- SGBD: MySQL 8.0 ou superior (versões antigas ignoram CHECK)
-- Atenção: o DROP DATABASE abaixo apaga um banco "academia" existente.
-- ============================================================

DROP DATABASE IF EXISTS academia;
CREATE DATABASE academia
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE academia;

-- ATIVIDADE
CREATE TABLE ATIVIDADE (
  idATIVIDADE INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(60) NOT NULL,
  PRIMARY KEY(idATIVIDADE)
);

-- INSTRUTOR
CREATE TABLE INSTRUTOR (
  idINSTRUTOR INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  rg VARCHAR(20) NOT NULL UNIQUE, -- RN12: RG único
  nome VARCHAR(100) NOT NULL,
  data_nascimento DATE NOT NULL,
  titulacao VARCHAR(50) NOT NULL,
  PRIMARY KEY(idINSTRUTOR)
);

-- TELEFONE_INSTRUTOR (RN14: um instrutor pode ter vários telefones)
CREATE TABLE TELEFONE_INSTRUTOR (
  numero VARCHAR(20) NOT NULL,
  INSTRUTOR_idINSTRUTOR INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(numero, INSTRUTOR_idINSTRUTOR),
  FOREIGN KEY(INSTRUTOR_idINSTRUTOR)
    REFERENCES INSTRUTOR(idINSTRUTOR)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- ALUNO
CREATE TABLE ALUNO (
  cod_matricula INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- RN13
  data_matricula DATE NOT NULL,
  nome VARCHAR(100) NOT NULL,
  endereco VARCHAR(150) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  data_nascimento DATE NOT NULL,
  altura DECIMAL(3,2) NOT NULL CHECK (altura > 0),
  peso DECIMAL(5,2) NOT NULL CHECK (peso > 0),
  PRIMARY KEY(cod_matricula)
);

-- TURMA
-- O número de alunos não é coluna: é calculado pelas matrículas (RN10).
CREATE TABLE TURMA (
  idTURMA INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  INSTRUTOR_idINSTRUTOR INTEGER UNSIGNED NOT NULL, -- RN02
  ATIVIDADE_idATIVIDADE INTEGER UNSIGNED NOT NULL, -- RN01
  horario TIME NOT NULL,
  duracao_min INTEGER UNSIGNED NOT NULL CHECK (duracao_min > 0),
  data_inicio DATE NOT NULL,
  data_termino DATE NOT NULL,
  cod_matricula_monitor INTEGER UNSIGNED NULL UNIQUE, -- RN07: monitor em no máximo uma turma
  PRIMARY KEY(idTURMA),
  CHECK (data_termino > data_inicio), -- RN11: término posterior ao início
  FOREIGN KEY(ATIVIDADE_idATIVIDADE)
    REFERENCES ATIVIDADE(idATIVIDADE)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(INSTRUTOR_idINSTRUTOR)
    REFERENCES INSTRUTOR(idINSTRUTOR)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

-- MATRICULA_TURMA
-- RN05: a PK composta impede a mesma matrícula duas vezes na mesma turma.
-- RN17: RESTRICT impede excluir turma ou aluno que tenha matrículas.
CREATE TABLE MATRICULA_TURMA (
  TURMA_idTURMA INTEGER UNSIGNED NOT NULL,
  ALUNO_cod_matricula INTEGER UNSIGNED NOT NULL,
  data_inscricao DATE NOT NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'ATIVA',
  PRIMARY KEY(TURMA_idTURMA, ALUNO_cod_matricula),
  CHECK (situacao IN ('ATIVA', 'CANCELADA')),
  FOREIGN KEY(TURMA_idTURMA)
    REFERENCES TURMA(idTURMA)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(ALUNO_cod_matricula)
    REFERENCES ALUNO(cod_matricula)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

-- Monitor da turma (RN06, RN07, RN08)
-- FK composta: o monitor precisa estar matriculado NA turma que monitora.
-- O campo aceita NULL porque a turma é criada antes das matrículas; o sistema
-- exige a designação do monitor antes de a turma funcionar (RN06).
ALTER TABLE TURMA
  ADD CONSTRAINT fk_turma_monitor
  FOREIGN KEY (idTURMA, cod_matricula_monitor)
  REFERENCES MATRICULA_TURMA(TURMA_idTURMA, ALUNO_cod_matricula)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT; -- evita cascata circular com MATRICULA_TURMA

-- AUSENCIA (RN09, RN16)
-- Uma linha por data de falta; a PK composta impede repetir a mesma data.
-- O total de faltas é calculado com COUNT(*).
CREATE TABLE AUSENCIA (
  TURMA_idTURMA INTEGER UNSIGNED NOT NULL,
  ALUNO_cod_matricula INTEGER UNSIGNED NOT NULL,
  data_falta DATE NOT NULL,
  PRIMARY KEY(TURMA_idTURMA, ALUNO_cod_matricula, data_falta),
  FOREIGN KEY (TURMA_idTURMA, ALUNO_cod_matricula)
    REFERENCES MATRICULA_TURMA(TURMA_idTURMA, ALUNO_cod_matricula)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

-- USUARIO (RN19, RN20, RN21)
-- A conta é desativada (campo ativo), não apagada.
-- Instrutor e Aluno ligam-se ao seu cadastro; Administrador e Secretaria não.
CREATE TABLE USUARIO (
  idUSUARIO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ALUNO_cod_matricula INTEGER UNSIGNED NULL UNIQUE,
  INSTRUTOR_idINSTRUTOR INTEGER UNSIGNED NULL UNIQUE,
  login VARCHAR(50) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  perfil VARCHAR(15) NOT NULL,
  ativo TINYINT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY(idUSUARIO),
  CHECK (perfil IN ('ADMINISTRADOR', 'SECRETARIA', 'INSTRUTOR', 'ALUNO')),
  CHECK (
       (perfil = 'INSTRUTOR' AND INSTRUTOR_idINSTRUTOR IS NOT NULL AND ALUNO_cod_matricula IS NULL)
    OR (perfil = 'ALUNO'     AND ALUNO_cod_matricula IS NOT NULL AND INSTRUTOR_idINSTRUTOR IS NULL)
    OR (perfil IN ('ADMINISTRADOR', 'SECRETARIA')
        AND INSTRUTOR_idINSTRUTOR IS NULL AND ALUNO_cod_matricula IS NULL)
  ),
  -- Sem ON DELETE/ON UPDATE CASCADE: o MySQL não permite CHECK em colunas
  -- de chave estrangeira com ação em cascata. O padrão (RESTRICT) bloqueia a
  -- exclusão de aluno ou instrutor que tenha conta de usuário.
  FOREIGN KEY(INSTRUTOR_idINSTRUTOR)
    REFERENCES INSTRUTOR(idINSTRUTOR),
  FOREIGN KEY(ALUNO_cod_matricula)
    REFERENCES ALUNO(cod_matricula)
);

-- ------------------------------------------------------------
-- Consultas de exemplo (comentadas)
-- ------------------------------------------------------------

-- Número de alunos ativos de cada turma (RN10)
-- SELECT TURMA_idTURMA, COUNT(*) AS numero_alunos
-- FROM MATRICULA_TURMA
-- WHERE situacao = 'ATIVA'
-- GROUP BY TURMA_idTURMA;

-- Total de faltas de cada aluno em cada turma (RN09)
-- SELECT TURMA_idTURMA, ALUNO_cod_matricula, COUNT(*) AS total_faltas
-- FROM AUSENCIA
-- GROUP BY TURMA_idTURMA, ALUNO_cod_matricula;

# Requisitos Funcionais (RF)

| Código | Módulo | Nome | Descrição | Regras Relacionadas | Dependências | Prioridade |
|---|---|---|---|---|---|---|
| RF01 | Autenticação | Login e perfis | Autenticar o usuário por login e senha e liberar as funções conforme o perfil (Administrador, Secretaria, Instrutor ou Aluno). | RN18, RN19, RN21 | RF16 | Essencial |
| RF02 | Instrutores | Gerenciar instrutores | Cadastrar, consultar, alterar e excluir instrutores (RG, nome, data de nascimento, titulação e telefones). | RN02, RN12, RN14, RN17, RN20 | RF01 | Essencial |
| RF03 | Alunos | Gerenciar alunos | Cadastrar, consultar, alterar e excluir alunos (código de matrícula, data de matrícula, nome, endereço, telefone, data de nascimento, altura e peso). | RN13, RN17, RN20 | RF01 | Essencial |
| RF04 | Atividades | Gerenciar tipos de atividade | Cadastrar, consultar, alterar e excluir tipos de atividade. | RN01, RN17, RN20 | RF01 | Essencial |
| RF05 | Turmas | Gerenciar turmas | Cadastrar, consultar, alterar e excluir turmas (atividade, instrutor, horário, duração, data de início e de término). | RN01, RN02, RN03, RN06, RN11, RN17, RN20 | RF02, RF04 | Essencial |
| RF06 | Matrículas | Matricular aluno | Matricular um aluno em uma turma, atualizando o número de alunos. | RN04, RN05, RN08, RN10 | RF03, RF05 | Essencial |
| RF07 | Matrículas | Desmatricular aluno | Desmatricular um aluno de uma turma, atualizando o número de alunos. Se for o monitor, exige escolher outro. | RN10, RN15 | RF06 | Importante |
| RF08 | Turmas | Designar monitor | Designar, entre os alunos matriculados na turma, o monitor, e trocá-lo quando necessário. | RN06, RN07, RN08, RN15, RN19 | RF05, RF06 | Essencial |
| RF09 | Frequência | Registrar ausência | Registrar a ausência de um aluno em uma turma, informando a data da falta. | RN09, RN16, RN19 | RF06 | Essencial |
| RF10 | Consultas | Consultar turmas do instrutor | Consultar as turmas orientadas por um instrutor. | RN03, RN19 | RF05 | Importante |
| RF11 | Consultas | Listar alunos da turma | Consultar os alunos matriculados em uma turma, com o monitor identificado. | RN04, RN10, RN19 | RF06 | Importante |
| RF12 | Frequência | Consultar ausências | Consultar as ausências de um aluno por turma, com datas e total calculado. | RN09, RN19 | RF09 | Importante |
| RF13 | Relatórios | Emitir relatórios | Emitir relatórios de ausências por turma, alunos por turma e turmas por instrutor. | RN09, RN19 | RF09, RF11 | Desejável |
| RF14 | Área do aluno | Consultar minhas turmas | O aluno consulta suas turmas, com horário, instrutor, monitor e total de faltas. | RN09, RN18, RN19 | RF01, RF06, RF08, RF09 | Importante |
| RF15 | Área do aluno | Consultar datas das minhas ausências | O aluno consulta as datas das próprias ausências em cada turma. | RN09, RN18, RN19 | RF09 | Desejável |
| RF16 | Autenticação | Gerenciar usuários e perfis | O administrador cria, altera e desativa contas e concede o perfil de acesso de cada usuário, definindo quais funções ele poderá disparar. | RN19, RN20, RN21 | — | Essencial |

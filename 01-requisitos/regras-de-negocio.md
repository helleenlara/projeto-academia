# Regras de Negócio (RN)

| Código | Nome | Descrição | Módulo | Origem / Dependência | RFs Associados |
|---|---|---|---|---|---|
| RN01 | Atividade única por turma | Toda turma deve estar associada a exatamente um tipo de atividade. | Turmas | Cenário | RF04, RF05 |
| RN02 | Instrutor único por turma | Toda turma é orientada por um único instrutor. | Turmas | Cenário | RF02, RF05 |
| RN03 | Instrutor com várias turmas | Um instrutor pode orientar várias turmas, inclusive de atividades diferentes. | Turmas / Instrutores | Cenário | RF05, RF10 |
| RN04 | Vários alunos por turma | Uma turma pode ter vários alunos matriculados. | Matrículas | Cenário | RF06, RF11 |
| RN05 | Aluno em várias turmas | Um aluno pode se matricular em várias turmas, mas não pode ter duas matrículas na mesma turma. | Matrículas | Cenário | RF06 |
| RN06 | Monitor obrigatório e único | Toda turma possui exatamente um aluno monitor. | Turmas | Cenário | RF05, RF08 |
| RN07 | Limite de monitoria por aluno | Um aluno pode ser monitor de, no máximo, uma turma. | Turmas | Cenário | RF08 |
| RN08 | Monitor matriculado na turma | O aluno designado monitor deve estar matriculado na turma que monitora. | Turmas / Matrículas | Premissa do projeto | RF06, RF08 |
| RN09 | Ausências por matrícula | Cada matrícula em turma mantém seu registro de ausências, com uma linha por data de falta. O total é calculado pela contagem dessas datas. | Frequência | Cenário | RF09, RF12, RF13, RF14, RF15 |
| RN10 | Número de alunos calculado | O número de alunos da turma é obtido das matrículas ativas, não é digitado. | Turmas | Cenário | RF06, RF07, RF11 |
| RN11 | Período válido da turma | A data de término da turma deve ser posterior à data de início. | Turmas | Premissa do projeto | RF05 |
| RN12 | RG único do instrutor | Não podem existir dois instrutores com o mesmo RG. | Instrutores | Premissa do projeto | RF02 |
| RN13 | Código de matrícula único | O código de matrícula do aluno é único e gerado automaticamente. | Alunos | Cenário | RF03 |
| RN14 | Telefones do instrutor | Um instrutor pode ter um ou mais telefones de contato. | Instrutores | Cenário | RF02 |
| RN15 | Desmatrícula do monitor | Se o monitor for desmatriculado, o sistema exige a designação de outro monitor antes de concluir. | Turmas / Matrículas | Premissa (decorre da RN08) | RF07, RF08 |
| RN16 | Validação da ausência | A ausência só pode ser registrada para aluno matriculado na turma, com data dentro do período da turma e sem repetir a data na mesma matrícula. | Frequência | Premissa do projeto | RF09 |
| RN17 | Exclusão protegida | Não podem ser excluídos: instrutor com turmas, atividade com turmas, e turma ou aluno com matrículas ativas. | Cadastros | Premissa (integridade referencial) | RF02, RF03, RF04, RF05 |
| RN18 | Privacidade do aluno | O aluno vê somente os dados da própria matrícula; de instrutores e do monitor, apenas o nome (sem telefone, endereço ou RG). | Área do aluno | LGPD (Lei 13.709/2018) | RF01, RF14, RF15 |
| RN19 | Acesso por perfil | Cada usuário tem um único perfil (Administrador, Secretaria, Instrutor ou Aluno) e só acessa as funções liberadas para ele. O instrutor acessa apenas as turmas que orienta. | Segurança | Premissa do projeto | RF01, RF08, RF09, RF10, RF11, RF12, RF13, RF14, RF15, RF16 |
| RN20 | Exclusão por perfil | Instrutores, atividades e turmas só podem ser excluídos pelo administrador; alunos, pelo administrador ou pela secretaria. Contas de usuário são desativadas, não apagadas. | Segurança | Premissa do projeto | RF02, RF03, RF04, RF05, RF16 |
| RN21 | Concessão de acesso pelo administrador | Somente o administrador pode criar contas e atribuir o perfil de acesso (Secretaria, Instrutor ou Aluno). A secretaria só executa as funções liberadas ao seu perfil e não pode alterar permissões. | Segurança | Premissa do projeto | RF01, RF16 |

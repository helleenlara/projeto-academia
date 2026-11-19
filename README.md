# Sistema de Controle de Academia de Ginástica

**Atividade Formativa de Engenharia de Software**
UniRuy Wyden · Docente: MSc Eng. Heleno Cardoso
Aluna: Lara Hellen Marques
Salvador, novembro de 2026

---

## Sobre o projeto

Este repositório reúne a análise, a especificação e a modelagem de um sistema para controlar o funcionamento de uma academia de ginástica, a partir do estudo de caso proposto na atividade formativa.

### O cenário

- Os alunos são organizados em **turmas**, e cada turma está associada a um tipo de atividade (horário, duração, data de início e data de término).
- Cada turma é orientada por **um único instrutor**, que pode orientar várias turmas, inclusive de atividades diferentes.
- Cada turma tem um **aluno monitor**, que auxilia o instrutor. Um aluno pode ser monitor de, no máximo, uma turma.
- Um aluno pode se matricular em **várias turmas**, e para cada matrícula em uma turma é mantido o registro das **ausências**.

## Objetivos

Realizar a análise, a especificação e a modelagem do sistema proposto, contemplando:

1. Levantamento e documentação dos requisitos
2. Requisitos funcionais (RF)
3. Regras de negócio (RN)
4. Requisitos não funcionais (RNF)
5. Diagramas de fluxo de dados (DFD) orientados a eventos
6. Modelo lógico de dados
7. Modelo físico, representado pelo diagrama entidade-relacionamento (DER)
8. DDL correspondente ao modelo físico
9. Definição das interfaces do sistema (cadastro, consulta e relatório)
10. Prototipagem das principais telas no Figma

## Metodologia

O trabalho seguiu um processo **iterativo e incremental**. As etapas foram executadas na ordem proposta no enunciado, cada uma construída sobre o resultado da anterior (incremento). Sempre que uma etapa posterior revelava um erro ou uma lacuna, os artefatos anteriores eram revisados e corrigidos (iteração), mesmo já tendo sido concluídos.

| Fase | Etapas | Técnica e produto |
|---|---|---|
| Análise | Levantamento de requisitos, RF, RN e RNF | Análise do estudo de caso, com requisitos documentados em tabelas e rastreabilidade entre regras de negócio e requisitos funcionais |
| Modelagem de processos | DFD | Análise estruturada: DFD orientado a eventos (diagrama de contexto e nível 1) |
| Modelagem de dados | Modelo conceitual, lógico, físico e DDL | Modelo entidade-relacionamento, do conceitual (brModelo) ao físico (DBDesigner) e ao script SQL em MySQL |
| Interface | Telas e protótipo | Prototipagem das telas no Figma, com fluxo de navegação por perfil de usuário |

### Exemplos de revisões feitas durante o trabalho

- **Monitor:** a premissa inicial era que o monitor não precisava estar matriculado na turma. Foi revista (o monitor deve estar matriculado), e as regras, os requisitos, o modelo de dados e o DDL foram atualizados.
- **Ausências:** a ideia de um contador de faltas foi trocada pelo registro de cada falta por data, o que criou a tabela de ausências e alterou regras e requisitos.
- **Perfis de acesso:** o perfil único de recepção e administração foi separado em Administrador e Secretaria, com novas regras (RN20 e RN21) e um novo requisito (RF16).
- **DFD:** a primeira versão, com 14 processos, foi simplificada para 6 processos em dois níveis, para facilitar a leitura.
- **DDL:** após testes no banco, foram corrigidas as exclusões em cascata (que apagavam matrículas e faltas), a data de término da turma e as validações da tabela de usuários.

Os artefatos foram versionados no Git e no GitHub.

## Estrutura do repositório

| Etapa do enunciado | Pasta / arquivo | Conteúdo | Situação |
|---|---|---|---|
| 2.1 Levantamento de requisitos | [`01-requisitos/`](01-requisitos/) | Requisitos e perfis de acesso | Concluído |
| 2.2 Requisitos funcionais | [`requisitos-funcionais.md`](01-requisitos/requisitos-funcionais.md) | RF01 a RF16 | Concluído |
| 2.3 Regras de negócio | [`regras-de-negocio.md`](01-requisitos/regras-de-negocio.md) | RN01 a RN21 | Concluído |
| 2.4 Requisitos não funcionais | [`requisitos-nao-funcionais.md`](01-requisitos/requisitos-nao-funcionais.md) | RNF01 a RNF09 | Concluído |
| Perfis e permissões | [`perfis-e-permissoes.md`](01-requisitos/perfis-e-permissoes.md) | O que cada perfil pode fazer | Concluído |
| 2.5 DFD | [`02-dfd/dfd-eventos.md`](02-dfd/dfd-eventos.md) | Diagrama de contexto, nível 1, eventos e depósitos | Concluído |
| 2.6 Modelo lógico | [`03-modelo-logico/modelo-logico.md`](03-modelo-logico/modelo-logico.md) | Conceitual, lógico, atributos, chaves e cardinalidades | Concluído |
| 2.7 Modelo físico (DER) | [`04-der/der.md`](04-der/der.md) | DER do DBDesigner | Concluído |
| 2.8 DDL | [`05-ddl/ddl.md`](05-ddl/ddl.md) e [`ddl-academia.sql`](05-ddl/ddl-academia.sql) | Script de criação do banco (MySQL) | Concluído |
| 2.9 Interface do sistema | [`06-interfaces/interfaces.md`](06-interfaces/interfaces.md) | Telas de cadastro, consulta e relatório | Concluído |
| 2.10 Prototipagem | [`07-prototipo-figma/prototipo.md`](07-prototipo-figma/prototipo.md) | Link do protótipo no Figma | Concluído |

## Resumo do sistema

| Item | Quantidade |
|---|---|
| Requisitos funcionais | 16 |
| Regras de negócio | 21 |
| Requisitos não funcionais | 9 |
| Eventos / processos / depósitos de dados (DFD) | 12 / 6 / 7 |
| Tabelas do banco de dados | 8 |
| Telas prototipadas | 12 (incluindo 4 menus, um por perfil) |

### Perfis de acesso

O sistema tem quatro perfis, e o administrador atribui o perfil de cada usuário:

| Perfil | Responsabilidade |
|---|---|
| Administrador | Gerencia usuários, instrutores, atividades e turmas, além de todas as funções da secretaria |
| Secretaria | Cadastra e exclui alunos, faz matrículas e emite relatórios |
| Instrutor | Registra ausências e designa o monitor nas turmas que orienta |
| Aluno | Consulta suas turmas, horários, instrutor, monitor e faltas |

### Tabelas do banco de dados

`ATIVIDADE`, `INSTRUTOR`, `TELEFONE_INSTRUTOR`, `ALUNO`, `TURMA`, `MATRICULA_TURMA`, `AUSENCIA` e `USUARIO`.

## Premissas adotadas

Pontos que o enunciado não define e que foram decididos no projeto:

- O aluno monitor deve estar matriculado na turma que monitora.
- As ausências são registradas **por data**; o total de faltas é calculado pela contagem, e o número de alunos da turma é calculado pelas matrículas ativas (nenhum dos dois é coluna).
- O sistema é **web responsivo**, com banco de dados **MySQL**.
- O campo do monitor na turma aceita valor nulo no banco, porque a turma é criada antes das matrículas; o sistema exige o monitor antes de a turma funcionar.
- Existe uma tabela de **usuários**, com login e perfis de acesso, que não aparece no enunciado e foi acrescentada para sustentar as áreas de cada perfil.

## Ferramentas utilizadas

| Finalidade | Ferramenta |
|---|---|
| Modelo conceitual e lógico | brModelo |
| Modelo físico (DER) | DBDesigner |
| Banco de dados | MySQL 8 |
| Diagramas de fluxo e navegação | Mermaid (renderizado pelo próprio GitHub) |
| Interfaces e protótipo | Figma |
| Edição e versionamento | Visual Studio Code, Git e GitHub |

## Como visualizar

- Os diagramas em **Mermaid** (DFD e fluxo de navegação) aparecem desenhados diretamente nas páginas do GitHub.
- As imagens dos modelos e das telas ficam nas pastas `anexos` de cada etapa, e os arquivos editáveis do brModelo e do DBDesigner estão junto delas.
- Protótipo no Figma: [abrir o protótipo](https://www.figma.com/proto/lZXzgyLHeS56aJhtOmAyjq/Academia-de-Ginastica?node-id=2-23&p=f&t=laFl1Qo7nfo1MP8y-1&scaling=min-zoom&content-scaling=fixed&page-id=0%3A1)

## Como executar o banco de dados

Com o MySQL 8.0 ou superior instalado, execute o script da pasta `05-ddl`:

```bash
mysql -u root -p < 05-ddl/ddl-academia.sql
```

O script começa com `DROP DATABASE IF EXISTS academia;`, que apaga um banco com esse nome, se existir. Mais detalhes em [`05-ddl/ddl.md`](05-ddl/ddl.md).

## Observação sobre os diagramas dos modelos

No diagrama do modelo lógico gerado no brModelo, não aparecem a tabela `TELEFONE_INSTRUTOR`, a tabela `AUSENCIA` e os atributos da matrícula (`data_inscricao` e `situacao`). Eles estão descritos no documento `modelo-logico.md` e implementados no modelo físico e no DDL.

# Diagramas de Fluxo de Dados (DFD) orientados a eventos

O DFD está organizado em **níveis**, do mais geral ao mais detalhado:

| Nível | Diagrama | Conteúdo |
|---|---|---|
| 0 | Contexto | O sistema como uma única caixa e seus quatro atores |
| 1-A | Acesso e usuários | P1, P2 |
| 1-B | Cadastros | P3, P4, P5, P6, P14 |
| 1-C | Matrículas e monitor | P7, P8, P9 |
| 1-D | Frequência, consultas e relatórios | P10, P11, P12, P13 |

Legenda dos diagramas: retângulo = processo; cilindro = depósito de dados; elipse arredondada = ator externo; seta contínua = dado que entra, é gravado ou sai; seta tracejada = leitura de dados.

## 1. Depósitos de dados

| ID | Depósito | Tabela correspondente |
|---|---|---|
| D1 | Usuários | Usuario |
| D2 | Alunos | Aluno |
| D3 | Instrutores (e telefones) | Instrutor, Telefone_Instrutor |
| D4 | Atividades | Atividade |
| D5 | Turmas | Turma |
| D6 | Matrículas | Matricula_Turma |
| D7 | Ausências | Ausencia |

## 2. Eventos

| Evento | Ator | Entrada (fluxo) | Processo | Depósitos | Saída | Diagrama |
|---|---|---|---|---|---|---|
| E01 | Administrador | Dados do usuário + perfil | P1 Gerenciar usuários e perfis | Grava D1 | Confirmação | 1-A |
| E02 | Todos | Login e senha | P2 Autenticar | Lê D1 | Acesso liberado conforme o perfil | 1-A |
| E03 | Administrador | Dados do instrutor | P3 Gerenciar instrutores | Grava D3 | Confirmação | 1-B |
| E04 | Administrador | Dados da atividade | P4 Gerenciar atividades | Grava D4 | Confirmação | 1-B |
| E05 | Administrador | Dados da turma | P5 Gerenciar turmas | Lê D3, D4 / Grava D5 | Confirmação | 1-B |
| E06 | Secretaria | Dados do aluno | P6 Gerenciar alunos | Grava D2 | Código de matrícula gerado | 1-B |
| E07 | Secretaria | Aluno + turma | P7 Matricular aluno | Lê D2, D5 / Grava D6 | Confirmação da matrícula | 1-C |
| E08 | Secretaria | Aluno + turma | P8 Desmatricular aluno | Lê D5 / Atualiza D6 | Confirmação | 1-C |
| E09 | Instrutor / Secretaria | Turma + aluno monitor | P9 Designar monitor | Lê D6 / Atualiza D5 | Confirmação | 1-C |
| E10 | Instrutor / Secretaria | Matrícula + data da falta | P10 Registrar ausência | Lê D6 / Grava D7 | Confirmação | 1-D |
| E11 | Instrutor | Pedido de consulta | P11 Consultar turmas e alunos | Lê D5, D6, D2 | Lista de alunos da turma | 1-D |
| E12 | Secretaria / Administrador | Tipo de relatório | P12 Emitir relatórios | Lê D2, D3, D5, D6, D7 | Relatório | 1-D |
| E13 | Aluno | Pedido de consulta | P13 Consultar minhas turmas | Lê D3, D5, D6, D7 | Turmas, horários, instrutor, monitor e faltas | 1-D |
| E14 | Administrador / Secretaria | Pedido de exclusão | P14 Excluir cadastro | Lê D5, D6 / Atualiza D2, D3, D4, D5 | Confirmação ou bloqueio (RN17) | 1-B |

## 3. Nível 0: diagrama de contexto

```mermaid
flowchart LR
    ADM([Administrador])
    SEC([Secretaria])
    INS([Instrutor])
    ALU([Aluno])
    S((Sistema da Academia))

    ADM -->|usuários, instrutores, atividades e turmas| S
    SEC -->|alunos, matrículas e ausências| S
    INS -->|ausências e monitor| S
    ALU -->|pedido de consulta| S

    S -->|relatórios e confirmações| ADM
    S -->|relatórios e confirmações| SEC
    S -->|alunos da turma| INS
    S -->|turmas, instrutor, monitor e faltas| ALU
```

## 4. Nível 1-A: Acesso e usuários

```mermaid
flowchart LR
    ADM([Administrador])
    USU([Todos os usuários])

    P1[P1 Gerenciar usuários e perfis]
    P2[P2 Autenticar]

    D1[(D1 Usuários)]

    ADM -->|dados do usuário e perfil| P1
    P1 --> D1
    P1 -->|confirmação| ADM

    USU -->|login e senha| P2
    D1 -.->|dados de acesso| P2
    P2 -->|acesso liberado conforme o perfil| USU
```

## 5. Nível 1-B: Cadastros

```mermaid
flowchart LR
    ADM([Administrador])
    SEC([Secretaria])

    P3[P3 Gerenciar instrutores]
    P4[P4 Gerenciar atividades]
    P5[P5 Gerenciar turmas]
    P6[P6 Gerenciar alunos]
    P14[P14 Excluir cadastro]

    D2[(D2 Alunos)]
    D3[(D3 Instrutores)]
    D4[(D4 Atividades)]
    D5[(D5 Turmas)]
    D6[(D6 Matrículas)]

    ADM -->|dados do instrutor| P3
    P3 --> D3

    ADM -->|dados da atividade| P4
    P4 --> D4

    ADM -->|dados da turma| P5
    D3 -.->|instrutores| P5
    D4 -.->|atividades| P5
    P5 --> D5

    SEC -->|dados do aluno| P6
    P6 --> D2
    P6 -->|código de matrícula| SEC

    ADM -->|pedido de exclusão| P14
    SEC -->|pedido de exclusão de aluno| P14
    D5 -.->|turmas vinculadas| P14
    D6 -.->|matrículas ativas| P14
    P14 --> D2
    P14 --> D3
    P14 --> D4
    P14 --> D5
    P14 -->|confirmação ou bloqueio| ADM
    P14 -->|confirmação ou bloqueio| SEC
```

## 6. Nível 1-C: Matrículas e monitor

```mermaid
flowchart LR
    SEC([Secretaria])
    INS([Instrutor])

    P7[P7 Matricular aluno]
    P8[P8 Desmatricular aluno]
    P9[P9 Designar monitor]

    D2[(D2 Alunos)]
    D5[(D5 Turmas)]
    D6[(D6 Matrículas)]

    SEC -->|aluno + turma| P7
    D2 -.->|dados do aluno| P7
    D5 -.->|dados da turma| P7
    P7 --> D6
    P7 -->|confirmação da matrícula| SEC

    SEC -->|aluno + turma| P8
    D5 -.->|monitor da turma| P8
    P8 --> D6
    P8 -->|confirmação| SEC

    SEC -->|turma + aluno monitor| P9
    INS -->|turma + aluno monitor| P9
    D6 -.->|alunos matriculados| P9
    P9 --> D5
    P9 -->|confirmação| INS
```

## 7. Nível 1-D: Frequência, consultas e relatórios

```mermaid
flowchart LR
    ADM([Administrador])
    SEC([Secretaria])
    INS([Instrutor])
    ALU([Aluno])

    P10[P10 Registrar ausência]
    P11[P11 Consultar turmas e alunos]
    P12[P12 Emitir relatórios]
    P13[P13 Consultar minhas turmas]

    D2[(D2 Alunos)]
    D3[(D3 Instrutores)]
    D5[(D5 Turmas)]
    D6[(D6 Matrículas)]
    D7[(D7 Ausências)]

    INS -->|matrícula + data da falta| P10
    SEC -->|matrícula + data da falta| P10
    D6 -.->|matrícula na turma| P10
    P10 --> D7

    INS -->|pedido de consulta| P11
    D5 -.-> P11
    D6 -.-> P11
    D2 -.-> P11
    P11 -->|alunos da turma| INS

    ADM -->|tipo de relatório| P12
    SEC -->|tipo de relatório| P12
    D2 -.-> P12
    D3 -.-> P12
    D5 -.-> P12
    D6 -.-> P12
    D7 -.-> P12
    P12 -->|relatório| ADM
    P12 -->|relatório| SEC

    ALU -->|pedido de consulta| P13
    D3 -.-> P13
    D5 -.-> P13
    D6 -.-> P13
    D7 -.-> P13
    P13 -->|turmas, instrutor, monitor e faltas| ALU
```

## 8. Arquivos do diagrama

- `dfd-eventos.drawio` (editável, draw.io; uma página para cada diagrama)
- Imagens PNG exportadas dos diagramas

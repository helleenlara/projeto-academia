# Diagrama de Fluxo de Dados (DFD) orientado a eventos

Ordem deste documento: 1) depósitos de dados, 2) eventos, 3) diagrama.

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

| Evento | Ator | Entrada (fluxo) | Processo | Depósitos | Saída |
|---|---|---|---|---|---|
| E01 | Administrador | Dados do usuário + perfil | P1 Gerenciar usuários e perfis | Grava D1 | Confirmação |
| E02 | Todos | Login e senha | P2 Autenticar | Lê D1 | Acesso liberado conforme o perfil |
| E03 | Administrador | Dados do instrutor | P3 Gerenciar instrutores | Grava D3 | Confirmação |
| E04 | Administrador | Dados da atividade | P4 Gerenciar atividades | Grava D4 | Confirmação |
| E05 | Administrador | Dados da turma | P5 Gerenciar turmas | Lê D3, D4 / Grava D5 | Confirmação |
| E06 | Secretaria | Dados do aluno | P6 Gerenciar alunos | Grava D2 | Código de matrícula gerado |
| E07 | Secretaria | Aluno + turma | P7 Matricular aluno | Lê D2, D5 / Grava D6 | Confirmação da matrícula |
| E08 | Secretaria | Aluno + turma | P8 Desmatricular aluno | Lê D5 / Atualiza D6 | Confirmação |
| E09 | Instrutor / Secretaria | Turma + aluno monitor | P9 Designar monitor | Lê D6 / Atualiza D5 | Confirmação |
| E10 | Instrutor / Secretaria | Matrícula + data da falta | P10 Registrar ausência | Lê D6 / Grava D7 | Confirmação |
| E11 | Instrutor | Pedido de consulta | P11 Consultar turmas e alunos | Lê D5, D6, D2 | Lista de alunos da turma |
| E12 | Secretaria / Administrador | Tipo de relatório | P12 Emitir relatórios | Lê D5, D6, D7, D2, D3 | Relatório |
| E13 | Aluno | Pedido de consulta | P13 Consultar minhas turmas | Lê D6, D5, D3, D7 | Turmas, horários, instrutor, monitor e faltas |
| E14 | Administrador / Secretaria | Pedido de exclusão | P14 Excluir cadastro | Lê D5, D6 / Atualiza D2, D3, D4, D5 | Confirmação ou bloqueio (RN17) |

## 3. Diagrama

Setas contínuas gravam ou enviam dados; setas tracejadas são leituras.

```mermaid
flowchart LR
    ADM([Administrador])
    SEC([Secretaria])
    INS([Instrutor])
    ALU([Aluno])

    P1[P1 Gerenciar usuários e perfis]
    P2[P2 Autenticar]
    P3[P3 Gerenciar instrutores]
    P4[P4 Gerenciar atividades]
    P5[P5 Gerenciar turmas]
    P6[P6 Gerenciar alunos]
    P7[P7 Matricular aluno]
    P8[P8 Desmatricular aluno]
    P9[P9 Designar monitor]
    P10[P10 Registrar ausência]
    P11[P11 Consultar turmas e alunos]
    P12[P12 Emitir relatórios]
    P13[P13 Consultar minhas turmas]
    P14[P14 Excluir cadastro]

    D1[(D1 Usuários)]
    D2[(D2 Alunos)]
    D3[(D3 Instrutores)]
    D4[(D4 Atividades)]
    D5[(D5 Turmas)]
    D6[(D6 Matrículas)]
    D7[(D7 Ausências)]

    ADM -->|dados do usuário e perfil| P1 --> D1
    ADM & SEC & INS & ALU -->|login e senha| P2
    P2 -.->|lê| D1
    ADM -->|dados do instrutor| P3 --> D3
    ADM -->|dados da atividade| P4 --> D4
    ADM -->|dados da turma| P5
    D3 -.-> P5
    D4 -.-> P5
    P5 --> D5
    SEC -->|dados do aluno| P6 --> D2
    SEC -->|aluno + turma| P7
    D2 -.-> P7
    D5 -.-> P7
    P7 --> D6
    SEC -->|aluno + turma| P8 --> D6
    INS & SEC -->|turma + monitor| P9
    D6 -.-> P9
    P9 --> D5
    INS & SEC -->|matrícula + data da falta| P10
    D6 -.-> P10
    P10 --> D7
    INS -->|pedido de consulta| P11
    D5 & D6 & D2 -.-> P11
    P11 -->|alunos da turma| INS
    SEC & ADM -->|tipo de relatório| P12
    D5 & D6 & D7 & D2 & D3 -.-> P12
    P12 -->|relatório| SEC
    ALU -->|pedido de consulta| P13
    D6 & D5 & D3 & D7 -.-> P13
    P13 -->|turmas, instrutor, monitor e faltas| ALU
    ADM & SEC -->|pedido de exclusão| P14
    D5 & D6 -.-> P14
    P14 --> D2 & D3 & D4
```

## 4. Arquivos do diagrama

- `dfd-eventos.drawio` (editável, draw.io)
- `dfd-eventos.png` (imagem)

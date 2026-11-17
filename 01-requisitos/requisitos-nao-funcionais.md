# Requisitos Não Funcionais (RNF)

| Código | Categoria | Descrição / Métrica | Escopo / Módulo | Dependência / Restrição |
|---|---|---|---|---|
| RNF01 | Usabilidade | Qualquer cadastro deve ser concluído em até 3 telas/etapas, com mensagens de erro indicando o campo e o motivo. | Sistema todo | Heurísticas de Nielsen |
| RNF02 | Desempenho | Consultas e listagens respondem em até 3 segundos para bases de até 5.000 alunos. | Consultas e relatórios | Índices nas chaves estrangeiras |
| RNF03 | Segurança | Acesso por login e senha, com quatro perfis de permissões distintas. Senhas armazenadas com hash (bcrypt). | Autenticação (global) | Padrão OWASP |
| RNF04 | Compliance / LGPD | Dados pessoais e de saúde (endereço, telefone, peso, altura) só são acessados por perfis autorizados. | Alunos e Instrutores | LGPD (Lei 13.709/2018) |
| RNF05 | Integridade | Banco relacional com PK, FK, UNIQUE, NOT NULL e CHECK, impedindo dados inconsistentes. | Banco de dados | MySQL 8.0+ (versões antigas ignoram CHECK) |
| RNF06 | Disponibilidade | Disponível no horário de funcionamento da academia, com 99% de disponibilidade mensal. | Sistema todo | Hospedagem com monitoramento |
| RNF07 | Confiabilidade / Backup | Backup diário do banco, com retenção mínima de 30 dias. | Banco de dados | Rotina automatizada |
| RNF08 | Portabilidade | Sistema web responsivo, nas versões atuais de Chrome, Edge e Firefox, em computador e celular (a partir de 360 px). | Interface | HTML5/CSS3 responsivo |
| RNF09 | Manutenibilidade | Documentação, diagramas e scripts SQL versionados e organizados no GitHub. | Projeto | Git / GitHub |

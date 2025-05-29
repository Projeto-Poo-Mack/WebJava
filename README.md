# Sistema de Gestão de Clínica Médica

## Descrição
Este é um sistema web desenvolvido em Java para gerenciamento de clínica médica, permitindo o agendamento de consultas, gestão de pacientes e médicos, e acompanhamento de prontuários.

## Funcionalidades

### Para Pacientes
- **Cadastro e Login**: Sistema de autenticação seguro para pacientes
- **Meu Cadastro**: 
  - Visualização dos dados pessoais
  - Edição de informações (nome, email, telefone, CPF)
  - Validações específicas para cada campo:
    - Nome: apenas letras e espaços
    - CPF: exatamente 11 dígitos numéricos
    - Telefone: exatamente 11 dígitos (DDD + número com 9)
- **Agendamento de Consultas**: 
  - Visualização de horários disponíveis
  - Seleção de médico
  - Agendamento de consulta
- **Minha Agenda**: 
  - Visualização de consultas agendadas
  - Detalhes como data, hora e médico responsável

### Para Médicos
- **Cadastro e Login**: Sistema de autenticação para médicos
- **Agenda**: 
  - Visualização de consultas agendadas
  - Gestão de horários disponíveis
- **Prontuários**: 
  - Registro de informações clínicas
  - Histórico de atendimentos

### Para Administradores
- **Gestão de Usuários**: 
  - Cadastro de médicos e pacientes
  - Edição de informações
  - Exclusão de registros
- **Relatórios**: 
  - Consultas agendadas
  - Histórico de atendimentos

## Tecnologias Utilizadas
- **Backend**: 
  - Java
  - Servlets
  - JSP (JavaServer Pages)
  - JDBC para conexão com banco de dados
- **Frontend**: 
  - HTML5
  - CSS3
  - JavaScript
- **Banco de Dados**: 
  - MySQL

## Estrutura do Projeto
```
clinica/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── mack/
│       │           └── clinica/
│       │               ├── controller/    # Servlets
│       │               ├── model/         # Classes de modelo
│       │               └── util/          # Classes utilitárias
│       └── webapp/
│           ├── WEB-INF/
│           └── *.jsp                      # Páginas JSP
└── pom.xml                               # Configuração Maven
```

## Requisitos do Sistema
- Java JDK 8 ou superior
- Apache Tomcat 9.0 ou superior
- MySQL 5.7 ou superior
- Maven 3.6 ou superior

## Instalação e Configuração

1. Clone o repositório:
```bash
git clone [URL_DO_REPOSITÓRIO]
```

2. Configure o banco de dados:
- Crie um banco de dados MySQL
- Execute os scripts SQL fornecidos na pasta `database/`

3. Configure o arquivo de conexão:
- Ajuste as credenciais do banco de dados em `src/main/resources/database.properties`

4. Compile o projeto:
```bash
mvn clean install
```

5. Execute o projeto:
- Implante o arquivo WAR gerado no Tomcat
- Acesse através do navegador: `http://localhost:8080/clinica`

## Validações Implementadas

### Cadastro de Pacientes
- **Nome**: Apenas letras e espaços
- **CPF**: Exatamente 11 dígitos numéricos
- **Telefone**: Exatamente 11 dígitos (DDD + número com 9)
- **Email**: Formato válido de email

### Agendamento de Consultas
- Verificação de disponibilidade do horário
- Validação de data futura
- Verificação de conflitos de horário

## Segurança
- Autenticação de usuários
- Controle de acesso baseado em perfis (paciente, médico, administrador)
- Proteção contra SQL Injection
- Validação de dados em ambos os lados (cliente e servidor)

## Contribuição
1. Faça um Fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

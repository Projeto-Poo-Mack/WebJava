<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mack.clinica.model.Paciente" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Meu Cadastro - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e3ebf6;
            border-radius: 0.375rem;
            transition: border-color 0.2s ease-in-out;
            font-size: 1rem;
        }
        
        .form-group input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }
        
        .form-group input::placeholder {
            color: var(--secondary-color);
            opacity: 0.7;
        }
        
        .form-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .form-buttons button,
        .form-buttons a {
            flex: 1;
            text-align: center;
            padding: 0.75rem 1.5rem;
            border-radius: 0.375rem;
            font-weight: 500;
            transition: all 0.2s ease-in-out;
        }
        
        .form-buttons .btn-secondary {
            background-color: var(--light-color);
            color: var(--dark-color);
            border: 1px solid #e3ebf6;
        }
        
        .form-buttons .btn-secondary:hover {
            background-color: #e3ebf6;
        }
        
        .page-header {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .page-header h1 {
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .error-message {
            color: var(--danger-color);
            font-size: 0.875rem;
            margin-top: 0.5rem;
            display: none;
        }
        
        .input-error {
            border-color: var(--danger-color) !important;
        }
        
        .alert {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
        }
        
        .alert-error {
            background-color: #fee7eb;
            color: #c9244b;
        }
        
        @media (max-width: 768px) {
            .form-buttons {
                flex-direction: column;
            }
            
            .form-buttons button,
            .form-buttons a {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="paciente_dashboard">Home</a>
            <a href="agendarConsulta">Agendamento de Consultas</a>
            <a href="minhaAgenda">Minha Agenda</a>
            <a href="meu-cadastro" class="active">Meu Cadastro</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <div class="content fade-in">
        <div class="page-header">
            <h1>Editar Meu Cadastro</h1>
            <p>Atualize suas informações pessoais</p>
        </div>
        
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <%
            }
        %>
        
        <%
            Paciente paciente = (Paciente) request.getAttribute("paciente");
            if (paciente != null) {
        %>
            <form action="meu-cadastro" method="post" class="form-container" id="editForm" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="editar" />
                <input type="hidden" name="id" value="<%= paciente.getId() %>" />
                
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" class="form-control" 
                           value="<%= paciente.getNome() %>" required 
                           pattern="[A-Za-zÀ-ÿ\s]+" oninput="validateName(this)">
                    <div id="nameError" class="error-message">O nome deve conter apenas letras e espaços</div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           value="<%= paciente.getEmail() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <input type="text" id="cpf" name="cpf" class="form-control" 
                           value="<%= paciente.getCpf() %>" required 
                           pattern="\d{11}" maxlength="11" oninput="validateCPF(this)">
                    <div id="cpfError" class="error-message">O CPF deve conter exatamente 11 dígitos numéricos</div>
                </div>
                
                <div class="form-group">
                    <label for="celular">Telefone:</label>
                    <input type="tel" id="celular" name="celular" class="form-control" 
                           value="<%= paciente.getCelular().replaceAll("\\.0$", "") %>" required 
                           pattern="\d{11}" maxlength="11" oninput="validatePhone(this)">
                    <div id="phoneError" class="error-message">O telefone deve conter exatamente 11 dígitos (DDD + número com 9)</div>
                </div>
                
                <div class="form-group">
                    <label for="senha">Nova Senha (deixe em branco para manter a atual):</label>
                    <input type="password" id="senha" name="senha" class="form-control">
                </div>
                
                <div class="form-group">
                    <label for="confirmarSenha">Confirmar Nova Senha:</label>
                    <input type="password" id="confirmarSenha" name="confirmarSenha" class="form-control">
                    <div id="senhaError" class="error-message">As senhas não coincidem</div>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                    <a href="meu-cadastro" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        <%
            } else {
        %>
            <div class="error-message">
                <p>Não foi possível carregar suas informações. Por favor, tente novamente mais tarde.</p>
                <a href="meu-cadastro" class="btn btn-primary">Voltar</a>
            </div>
        <%
            }
        %>
    </div>

    <script>
        function validateName(input) {
            const name = input.value;
            const errorElement = document.getElementById('nameError');
            
            // Verifica se contém apenas letras e espaços
            if (!/^[A-Za-zÀ-ÿ\s]+$/.test(name)) {
                input.classList.add('input-error');
                errorElement.style.display = 'block';
                return false;
            } else {
                input.classList.remove('input-error');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validateCPF(input) {
            const cpf = input.value.replace(/\D/g, '');
            const errorElement = document.getElementById('cpfError');
            
            if (cpf.length !== 11) {
                input.classList.add('input-error');
                errorElement.style.display = 'block';
                return false;
            } else {
                input.classList.remove('input-error');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validatePhone(input) {
            const phone = input.value.replace(/\D/g, '');
            const errorElement = document.getElementById('phoneError');
            
            if (phone.length !== 11) {
                input.classList.add('input-error');
                errorElement.style.display = 'block';
                return false;
            } else {
                input.classList.remove('input-error');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validatePasswords() {
            const senha = document.getElementById('senha').value;
            const confirmarSenha = document.getElementById('confirmarSenha').value;
            const errorElement = document.getElementById('senhaError');
            
            // Se ambos os campos estiverem vazios, está ok (mantém a senha atual)
            if (senha === '' && confirmarSenha === '') {
                errorElement.style.display = 'none';
                return true;
            }
            
            // Se apenas um dos campos estiver preenchido, mostra erro
            if ((senha === '' && confirmarSenha !== '') || (senha !== '' && confirmarSenha === '')) {
                errorElement.textContent = 'Preencha ambos os campos de senha';
                errorElement.style.display = 'block';
                return false;
            }
            
            // Se as senhas não coincidirem, mostra erro
            if (senha !== confirmarSenha) {
                errorElement.textContent = 'As senhas não coincidem';
                errorElement.style.display = 'block';
                return false;
            }
            
            errorElement.style.display = 'none';
            return true;
        }

        function validateForm() {
            const nameValid = validateName(document.getElementById('nome'));
            const cpfValid = validateCPF(document.getElementById('cpf'));
            const phoneValid = validatePhone(document.getElementById('celular'));
            const passwordsValid = validatePasswords();
            
            return nameValid && cpfValid && phoneValid && passwordsValid;
        }
    </script>
</body>
</html> 
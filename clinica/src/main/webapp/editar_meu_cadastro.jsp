<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mack.clinica.model.Paciente" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Meu Cadastro</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .form-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #666;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-buttons {
            text-align: center;
            margin-top: 30px;
        }
        .button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 10px;
        }
        .button.secondary {
            background-color: #6c757d;
            text-decoration: none;
            display: inline-block;
        }
        .button:hover {
            opacity: 0.9;
        }
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
        .input-error {
            border-color: #dc3545 !important;
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

    <div class="content">
        <h1>Editar Meu Cadastro</h1>
        
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div style="color: #dc3545; background-color: #f8d7da; padding: 10px; margin: 10px 0; border-radius: 4px;">
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
                    <input type="text" id="nome" name="nome" value="<%= paciente.getNome() %>" required 
                           pattern="[A-Za-zÀ-ÿ\s]+" oninput="validateName(this)">
                    <div id="nameError" class="error-message">O nome deve conter apenas letras e espaços</div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= paciente.getEmail() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <input type="text" id="cpf" name="cpf" value="<%= paciente.getCpf() %>" required 
                           pattern="\d{11}" maxlength="11" oninput="validateCPF(this)">
                    <div id="cpfError" class="error-message">O CPF deve conter exatamente 11 dígitos numéricos</div>
                </div>
                
                <div class="form-group">
                    <label for="celular">Telefone:</label>
                    <input type="tel" id="celular" name="celular" value="<%= paciente.getCelular().replaceAll("\\.0$", "") %>" required 
                           pattern="\d{11}" maxlength="11" oninput="validatePhone(this)">
                    <div id="phoneError" class="error-message">O telefone deve conter exatamente 11 dígitos (DDD + número com 9)</div>
                </div>
                
                <div class="form-group">
                    <label for="senha">Nova Senha (deixe em branco para manter a atual):</label>
                    <input type="password" id="senha" name="senha">
                </div>
                
                <div class="form-group">
                    <label for="confirmarSenha">Confirmar Nova Senha:</label>
                    <input type="password" id="confirmarSenha" name="confirmarSenha">
                    <div id="senhaError" class="error-message">As senhas não coincidem</div>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="button">Salvar Alterações</button>
                    <a href="meu-cadastro" class="button secondary">Cancelar</a>
                </div>
            </form>
        <%
            } else {
        %>
            <p>Não foi possível carregar suas informações. Por favor, tente novamente mais tarde.</p>
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
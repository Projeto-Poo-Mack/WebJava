<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cadastro - Clínica</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/modern.css">
    <style>
        .register-container {
            max-width: 500px;
            margin: 3rem auto;
            padding: 2rem;
        }
        
        .register-container h2 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 2rem;
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
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        #msgErro {
            background-color: var(--danger-color);
            color: white;
            padding: 1rem;
            border-radius: 0.375rem;
            margin-top: 1rem;
        }
    </style>
</head>
<body>

<div class="register-container card fade-in">
    <h2>Cadastro</h2>
    <form method="post" action="registerAction">
        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="confirmarSenha">Confirmar Senha:</label>
            <input type="password" id="confirmarSenha" name="confirmarSenha" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="celular">Celular:</label>
            <input type="tel" id="celular" name="celular" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%;">Cadastrar</button>
    </form>

    <div class="login-link">
        Já tem uma conta? <a href="index.jsp">Faça login</a>
    </div>

    <%
        String erro = request.getParameter("erro");
        if (erro != null) {
            String mensagem = "";
            switch (erro) {
                case "senha":
                    mensagem = "As senhas não coincidem.";
                    break;
                case "email":
                    mensagem = "Este e-mail já está cadastrado.";
                    break;
                case "cpf":
                    mensagem = "Este CPF já está cadastrado.";
                    break;
                default:
                    mensagem = "Erro ao realizar cadastro. Tente novamente.";
            }
    %>
        <p id="msgErro">
            <%= mensagem %>
        </p>
    <%
        }
    %>
</div>

<script>
    // Remove o parâmetro 'erro' da URL sem recarregar a página
    (function() {
        const url = new URL(window.location);
        if (url.searchParams.get('erro')) {
            url.searchParams.delete('erro');
            window.history.replaceState(null, '', url.toString());
        }
    })();
</script>

</body>
</html> 
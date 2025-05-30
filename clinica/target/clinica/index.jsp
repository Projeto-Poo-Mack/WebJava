<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Clínica</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/modern.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 5rem auto;
            padding: 2rem;
        }
        
        .login-container h2 {
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
        
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .register-link a:hover {
            text-decoration: underline;
        }
        
        .success-message {
            background-color: var(--success-color);
            color: white;
            padding: 1rem;
            border-radius: 0.375rem;
            margin-top: 1rem;
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

<div class="login-container card fade-in">
    <h2>Login</h2>
    <form method="post" action="loginAction">
        <div class="form-group">
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%;">Entrar</button>
    </form>

    <div class="register-link">
        Não tem uma conta? <a href="register.jsp">Cadastre-se</a>
    </div>

    <%
        String erro = request.getParameter("erro");
        String sucesso = request.getParameter("sucesso");
        
        if ("login".equals(erro)) {
    %>
        <p id="msgErro">
            E-mail ou senha inválidos. Tente novamente.
        </p>
    <%
        } else if ("cadastro".equals(sucesso)) {
    %>
        <p class="success-message">
            Cadastro realizado com sucesso! Faça login para continuar.
        </p>
    <%
        }
    %>
</div>

<script>
    (function() {
        const url = new URL(window.location);
        if (url.searchParams.get('erro') === 'login' || url.searchParams.get('sucesso') === 'cadastro') {
            // Remove os parâmetros da URL
            url.searchParams.delete('erro');
            url.searchParams.delete('sucesso');
            window.history.replaceState(null, '', url.toString());
        }
    })();
</script>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <style>
        .register-link {
            text-align: center;
            margin-top: 15px;
        }
        .register-link a {
            color: #0066cc;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .success-message {
            color: green;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Login</h2>
    <form method="post" action="loginAction">
        <label for="email">E-mail:</label>
        <input type="text" id="email" name="email" required>

        <label for="senha">Senha:</label>
        <input type="password" id="senha" name="senha" required>

        <button type="submit">Entrar</button>
    </form>

    <div class="register-link">
        Não tem uma conta? <a href="register.jsp">Cadastre-se</a>
    </div>

    <%
        String erro = request.getParameter("erro");
        String sucesso = request.getParameter("sucesso");
        
        if ("login".equals(erro)) {
    %>
        <p id="msgErro" style="color: red; font-weight: bold; margin-top: 10px;">
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

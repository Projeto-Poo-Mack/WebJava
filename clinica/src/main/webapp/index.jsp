<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
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

    <%-- Exibe a mensagem de erro se o parâmetro ?erro=login estiver presente --%>
    <%
        String erro = request.getParameter("erro");
        if ("login".equals(erro)) {
    %>
        <p id="msgErro" style="color: red; font-weight: bold; margin-top: 10px;">
            E-mail ou senha inválidos. Tente novamente.
        </p>
    <%
        }
    %>
</div>

<%-- Script para remover o parâmetro ?erro=login da URL sem recarregar a página --%>
<script>
    (function() {
        const url = new URL(window.location);
        if (url.searchParams.get('erro') === 'login') {
            // Remove o parâmetro 'erro' da URL
            url.searchParams.delete('erro');
            window.history.replaceState(null, '', url.toString());
        }
    })();
</script>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cadastro</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <style>
        .register-container {
            width: 400px;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
        .login-link a {
            color: #0066cc;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container register-container">
    <h2>Cadastro</h2>
    <form method="post" action="registerAction">
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" required>

        <label for="email">E-mail:</label>
        <input type="email" id="email" name="email" required>

        <label for="senha">Senha:</label>
        <input type="password" id="senha" name="senha" required>

        <label for="confirmarSenha">Confirmar Senha:</label>
        <input type="password" id="confirmarSenha" name="confirmarSenha" required>

        <label for="cpf">CPF:</label>
        <input type="text" id="cpf" name="cpf" required>

        <label for="celular">Celular:</label>
        <input type="tel" id="celular" name="celular" required>

        <button type="submit">Cadastrar</button>
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
        <p id="msgErro" style="color: red; font-weight: bold; margin-top: 10px;">
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
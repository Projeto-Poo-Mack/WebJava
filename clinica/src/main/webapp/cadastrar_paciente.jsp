<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Cadastrar Paciente</title></head>
    <link rel="stylesheet" href="/css/style.css">

<body>
    <h2>Cadastrar Paciente</h2>
    <form action="${pageContext.request.contextPath}/pacientes" method="post">
        <input type="hidden" name="action" value="cadastrar" />
        Nome: <input type="text" name="nome" required /><br/>
        Email: <input type="email" name="email" required /><br/>
        cpf: <input type="text" name="cpf" required /><br/>
        celular: <input type="text" name="celular" required /><br/>
        Senha: <input type="password" name="senha" required /><br/>

        <input type="submit" value="Cadastrar" />
    </form>
    <a href="pacientes">Voltar</a>
</body>
</html>
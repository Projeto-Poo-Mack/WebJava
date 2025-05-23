<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mack.clinica.model.Paciente" %>
<%
    Paciente paciente = (Paciente) request.getAttribute("paciente");
%>
<html>
<head><title>Editar Paciente</title></head>
<body>
<% if (paciente == null) { %>
    <p style="color:red;">Paciente não encontrado.</p>
    <a href="pacientes">Voltar</a>
<% } else { %>
    <h2>Editar Paciente</h2>
    <form action="pacientes" method="post">
        <input type="hidden" name="action" value="editar" />
        <input type="hidden" name="id" value="<%= paciente.getId() %>" />
        Nome: <input type="text" name="nome" value="<%= paciente.getNome() %>" required /><br/>
        Email: <input type="email" name="email" value="<%= paciente.getEmail() %>" required /><br/>
        Senha: <input type="password" name="senha" value="<%= paciente.getSenha() %>" required /><br/>
        <input type="submit" value="Salvar" />
    </form>
    <a href="pacientes">Voltar</a>
<% } %>
</body>
</html>
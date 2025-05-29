<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.Medico" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Médicos</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="admin_dashboard">Home</a>
            <a href="medico">Cadastro de Médicos</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <div class="content">
        <h1>Lista de Médicos</h1>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/medico/novo" class="button">Novo Médico</a>
        </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>CPF</th>
                    <th>Celular</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% 
                List<Medico> medicos = (List<Medico>) request.getAttribute("medicos");
                if (medicos != null) {
                    for (Medico medico : medicos) {
                %>
                    <tr>
                        <td><%= medico.getId() %></td>
                        <td><%= medico.getNome() %></td>
                        <td><%= medico.getEmail() %></td>
                        <td><%= medico.getCpf() %></td>
                        <td><%= medico.getCelular() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/medico/editar?id=<%= medico.getId() %>" class="button-small">Editar</a>
                            <form action="${pageContext.request.contextPath}/medico/excluir" method="post" style="display: inline;">
                                <input type="hidden" name="id" value="<%= medico.getId() %>">
                                <button type="submit" class="button-small delete" onclick="return confirm('Tem certeza que deseja excluir este médico?')">Excluir</button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html> 
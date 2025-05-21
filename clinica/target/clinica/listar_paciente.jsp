<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.Usuario" %>
<html>
<head><title>Lista de Pacientes</title></head>
<body>
    <h2>Pacientes</h2>
    <a href="cadastrar_paciente.jsp">Novo Paciente</a>
    <table border="1">
        <tr>
            <th>ID</th><th>Nome</th><th>Ações</th>
        </tr>
        <%
            List<Usuario> pacientes = (List<Usuario>) request.getAttribute("pacientes");
            if (pacientes != null) {
                for (Usuario p : pacientes) {
        %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getNome() %></td>
            <td>
                <form action="pacientes" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="excluir" />
                    <input type="hidden" name="id" value="<%= p.getId() %>" />
                    <input type="submit" value="Excluir" onclick="return confirm('Tem certeza?');" />
                </form>
                <form action="editar_paciente.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= p.getId() %>" />
                    <input type="submit" value="Editar" />
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
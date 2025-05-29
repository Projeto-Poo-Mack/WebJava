<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mack.clinica.model.Medico" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Médico</title>
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
        <h1>Editar Médico</h1>
        
        <%
        Medico medico = (Medico) request.getAttribute("medico");
        if (medico != null) {
        %>
        <form action="${pageContext.request.contextPath}/medico/atualizar" method="post" class="form-container">
            <input type="hidden" name="id" value="<%= medico.getId() %>">
            
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= medico.getNome() %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= medico.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" placeholder="Deixe em branco para manter a senha atual">
            </div>

            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf" value="<%= medico.getCpf() %>" required pattern="\d{11}" title="Digite apenas números (11 dígitos)">
            </div>

            <div class="form-group">
                <label for="celular">Celular:</label>
                <input type="tel" id="celular" name="celular" value="<%= medico.getCelular() %>" required>
            </div>

            <div class="form-buttons">
                <button type="submit" class="button">Salvar</button>
                <a href="${pageContext.request.contextPath}/medico" class="button secondary">Cancelar</a>
            </div>
        </form>
        <% } else { %>
            <p>Médico não encontrado.</p>
            <a href="${pageContext.request.contextPath}/medico" class="button">Voltar</a>
        <% } %>
    </div>

    <script>
        // Máscara para CPF
        document.getElementById('cpf').addEventListener('input', function (e) {
            let x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,3})(\d{0,2})/);
            e.target.value = !x[2] ? x[1] : x[1] + '.' + x[2] + (x[3] ? '.' + x[3] : '') + (x[4] ? '-' + x[4] : '');
        });

        // Máscara para celular
        document.getElementById('celular').addEventListener('input', function (e) {
            let x = e.target.value.replace(/\D/g, '').match(/(\d{0,2})(\d{0,5})(\d{0,4})/);
            e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
        });
    </script>
</body>
</html> 
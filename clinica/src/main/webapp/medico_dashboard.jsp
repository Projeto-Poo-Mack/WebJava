<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Painel do Médico</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/medico_dashboard" class="active">Home</a>
            <a href="${pageContext.request.contextPath}/consultarAgenda">Consultar Agenda</a>
            <a href="${pageContext.request.contextPath}/fichaClinica">Ficha Clínica</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <div class="content">
        <h1>Painel do Médico</h1>
        <p>Bem-vindo ao seu painel, onde você poderá gerenciar suas consultas e fichas clínicas.</p>
    </div>

</body>
</html> 
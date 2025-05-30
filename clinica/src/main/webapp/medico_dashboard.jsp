<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Painel do Médico</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        .dashboard-item {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .dashboard-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .dashboard-item h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        .dashboard-item p {
            margin: 0;
            color: #666;
        }
    </style>
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
        <% if (request.getAttribute("medicoNome") != null) { %>
            <p>Bem-vindo, <%= request.getAttribute("medicoNome") %>!</p>
        <% } else { %>
            <p>Bem-vindo ao seu painel, onde você poderá gerenciar suas consultas e fichas clínicas.</p>
        <% } %>

        <div class="dashboard-grid">
            <a href="${pageContext.request.contextPath}/consultarAgenda" class="dashboard-item">
                <h3>Consultar Agenda</h3>
                <p>Visualize e gerencie suas consultas agendadas</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/fichaClinica" class="dashboard-item">
                <h3>Ficha Clínica</h3>
                <p>Registre e consulte as fichas clínicas dos pacientes</p>
            </a>
        </div>
    </div>

    <script>
        // Previne o comportamento padrão de duplo clique
        document.querySelectorAll('.dashboard-item').forEach(item => {
            item.addEventListener('dblclick', function(e) {
                e.preventDefault();
            });
        });
    </script>
</body>
</html> 
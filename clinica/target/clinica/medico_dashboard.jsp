<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Médico - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .navbar {
            padding: 1rem 2rem;
            background-color: var(--white);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .nav-links {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .nav-links a {
            color: var(--secondary-color);
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            transition: all 0.2s ease-in-out;
        }
        
        .nav-links a:hover {
            color: var(--primary-color);
            background-color: var(--light-color);
        }
        
        .nav-links a.active {
            color: var(--primary-color);
            background-color: var(--light-color);
            font-weight: 500;
        }
        
        .logout-link {
            margin-left: auto;
            color: var(--danger-color) !important;
        }
        
        .logout-link:hover {
            background-color: #fee7eb !important;
        }
        
        .content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .dashboard-welcome {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .dashboard-welcome h1 {
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            padding: 0;
        }
        
        .dashboard-item {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s ease-in-out;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .dashboard-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .dashboard-item h3 {
            color: var(--primary-color);
            margin: 0 0 1rem 0;
            font-size: 1.5rem;
        }
        
        .dashboard-item p {
            color: var(--secondary-color);
            margin: 0;
            line-height: 1.5;
        }
        
        @media (max-width: 768px) {
            .nav-links {
                flex-direction: column;
                padding: 1rem 0;
            }
            
            .logout-link {
                margin-left: 0;
                margin-top: 1rem;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
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
    <div class="content fade-in">
        <div class="dashboard-welcome">
            <h1>Painel do Médico</h1>
            <% if (request.getAttribute("medicoNome") != null) { %>
                <p>Bem-vindo, Dr(a). <%= request.getAttribute("medicoNome") %>!</p>
            <% } else { %>
                <p>Bem-vindo ao seu painel, onde você poderá gerenciar suas consultas e fichas clínicas.</p>
            <% } %>
        </div>

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
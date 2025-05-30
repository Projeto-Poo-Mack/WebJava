<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Administrador - Clínica</title>
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
        
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
        }
    </style>
</head>
<body>

    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="admin_dashboard" class="active">Home</a>
            <a href="pacientes">Cadastro de Pacientes</a>
            <a href="medico">Cadastro de Médicos</a>
            <a href="consultarAgenda">Consultar Agenda</a>
            <a href="fichaClinica">Ficha Clínica</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <div class="content fade-in">
        <div class="dashboard-welcome">
            <h1>Painel do Administrador</h1>
            <p>Bem-vindo ao painel administrativo. Aqui você poderá gerenciar pacientes e consultas.</p>
        </div>
        
        <div class="dashboard-stats">
            <div class="stat-card">
                <h3>Pacientes</h3>
                <p>Gerencie o cadastro de pacientes da clínica</p>
                <a href="pacientes" class="btn btn-primary mt-3">Acessar Cadastros</a>
            </div>
            
            <div class="stat-card">
                <h3>Médicos</h3>
                <p>Gerencie o cadastro de médicos da clínica</p>
                <a href="medico" class="btn btn-primary mt-3">Acessar Cadastros</a>
            </div>
            
            <div class="stat-card">
                <h3>Agenda</h3>
                <p>Visualize e gerencie as consultas agendadas</p>
                <a href="consultarAgenda" class="btn btn-primary mt-3">Ver Agenda</a>
            </div>
        </div>
    </div>

</body>
</html>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Paciente - Clínica</title>
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
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .dashboard-card {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            text-decoration: none;
            transition: all 0.2s ease-in-out;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .dashboard-card h3 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-size: 1.25rem;
        }
        
        .dashboard-card p {
            color: var(--secondary-color);
            margin-bottom: 1.5rem;
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
            <a href="paciente_dashboard" class="active">Home</a>
            <a href="agendarConsulta">Agendamento de Consultas</a>
            <a href="minhaAgenda">Minha Agenda</a>
            <a href="meu-cadastro">Meu Cadastro</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <div class="content fade-in">
        <div class="dashboard-welcome">
            <h1>Painel do Paciente</h1>
            <p>Bem-vindo ao seu painel, onde você poderá visualizar informações e agendar consultas.</p>
        </div>

        <div class="dashboard-grid">
            <a href="agendarConsulta" class="dashboard-card">
                <h3>Agendar Consulta</h3>
                <p>Marque uma nova consulta com nossos especialistas</p>
                <button class="btn btn-primary">Agendar Agora</button>
            </a>

            <a href="minhaAgenda" class="dashboard-card">
                <h3>Minha Agenda</h3>
                <p>Visualize suas consultas agendadas</p>
                <button class="btn btn-primary">Ver Agenda</button>
            </a>

            <a href="meu-cadastro" class="dashboard-card">
                <h3>Meu Cadastro</h3>
                <p>Atualize suas informações pessoais</p>
                <button class="btn btn-primary">Atualizar Dados</button>
            </a>
        </div>
    </div>

</body>
</html>

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
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            padding: 0 32px;
            font-family: 'Inter', Arial, sans-serif;
            margin-bottom: 2rem;
        }
        
        .navbar-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .navbar-logo span {
            font-size: 1.6rem;
            font-weight: bold;
            color: #2d7ff9;
        }
        
        .navbar-links {
            display: flex;
            gap: 32px;
        }
        
        .navbar-links a {
            color: #1a1a1a;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            transition: color 0.2s;
            padding: 8px 0;
            border-bottom: 2px solid transparent;
        }
        
        .navbar-links a:hover,
        .navbar-links a.active {
            color: #2d7ff9;
            border-bottom: 2px solid #2d7ff9;
        }
        
        .navbar-links .logout {
            color: #fff;
            background: #2d7ff9;
            border-radius: 4px;
            padding: 8px 16px;
            margin-left: 16px;
            transition: background 0.2s;
        }
        
        .navbar-links .logout:hover {
            background: #1a5fcc;
        }
        
        @media (max-width: 768px) {
            .navbar-container {
                flex-direction: column;
                height: auto;
                padding: 16px 0;
            }
            
            .navbar-links {
                flex-direction: column;
                gap: 16px;
                width: 100%;
                align-items: flex-end;
            }
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
    </style>
</head>
<body>

    <!-- Menu de Navegação -->
    <header class="navbar">
        <div class="navbar-container">
            <div class="navbar-logo">
                <span>Clínica</span>
            </div>
            <nav class="navbar-links">
                <a href="paciente_dashboard" class="active">Home</a>
                <a href="agendarConsulta">Agendamento de Consultas</a>
                <a href="minhaAgenda">Minha Agenda</a>
                <a href="meu-cadastro">Meu Cadastro</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
            </nav>
        </div>
    </header>

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

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
          <a href="admin_dashboard" class="active">Home</a>
          <a href="pacientes">Cadastro de Pacientes</a>
          <a href="medico">Cadastro de Médicos</a>
          <a href="consultarAgenda">Consultar Agenda</a>
          <a href="fichaClinica">Ficha Clínica</a>
          <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
        </nav>
      </div>
    </header>

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


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mack.clinica.model.Paciente" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Cadastro - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .profile-container {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .profile-info {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .profile-label {
            font-weight: 500;
            color: var(--dark-color);
        }
        
        .profile-value {
            color: var(--secondary-color);
        }
        
        .edit-button {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: var(--primary-color);
            color: var(--white);
            text-decoration: none;
            border-radius: 0.375rem;
            transition: all 0.2s ease-in-out;
        }
        
        .edit-button:hover {
            background-color: var(--primary-dark-color);
        }
        
        @media (max-width: 768px) {
            .profile-info {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }
            
            .profile-label {
                font-weight: 600;
            }
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
          <a href="paciente_dashboard">Home</a>
          <a href="agendarConsulta">Agendamento de Consultas</a>
          <a href="minhaAgenda">Minha Agenda</a>
          <a href="meu-cadastro" class="active">Meu Cadastro</a>
          <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
        </nav>
      </div>
    </header>
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
    </style>

    <!-- Conteúdo principal -->
    <div class="content fade-in">
        <div class="page-header">
            <h1>Meu Cadastro</h1>
            <p>Visualize e gerencie suas informações pessoais</p>
        </div>
        
        <%
            Paciente paciente = (Paciente) request.getAttribute("paciente");
            if (paciente != null) {
        %>
            <div class="profile-container">
                <div class="profile-info">
                    <div class="profile-label">Nome:</div>
                    <div class="profile-value"><%= paciente.getNome() %></div>
                    
                    <div class="profile-label">Email:</div>
                    <div class="profile-value"><%= paciente.getEmail() %></div>
                    
                    <div class="profile-label">CPF:</div>
                    <div class="profile-value"><%= paciente.getCpf() %></div>
                    
                    <div class="profile-label">Telefone:</div>
                    <div class="profile-value"><%= paciente.getCelular().replaceAll("\\.0$", "") %></div>
                </div>
                
                <div style="text-align: center;">
                    <a href="meu-cadastro?action=editar" class="edit-button">Editar Cadastro</a>
                </div>
            </div>
        <%
            } else {
        %>
            <div class="profile-container">
                <p style="text-align: center; color: var(--danger-color);">
                    Não foi possível carregar suas informações. Por favor, tente novamente mais tarde.
                </p>
            </div>
        <%
            }
        %>
    </div>
</body>
</html> 
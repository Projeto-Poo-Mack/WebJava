<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mack.clinica.model.Paciente" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Meu Cadastro</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-info {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 15px;
            margin-bottom: 20px;
        }
        .profile-label {
            font-weight: bold;
            color: #666;
        }
        .profile-value {
            color: #333;
        }
        .edit-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
        .edit-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="paciente_dashboard">Home</a>
            <a href="agendarConsulta">Agendamento de Consultas</a>
            <a href="#">Minha Agenda</a>
            <a href="meu-cadastro" class="active">Meu Cadastro</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <div class="profile-container">
        <div class="profile-header">
            <h1>Meu Cadastro</h1>
        </div>
        
        <%
            Paciente paciente = (Paciente) request.getAttribute("paciente");
            if (paciente != null) {
        %>
            <div class="profile-info">
                <div class="profile-label">Nome:</div>
                <div class="profile-value"><%= paciente.getNome() %></div>
                
                <div class="profile-label">Email:</div>
                <div class="profile-value"><%= paciente.getEmail() %></div>
                
                <div class="profile-label">CPF:</div>
                <div class="profile-value"><%= paciente.getCpf() %></div>
                
                <div class="profile-label">Telefone:</div>
                <div class="profile-value"><%= paciente.getCelular() %></div>
            </div>
            
            <div style="text-align: center;">
                <a href="meu-cadastro?action=editar" class="edit-button">Editar Cadastro</a>
            </div>
        <%
            } else {
        %>
            <p>Não foi possível carregar suas informações. Por favor, tente novamente mais tarde.</p>
        <%
            }
        %>
    </div>
</body>
</html> 
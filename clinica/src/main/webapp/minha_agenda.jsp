<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.AgendarConsultaDAO.Consulta" %>
<%@ page import="com.mack.clinica.util.DateFormatter" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Minha Agenda</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .appointments-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .appointments-table th,
        .appointments-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .appointments-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .appointments-table tr:hover {
            background-color: #f5f5f5;
        }
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
            font-weight: 500;
        }
        .status-agendada {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        .status-realizada {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .status-cancelada {
            background-color: #ffebee;
            color: #c62828;
        }
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="paciente_dashboard">Home</a>
            <a href="agendarConsulta">Agendamento de Consultas</a>
            <a href="minhaAgenda" class="active">Minha Agenda</a>
            <a href="meu-cadastro">Meu Cadastro</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <div class="content">
        <h1>Minha Agenda</h1>
        
        <div class="appointments-container">
            <table class="appointments-table">
                <thead>
                    <tr>
                        <th>Data e Hora</th>
                        <th>Médico</th>
                        <th>Status</th>
                        <th>Observações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Consulta> consultas = (List<Consulta>) request.getAttribute("consultas");
                        if (consultas != null && !consultas.isEmpty()) {
                            for (Consulta consulta : consultas) {
                    %>
                        <tr>
                            <td><%= DateFormatter.formatDateTime(consulta.getDataHora()) %></td>
                            <td><%= consulta.getMedicoNome() %></td>
                            <td>
                                <span class="status-badge status-<%= consulta.getStatus().toLowerCase() %>">
                                    <%= consulta.getStatus() %>
                                </span>
                            </td>
                            <td><%= consulta.getObservacoes() != null ? consulta.getObservacoes() : "" %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="4" class="empty-message">
                                Você não possui consultas agendadas.
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html> 
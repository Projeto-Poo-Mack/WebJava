<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.AgendarConsultaDAO.Consulta" %>
<%@ page import="com.mack.clinica.util.DateFormatter" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Agenda - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .appointments-container {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            overflow-x: auto;
        }
        
        .appointments-table {
            width: 100%;
            min-width: 800px;
            margin-bottom: 0;
        }
        
        .appointments-table th, .appointments-table td {
            text-align: center;
        }
        
        .appointments-table th {
            background-color: var(--light-color);
            color: var(--dark-color);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.025em;
        }
        
        .appointments-table td {
            vertical-align: middle;
        }
        
        .appointments-table tbody tr:hover {
            background-color: var(--light-color);
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 2rem;
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .status-agendada {
            background-color: #e0f7ec;
            color: #00864e;
        }
        
        .status-realizada {
            background-color: #e3ebf6;
            color: #12263f;
        }
        
        .status-cancelada {
            background-color: #fee7eb;
            color: #c9244b;
        }
        
        .empty-message {
            text-align: center;
            padding: 3rem;
            color: var(--secondary-color);
            font-size: 1.125rem;
        }
        
        .btn-cancel {
            background-color: var(--danger-color);
            color: var(--white);
            padding: 0.375rem 0.75rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }
        
        .btn-cancel:hover {
            background-color: #d32f2f;
            transform: translateY(-1px);
        }
        
        .alert {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .alert::before {
            content: '';
            width: 1.25rem;
            height: 1.25rem;
            background-position: center;
            background-repeat: no-repeat;
            background-size: contain;
        }
        
        .alert-success {
            background-color: #e0f7ec;
            color: #00864e;
        }
        
        .alert-success::before {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2300864e'%3E%3Cpath d='M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z'/%3E%3C/svg%3E");
        }
        
        .alert-error {
            background-color: #fee7eb;
            color: #c9244b;
        }
        
        .alert-error::before {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23c9244b'%3E%3Cpath d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z'/%3E%3C/svg%3E");
        }
        
        .page-header {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .page-header h1 {
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
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
          <a href="minhaAgenda" class="active">Minha Agenda</a>
          <a href="meu-cadastro">Meu Cadastro</a>
          <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
        </nav>
      </div>
    </header>

    <!-- Conteúdo principal -->
    <div class="content fade-in">
        <div class="page-header">
            <h1>Minha Agenda</h1>
            <p>Visualize e gerencie suas consultas agendadas</p>
        </div>
        
        <%
            String msg = request.getParameter("msg");
            if (msg != null) {
                if ("cancelada".equals(msg)) {
        %>
                    <div class="alert alert-success">
                        Consulta cancelada com sucesso!
                    </div>
        <%
                } else if ("erro".equals(msg)) {
        %>
                    <div class="alert alert-error">
                        Erro ao cancelar a consulta. Por favor, tente novamente.
                    </div>
        <%
                }
            }
        %>
        
        <div class="appointments-container">
            <table class="appointments-table table">
                <thead>
                    <tr>
                        <th>Data e Hora</th>
                        <th>Médico</th>
                        <th>Status</th>
                        <th>Observações</th>
                        <th>Ações</th>
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
                            <td>
                                <% if ("agendada".equalsIgnoreCase(consulta.getStatus())) { %>
                                    <form action="cancelarConsulta" method="post" style="display: inline;">
                                        <input type="hidden" name="consultaId" value="<%= consulta.getId() %>">
                                        <button type="submit" class="btn-cancel" 
                                                onclick="return confirm('Tem certeza que deseja cancelar esta consulta?')">
                                            Cancelar
                                        </button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" class="empty-message">
                                <div>
                                    <p>Você não possui consultas agendadas.</p>
                                    <a href="agendarConsulta" class="btn btn-primary mt-3">Agendar Consulta</a>
                                </div>
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
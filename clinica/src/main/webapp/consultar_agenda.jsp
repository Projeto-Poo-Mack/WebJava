<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.AgendarConsultaDAO.Consulta" %>
<%@ page import="com.mack.clinica.util.DateFormatter" %>
<%@ page import="com.mack.clinica.model.Usuario" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Agenda - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .filters {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .filters form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            align-items: flex-end;
        }
        
        .filter-group {
            margin-bottom: 0;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            font-weight: 500;
        }
        
        .filter-group input {
            width: 100%;
            padding: 0.5rem 0.75rem;
            border: 1px solid #e3ebf6;
            border-radius: 0.375rem;
            transition: border-color 0.2s ease-in-out;
        }
        
        .filter-group input:focus {
            border-color: var(--primary-color);
            outline: none;
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
        
        .table-container {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            overflow-x: auto;
        }
        
        .table {
            min-width: 800px;
        }
        
        .table th {
            background-color: var(--light-color);
            color: var(--dark-color);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.025em;
        }
        
        .table td {
            vertical-align: middle;
        }
        
        .table tbody tr:hover {
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
        
        .status-cancelada {
            background-color: #fee7eb;
            color: #c9244b;
        }
        
        .status-concluida {
            background-color: #e3ebf6;
            color: #12263f;
        }
        
        .empty-message {
            text-align: center;
            padding: 3rem;
            color: var(--secondary-color);
            font-size: 1.125rem;
        }
        
        @media (max-width: 768px) {
            .filters form {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <% 
            String userType = (String) session.getAttribute("tipo");
            String dashboardLink = "admin".equals(userType) ? "admin_dashboard" : "medico_dashboard";
            %>
            <a href="${pageContext.request.contextPath}/<%= dashboardLink %>">Home</a>
            <a href="${pageContext.request.contextPath}/consultarAgenda" class="active">Consultar Agenda</a>
            <a href="${pageContext.request.contextPath}/fichaClinica">Ficha Clínica</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <div class="content fade-in">
        <div class="page-header">
            <h1>Consultar Agenda</h1>
            <p>Visualize e gerencie as consultas agendadas</p>
        </div>
        
        <!-- Filtros -->
        <div class="filters">
            <form method="get" action="consultarAgenda">
                <div class="filter-group">
                    <label for="paciente">Paciente:</label>
                    <input type="text" id="paciente" name="paciente" class="form-control"
                           value="${filtro_paciente}" placeholder="Nome do paciente">
                </div>
                <div class="filter-group">
                    <label for="medico">Médico:</label>
                    <select id="medico" name="medico" class="form-control">
                        <option value="">Todos os médicos</option>
                        <%
                            List<Usuario> medicos = (List<Usuario>) request.getAttribute("medicos");
                            if (medicos != null) {
                                for (Usuario medico : medicos) {
                                    String selected = medico.getNome().equals(request.getParameter("medico")) ? "selected" : "";
                        %>
                                    <option value="<%= medico.getNome() %>" <%= selected %>><%= medico.getNome() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="data">Data:</label>
                    <input type="date" id="data" name="data" class="form-control"
                           value="${filtro_data}">
                </div>
                <div class="filter-group">
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Filtrar</button>
                </div>
            </form>
        </div>

        <!-- Tabela de Consultas -->
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Paciente</th>
                        <th>Médico</th>
                        <th>Data e Hora</th>
                        <th>Status</th>
                        <th>Observações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<Consulta> consultas = (List<Consulta>) request.getAttribute("consultas");
                    if (consultas != null && !consultas.isEmpty()) {
                        for (Consulta consulta : consultas) {
                            String statusClass = "";
                            switch(consulta.getStatus().toLowerCase()) {
                                case "agendada":
                                    statusClass = "status-agendada";
                                    break;
                                case "cancelada":
                                    statusClass = "status-cancelada";
                                    break;
                                case "concluída":
                                case "concluida":
                                    statusClass = "status-concluida";
                                    break;
                            }
                    %>
                        <tr>
                            <td><%= consulta.getPacienteNome() %></td>
                            <td><%= consulta.getMedicoNome() %></td>
                            <td><%= DateFormatter.formatDateTime(consulta.getDataHora()) %></td>
                            <td><span class="status-badge <%= statusClass %>"><%= consulta.getStatus() %></span></td>
                            <td><%= consulta.getObservacoes() != null ? consulta.getObservacoes() : "" %></td>
                        </tr>
                    <%
                        }
                    } else {
                    %>
                        <tr>
                            <td colspan="5" class="empty-message">
                                <div>
                                    <p>Nenhuma consulta encontrada com os filtros selecionados.</p>
                                    <button onclick="document.querySelector('form').reset(); document.querySelector('form').submit();" 
                                            class="btn btn-secondary mt-3">Limpar Filtros</button>
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
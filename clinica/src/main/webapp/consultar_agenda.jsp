<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.AgendarConsultaDAO.Consulta" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consultar Agenda</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .filters {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }
        .filters form {
            display: flex;
            gap: 15px;
            align-items: flex-end;
        }
        .filter-group {
            flex: 1;
        }
        .filter-group label {
            display: block;
            margin-bottom: 5px;
        }
        .filter-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .empty-message {
            text-align: center;
            padding: 20px;
            color: #666;
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
    <div class="content">
        <h1>Consultar Agenda</h1>
        
        <!-- Filtros -->
        <div class="filters">
            <form method="get" action="consultarAgenda">
                <div class="filter-group">
                    <label for="paciente">Paciente:</label>
                    <input type="text" id="paciente" name="paciente" 
                           value="${filtro_paciente}" placeholder="Nome do paciente">
                </div>
                <div class="filter-group">
                    <label for="medico">Médico:</label>
                    <input type="text" id="medico" name="medico" 
                           value="${filtro_medico}" placeholder="Nome do médico">
                </div>
                <div class="filter-group">
                    <label for="data">Data:</label>
                    <input type="date" id="data" name="data" 
                           value="${filtro_data}">
                </div>
                <div class="filter-group">
                    <button type="submit" class="button">Filtrar</button>
                </div>
            </form>
        </div>

        <!-- Tabela de Consultas -->
        <table>
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
                %>
                    <tr>
                        <td><%= consulta.getPacienteNome() %></td>
                        <td><%= consulta.getMedicoNome() %></td>
                        <td><%= consulta.getDataHora() %></td>
                        <td><%= consulta.getStatus() %></td>
                        <td><%= consulta.getObservacoes() != null ? consulta.getObservacoes() : "" %></td>
                    </tr>
                <%
                    }
                } else {
                %>
                    <tr>
                        <td colspan="5" class="empty-message">
                            Nenhuma consulta encontrada com os filtros selecionados.
                        </td>
                    </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html> 
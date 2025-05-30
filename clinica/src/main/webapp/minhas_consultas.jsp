<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.controller.MinhasConsultasServlet.FichaClinica" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Histórico de Fichas Clínicas - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .fichas-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .ficha-card {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .ficha-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e3ebf6;
        }
        
        .ficha-title {
            color: var(--primary-color);
            font-size: 1.25rem;
            font-weight: 600;
        }
        
        .ficha-date {
            color: var(--dark-color);
            font-size: 0.875rem;
        }
        
        .ficha-details {
            margin-bottom: 1rem;
        }
        
        .detail-group {
            margin-bottom: 1rem;
        }
        
        .detail-label {
            color: var(--dark-color);
            font-weight: 500;
            margin-bottom: 0.25rem;
        }
        
        .detail-value {
            color: var(--text-color);
            white-space: pre-wrap;
            background-color: #f8f9fa;
            padding: 0.75rem;
            border-radius: 0.25rem;
            border: 1px solid #e9ecef;
        }
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .empty-message {
            text-align: center;
            padding: 3rem;
            background-color: var(--white);
            border-radius: 0.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .empty-message p {
            color: var(--text-color);
            margin-bottom: 1rem;
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
                <% 
                String userType = (String) session.getAttribute("tipo");
                String dashboardLink = "admin".equals(userType) ? "admin_dashboard" : "medico_dashboard";
                %>
                <a href="${pageContext.request.contextPath}/<%= dashboardLink %>">Home</a>
                <a href="${pageContext.request.contextPath}/consultarAgenda">Consultar Agenda</a>
                <a href="${pageContext.request.contextPath}/fichaClinica">Ficha Clínica</a>
                <a href="${pageContext.request.contextPath}/minhasConsultas" class="active">Minhas Consultas</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
            </nav>
        </div>
    </header>

    <div class="content fade-in">
        <div class="page-header">
            <h1>Histórico de Fichas Clínicas</h1>
            <p>Visualize todas as suas fichas clínicas registradas</p>
        </div>

        <% if (request.getAttribute("mensagem") != null) { %>
            <div class="<%= request.getAttribute("mensagem").toString().contains("Erro") ? "error-message" : "success-message" %>">
                <%= request.getAttribute("mensagem") %>
            </div>
        <% } %>

        <div class="fichas-container">
            <% 
            List<FichaClinica> fichas = (List<FichaClinica>) request.getAttribute("fichas");
            if (fichas != null && !fichas.isEmpty()) {
                for (FichaClinica ficha : fichas) {
            %>
                <div class="ficha-card">
                    <div class="ficha-header">
                        <div class="ficha-title">
                            Ficha Clínica - <%= ficha.getPacienteNome() %>
                        </div>
                        <div class="ficha-date">
                            Data da Consulta: <%= ficha.getDataConsulta() %>
                        </div>
                    </div>
                    
                    <div class="ficha-details">
                        <div class="detail-group">
                            <div class="detail-label">Queixa Principal:</div>
                            <div class="detail-value"><%= ficha.getQueixaPrincipal() %></div>
                        </div>
                        
                        <div class="detail-group">
                            <div class="detail-label">História da Doença:</div>
                            <div class="detail-value"><%= ficha.getHistoriaDoenca() %></div>
                        </div>
                        
                        <div class="detail-group">
                            <div class="detail-label">Exame Físico:</div>
                            <div class="detail-value"><%= ficha.getExameFisico() %></div>
                        </div>
                        
                        <div class="detail-group">
                            <div class="detail-label">Diagnóstico:</div>
                            <div class="detail-value"><%= ficha.getDiagnostico() %></div>
                        </div>
                        
                        <div class="detail-group">
                            <div class="detail-label">Prescrição:</div>
                            <div class="detail-value"><%= ficha.getPrescricao() %></div>
                        </div>
                        
                        <% if (ficha.getObservacoes() != null && !ficha.getObservacoes().isEmpty()) { %>
                            <div class="detail-group">
                                <div class="detail-label">Observações:</div>
                                <div class="detail-value"><%= ficha.getObservacoes() %></div>
                            </div>
                        <% } %>
                    </div>
                </div>
            <%
                }
            } else {
            %>
                <div class="empty-message">
                    <p>Nenhuma ficha clínica encontrada.</p>
                </div>
            <%
            }
            %>
        </div>
    </div>
</body>
</html> 
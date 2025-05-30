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
        /* Estilos gerais podem vir de modern.css */

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

        .ficha-actions {
            /* Estilos para o grupo de botões (se houver) */
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
        
        .detail-group:last-child {
             margin-bottom: 0;
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
        
        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
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

        /* Estilos do navbar (copiar do modelo moderno) */
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

        /* Estilos para o cabeçalho da página (Histórico de Fichas Clínicas) */
        .page-header {
            background-color: var(--white); /* Fundo branco */
            border-radius: 0.5rem;
            padding: 2rem; /* Espaçamento interno */
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .page-header h1 {
             color: var(--primary-color); /* Usar variável para consistência */
             margin-bottom: 0.5rem; /* Ajuste o espaço abaixo do título */
        }

        .page-header p {
            margin-top: 0; 
            margin-bottom: 0; /* Remover margem inferior se necessário */
             color: var(--text-color); /* Cor do texto */
             font-size: 1rem; /* Tamanho da fonte do texto */
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

    <!-- Conteúdo principal -->
    <div class="content fade-in">
        <div class="page-header">
            <h1>Histórico de Fichas Clínicas</h1>
            <p>Visualize todas as suas fichas clínicas registradas</p>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">
                Ocorreu um erro ao processar sua solicitação. Por favor, tente novamente.
            </div>
        <% } %>

        <% if (request.getParameter("success") != null) { 
            String successType = request.getParameter("success");
            if ("deleted".equals(successType)) { %>
                <div class="alert alert-success">
                    Ficha clínica excluída com sucesso!
                </div>
            <% } else { %>
                <div class="alert alert-success">
                    Ficha clínica salva com sucesso!
                </div>
            <% } %>
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
                        <div class="ficha-actions">
                            <form method="post" action="${pageContext.request.contextPath}/excluirFicha" style="display: inline;">
                                <input type="hidden" name="fichaId" value="<%= ficha.getId() %>">
                                <button type="submit" class="btn btn-danger" 
                                        onclick="return confirm('Tem certeza que deseja excluir esta ficha clínica?')">
                                    Excluir
                                </button>
                            </form>
                        </div>
                    </div>
                    <div class="ficha-date">
                        Data da Consulta: <%= ficha.getDataConsulta() %>
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
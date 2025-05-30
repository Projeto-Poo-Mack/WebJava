<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ficha Clínica - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-section {
            background-color: var(--white);
            padding: 1.5rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .form-section h2 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 1.25rem;
            font-weight: 600;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group:last-child {
            margin-bottom: 0;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            font-weight: 500;
        }
        
        .form-group textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .consultation-info {
            background-color: var(--light-color);
            padding: 1.5rem;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
            border: 1px solid #e3ebf6;
        }
        
        .consultation-info h2 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 1.25rem;
            font-weight: 600;
        }
        
        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }
        
        .button-group button {
            min-width: 120px;
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
        
        @media (max-width: 768px) {
            .button-group {
                flex-direction: column;
            }
            
            .button-group button {
                width: 100%;
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
          <% 
          String userType = (String) session.getAttribute("tipo");
          String dashboardLink = "admin".equals(userType) ? "admin_dashboard" : "medico_dashboard";
          %>
          <a href="${pageContext.request.contextPath}/<%= dashboardLink %>">Home</a>
          <a href="${pageContext.request.contextPath}/consultarAgenda">Consultar Agenda</a>
          <a href="${pageContext.request.contextPath}/fichaClinica" class="active">Ficha Clínica</a>
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
            <h1>Ficha Clínica</h1>
            <p>Preencha os dados da consulta médica</p>
        </div>
        
        <form method="post" action="fichaClinica" class="form-container">
            <!-- Informações da Consulta -->
            <div class="consultation-info">
                <h2>Informações da Consulta</h2>
                <div class="form-group">
                    <label for="paciente-nome">Nome do Paciente:</label>
                    <input type="text" id="paciente-nome" name="pacienteNome" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="medico-nome">Nome do Médico:</label>
                    <input type="text" id="medico-nome" name="medicoNome" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="data-consulta">Data da Consulta:</label>
                    <input type="datetime-local" id="data-consulta" name="dataConsulta" class="form-control" required>
                </div>
            </div>

            <!-- Queixa Principal -->
            <div class="form-section">
                <h2>Queixa Principal</h2>
                <div class="form-group">
                    <textarea name="queixaPrincipal" id="queixaPrincipal" class="form-control"
                              placeholder="Descreva a queixa principal do paciente"></textarea>
                </div>
            </div>

            <!-- História da Doença Atual -->
            <div class="form-section">
                <h2>História da Doença Atual</h2>
                <div class="form-group">
                    <textarea name="historiaDoenca" id="historiaDoenca" class="form-control"
                              placeholder="Descreva a história da doença atual"></textarea>
                </div>
            </div>

            <!-- Exame Físico -->
            <div class="form-section">
                <h2>Exame Físico</h2>
                <div class="form-group">
                    <textarea name="exameFisico" id="exameFisico" class="form-control"
                              placeholder="Registre os achados do exame físico"></textarea>
                </div>
            </div>

            <!-- Diagnóstico -->
            <div class="form-section">
                <h2>Diagnóstico</h2>
                <div class="form-group">
                    <textarea name="diagnostico" id="diagnostico" class="form-control"
                              placeholder="Registre o diagnóstico"></textarea>
                </div>
            </div>

            <!-- Prescrição -->
            <div class="form-section">
                <h2>Prescrição</h2>
                <div class="form-group">
                    <textarea name="prescricao" id="prescricao" class="form-control"
                              placeholder="Registre a prescrição médica"></textarea>
                </div>
            </div>

            <!-- Observações -->
            <div class="form-section">
                <h2>Observações</h2>
                <div class="form-group">
                    <textarea name="observacoes" id="observacoes" class="form-control"
                              placeholder="Registre observações adicionais"></textarea>
                </div>
            </div>

            <!-- Botões -->
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Salvar Ficha</button>
                <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancelar</button>
            </div>
        </form>
    </div>
</body>
</html> 
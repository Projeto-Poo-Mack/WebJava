<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.Usuario" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agendar Consulta - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            font-weight: 500;
        }
        
        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%236c757d' viewBox='0 0 16 16'%3E%3Cpath d='M8 11.5l-5-5h10l-5 5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            padding-right: 2.5rem;
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
    </style>
</head>
<body>

    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="paciente_dashboard">Home</a>
            <a href="agendarConsulta" class="active">Agendamento de Consultas</a>
            <a href="minhaAgenda">Minha Agenda</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <div class="content fade-in">
        <div class="page-header">
            <h1>Agendar Consulta</h1>
            <p>Selecione o médico e a data/hora desejada para sua consulta</p>
        </div>

        <div class="card">
            <form method="post" action="agendarConsulta" class="form-container">
                <div class="form-group">
                    <label for="profissionalId">Profissional:</label>
                    <select id="profissionalId" name="profissionalId" class="form-control" required>
                        <option value="">Selecione o médico</option>
                        <%
                            List<Usuario> medicos = (List<Usuario>) request.getAttribute("medicos");
                            if (medicos != null) {
                                for (Usuario medico : medicos) {
                        %>
                                    <option value="<%= medico.getId() %>"><%= medico.getNome() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="dataHora">Data e Hora:</label>
                    <input type="datetime-local" id="dataHora" name="dataHora" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%;">Agendar Consulta</button>
            </form>
        </div>
    </div>

</body>
</html>
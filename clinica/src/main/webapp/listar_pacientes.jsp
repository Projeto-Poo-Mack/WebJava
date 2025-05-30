<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.Usuario" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Pacientes - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
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
        
        .table th, .table td {
            text-align: center;
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
        
        .action-buttons {
            margin-bottom: 1.5rem;
        }
        
        .btn-new {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
        }
        
        .btn-new::before {
            content: '+';
            font-size: 1.25rem;
            font-weight: 500;
            margin-right: 0.25rem;
        }
        
        .btn-action {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            border-radius: 0.375rem;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }
        
        .btn-edit {
            background-color: var(--info-color);
            color: var(--white);
        }
        
        .btn-edit:hover {
            background-color: #2d8aae;
        }
        
        .btn-delete {
            background-color: var(--danger-color);
            color: var(--white);
            margin-right: 0.5rem;
        }
        
        .btn-delete:hover {
            background-color: #d32f2f;
        }
        
        .action-cell {
            white-space: nowrap;
        }
        
        .page-header {
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-header h1 {
            color: var(--primary-color);
            margin: 0;
        }
        
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .action-buttons {
                width: 100%;
            }
            
            .btn-new {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="admin_dashboard">Home</a>
            <a href="pacientes" class="active">Cadastro de Pacientes</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <div class="content fade-in">
        <div class="page-header">
            <h1>Lista de Pacientes</h1>
            <div class="action-buttons">
                <a href="cadastrar_paciente.jsp" class="btn btn-primary btn-new">Novo Paciente</a>
            </div>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Email</th>
                        <th>CPF</th>
                        <th>Celular</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Usuario> pacientes = (List<Usuario>) request.getAttribute("pacientes");
                        if (pacientes != null && !pacientes.isEmpty()) {
                            for (Usuario p : pacientes) {
                    %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getNome() %></td>
                        <td><%= p.getEmail() %></td>
                        <td><%= p.getCpf() %></td>
                        <td><%= p.getCelular() %></td>
                        <td class="action-cell">
                            <form action="pacientes" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="excluir" />
                                <input type="hidden" name="id" value="<%= p.getId() %>" />
                                <button type="submit" class="btn-action btn-delete" 
                                        onclick="return confirm('Tem certeza que deseja excluir este paciente?')">
                                    Excluir
                                </button>
                            </form>
                            <form action="pacientes" method="get" style="display:inline;">
                                <input type="hidden" name="action" value="editar" />
                                <input type="hidden" name="id" value="<%= p.getId() %>" />
                                <button type="submit" class="btn-action btn-edit">Editar</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="6" class="empty-message">
                                <div>
                                    <p>Nenhum paciente cadastrado.</p>
                                    <a href="cadastrar_paciente.jsp" class="btn btn-primary mt-3">Cadastrar Paciente</a>
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
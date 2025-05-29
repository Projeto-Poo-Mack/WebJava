<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Ficha Clínica</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        .form-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .form-section h2 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #333;
            font-size: 1.2em;
        }
        .button-group {
            margin-top: 30px;
            text-align: center;
        }
        .button-group button {
            margin: 0 10px;
            padding: 10px 20px;
        }
        .consultation-info {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .consultation-info p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="admin_dashboard">Home</a>
            <a href="consultarAgenda">Consultar Agenda</a>
            <a href="fichaClinica" class="active">Ficha Clínica</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <div class="content">
        <h1>Ficha Clínica</h1>
        
        <form method="post" action="fichaClinica" class="form-container">
            <!-- Informações da Consulta -->
            <div class="consultation-info">
                <h2>Informações da Consulta</h2>
                <p><strong>Paciente:</strong> <span id="paciente-nome">[Nome do Paciente]</span></p>
                <p><strong>Médico:</strong> <span id="medico-nome">[Nome do Médico]</span></p>
                <p><strong>Data:</strong> <span id="data-consulta">[Data da Consulta]</span></p>
            </div>

            <!-- Queixa Principal -->
            <div class="form-section">
                <h2>Queixa Principal</h2>
                <div class="form-group">
                    <textarea name="queixaPrincipal" id="queixaPrincipal" 
                              placeholder="Descreva a queixa principal do paciente"></textarea>
                </div>
            </div>

            <!-- História da Doença Atual -->
            <div class="form-section">
                <h2>História da Doença Atual</h2>
                <div class="form-group">
                    <textarea name="historiaDoenca" id="historiaDoenca" 
                              placeholder="Descreva a história da doença atual"></textarea>
                </div>
            </div>

            <!-- Exame Físico -->
            <div class="form-section">
                <h2>Exame Físico</h2>
                <div class="form-group">
                    <textarea name="exameFisico" id="exameFisico" 
                              placeholder="Registre os achados do exame físico"></textarea>
                </div>
            </div>

            <!-- Diagnóstico -->
            <div class="form-section">
                <h2>Diagnóstico</h2>
                <div class="form-group">
                    <textarea name="diagnostico" id="diagnostico" 
                              placeholder="Registre o diagnóstico"></textarea>
                </div>
            </div>

            <!-- Prescrição -->
            <div class="form-section">
                <h2>Prescrição</h2>
                <div class="form-group">
                    <textarea name="prescricao" id="prescricao" 
                              placeholder="Registre a prescrição médica"></textarea>
                </div>
            </div>

            <!-- Observações -->
            <div class="form-section">
                <h2>Observações</h2>
                <div class="form-group">
                    <textarea name="observacoes" id="observacoes" 
                              placeholder="Registre observações adicionais"></textarea>
                </div>
            </div>

            <!-- Botões -->
            <div class="button-group">
                <button type="submit" class="button">Salvar</button>
                <button type="button" class="button secondary" onclick="window.history.back()">Cancelar</button>
            </div>
        </form>
    </div>
</body>
</html> 
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Médico - Clínica</title>
    <link rel="stylesheet" href="css/modern.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: var(--white);
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
        
        .form-group input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e3ebf6;
            border-radius: 0.375rem;
            transition: border-color 0.2s ease-in-out;
            font-size: 1rem;
        }
        
        .form-group input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }
        
        .form-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .form-buttons button,
        .form-buttons a {
            flex: 1;
            text-align: center;
            padding: 0.75rem 1.5rem;
            border-radius: 0.375rem;
            font-weight: 500;
            transition: all 0.2s ease-in-out;
        }
        
        .form-buttons .btn-secondary {
            background-color: var(--light-color);
            color: var(--dark-color);
            border: 1px solid #e3ebf6;
        }
        
        .form-buttons .btn-secondary:hover {
            background-color: #e3ebf6;
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
            .form-buttons {
                flex-direction: column;
            }
            
            .form-buttons button,
            .form-buttons a {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Menu de Navegação -->
    <div class="navbar">
        <div class="nav-links">
            <a href="admin_dashboard">Home</a>
            <a href="medico" class="active">Cadastro de Médicos</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </div>

    <div class="content fade-in">
        <div class="page-header">
            <h1>Cadastrar Novo Médico</h1>
            <p>Preencha os dados do novo médico</p>
        </div>
        
        <form action="${pageContext.request.contextPath}/medico" method="post" class="form-container">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf" class="form-control" required 
                       pattern="\d{11}" title="Digite apenas números (11 dígitos)">
            </div>

            <div class="form-group">
                <label for="celular">Celular:</label>
                <input type="tel" id="celular" name="celular" class="form-control" required>
            </div>

            <div class="form-buttons">
                <button type="submit" class="btn btn-primary">Cadastrar</button>
                <a href="${pageContext.request.contextPath}/medico" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>

    <script>
        // Máscara para CPF
        document.getElementById('cpf').addEventListener('input', function (e) {
            let x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,3})(\d{0,2})/);
            e.target.value = !x[2] ? x[1] : x[1] + '.' + x[2] + (x[3] ? '.' + x[3] : '') + (x[4] ? '-' + x[4] : '');
        });

        // Máscara para celular
        document.getElementById('celular').addEventListener('input', function (e) {
            let x = e.target.value.replace(/\D/g, '').match(/(\d{0,2})(\d{0,5})(\d{0,4})/);
            e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
        });
    </script>
</body>
</html> 
package com.mack.clinica.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.net.URLEncoder;

import com.mack.clinica.model.MedicoDAO;
import com.mack.clinica.model.Medico;
import com.mack.clinica.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/fichaClinica")
public class FichaClinicaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("tipo");
        String userName = (String) session.getAttribute("nome");
        
        // Verifica se o usuário é administrador ou médico
        if (!"admin".equals(userType) && !"medico".equals(userType)) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Por enquanto, apenas redireciona para o formulário
        request.getRequestDispatcher("/ficha_clinica.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("tipo");
        String userName = (String) session.getAttribute("nome");
        
        System.out.println("DEBUG: Iniciando salvamento de ficha clínica");
        System.out.println("DEBUG: Tipo de usuário: " + userType);
        System.out.println("DEBUG: Nome do usuário: " + userName);
        
        // Verifica se o usuário é administrador ou médico
        if (!"admin".equals(userType) && !"medico".equals(userType)) {
            System.out.println("DEBUG: Usuário não autorizado");
            response.sendRedirect("index.jsp");
            return;
        }

        // Obtém os dados do formulário
        String pacienteNome = request.getParameter("pacienteNome");
        String dataConsulta = request.getParameter("dataConsulta");
        String queixaPrincipal = request.getParameter("queixaPrincipal");
        String historiaDoenca = request.getParameter("historiaDoenca");
        String exameFisico = request.getParameter("exameFisico");
        String diagnostico = request.getParameter("diagnostico");
        String prescricao = request.getParameter("prescricao");
        String observacoes = request.getParameter("observacoes");
        String dataRegistro = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Validação dos campos obrigatórios
        if (pacienteNome == null || pacienteNome.trim().isEmpty() ||
            dataConsulta == null || dataConsulta.trim().isEmpty()) {
            System.out.println("DEBUG: Campos obrigatórios não preenchidos");
            response.sendRedirect(request.getContextPath() + "/fichaClinica?error=true");
            return;
        }

        // Debug logs
        System.out.println("DEBUG: Dados da ficha clínica:");
        System.out.println("Paciente: " + pacienteNome);
        System.out.println("Médico: " + userName);
        System.out.println("Data Consulta: " + dataConsulta);
        System.out.println("Data Registro: " + dataRegistro);
        System.out.println("Queixa Principal: " + queixaPrincipal);
        System.out.println("História da Doença: " + historiaDoenca);
        System.out.println("Exame Físico: " + exameFisico);
        System.out.println("Diagnóstico: " + diagnostico);
        System.out.println("Prescrição: " + prescricao);
        System.out.println("Observações: " + observacoes);

        try {
            String realPath = getServletContext().getRealPath("/");
            System.out.println("DEBUG: Real Path: " + realPath);
            Connection conn = DatabaseConnection.getConnection(realPath);
            System.out.println("DEBUG: Conexão com banco de dados estabelecida");
            
            // Criar a tabela se não existir
            String createTableSQL = "CREATE TABLE IF NOT EXISTS ficha_clinica (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "paciente_nome TEXT NOT NULL, " +
                "medico_nome TEXT NOT NULL, " +
                "data_consulta TEXT NOT NULL, " +
                "queixa_principal TEXT, " +
                "historia_doenca TEXT, " +
                "exame_fisico TEXT, " +
                "diagnostico TEXT, " +
                "prescricao TEXT, " +
                "observacoes TEXT, " +
                "data_registro TEXT NOT NULL)";
            
            try (PreparedStatement createStmt = conn.prepareStatement(createTableSQL)) {
                createStmt.execute();
                System.out.println("DEBUG: Tabela ficha_clinica verificada/criada com sucesso");
            }
            
            String sql = "INSERT INTO ficha_clinica (paciente_nome, medico_nome, data_consulta, queixa_principal, " +
                        "historia_doenca, exame_fisico, diagnostico, prescricao, observacoes, data_registro) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            System.out.println("DEBUG: SQL Query: " + sql);
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, pacienteNome);
                stmt.setString(2, userName);
                stmt.setString(3, dataConsulta);
                stmt.setString(4, queixaPrincipal);
                stmt.setString(5, historiaDoenca);
                stmt.setString(6, exameFisico);
                stmt.setString(7, diagnostico);
                stmt.setString(8, prescricao);
                stmt.setString(9, observacoes);
                stmt.setString(10, dataRegistro);
                
                // Executar a inserção
                int rowsAffected = stmt.executeUpdate();
                System.out.println("DEBUG: Ficha clínica salva com sucesso. Linhas afetadas: " + rowsAffected);
                
                if (rowsAffected > 0) {
                    // Redirecionar para a página de minhas consultas com mensagem de sucesso
                    response.sendRedirect(request.getContextPath() + "/minhasConsultas?success=true");
                } else {
                    // Se nenhuma linha foi afetada, houve um erro
                    System.out.println("DEBUG: Nenhuma linha afetada na inserção");
                    response.sendRedirect(request.getContextPath() + "/fichaClinica?error=true");
                }
            }
            
            conn.close();
            System.out.println("DEBUG: Conexão com banco de dados fechada");
            
        } catch (SQLException e) {
            System.err.println("Erro ao salvar ficha clínica: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/fichaClinica?error=true");
        }
    }
} 
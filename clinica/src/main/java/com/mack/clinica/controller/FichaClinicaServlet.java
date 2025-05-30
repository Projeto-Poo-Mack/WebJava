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
        
        // Verifica se o usuário é administrador ou médico
        if (!"admin".equals(userType) && !"medico".equals(userType)) {
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

        // Debug logs
        System.out.println("Salvando ficha clínica:");
        System.out.println("Paciente: " + pacienteNome);
        System.out.println("Médico: " + userName);
        System.out.println("Data Consulta: " + dataConsulta);
        System.out.println("Data Registro: " + dataRegistro);

        try {
            String realPath = getServletContext().getRealPath("/");
            Connection conn = DatabaseConnection.getConnection(realPath);
            
            String sql = "INSERT INTO ficha_clinica (paciente_nome, medico_nome, data_consulta, queixa_principal, " +
                        "historia_doenca, exame_fisico, diagnostico, prescricao, observacoes, data_registro) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, pacienteNome);
                stmt.setString(2, userName); // Usa o nome do médico logado
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
                
                // Redirecionar para a página de minhas consultas
                String contextPath = request.getContextPath();
                System.out.println("DEBUG: Context Path: " + contextPath);
                
                // Construir a URL de redirecionamento
                String redirectUrl = contextPath + "/minhasConsultas";
                System.out.println("DEBUG: URL de redirecionamento: " + redirectUrl);
                
                // Adicionar parâmetro de sucesso
                redirectUrl += "?success=true";
                System.out.println("DEBUG: URL final de redirecionamento: " + redirectUrl);
                
                // Fazer o redirecionamento
                response.sendRedirect(redirectUrl);
            }
            
            conn.close();
            
        } catch (SQLException e) {
            System.err.println("Erro ao salvar ficha clínica: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/fichaClinica?error=true");
        }
    }
} 
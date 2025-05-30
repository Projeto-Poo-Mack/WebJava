package com.mack.clinica.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
        
        // Verifica se o usuário é administrador ou médico
        if (!"admin".equals(userType) && !"medico".equals(userType)) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Obtém os dados do formulário
        String pacienteNome = request.getParameter("pacienteNome");
        String medicoNome = request.getParameter("medicoNome");
        String dataConsulta = request.getParameter("dataConsulta");
        String queixaPrincipal = request.getParameter("queixaPrincipal");
        String historiaDoenca = request.getParameter("historiaDoenca");
        String exameFisico = request.getParameter("exameFisico");
        String diagnostico = request.getParameter("diagnostico");
        String prescricao = request.getParameter("prescricao");
        String observacoes = request.getParameter("observacoes");
        String dataRegistro = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        try {
            String realPath = getServletContext().getRealPath("/");
            Connection conn = DatabaseConnection.getConnection(realPath);
            
            String sql = "INSERT INTO ficha_clinica (paciente_nome, medico_nome, data_consulta, queixa_principal, " +
                        "historia_doenca, exame_fisico, diagnostico, prescricao, observacoes, data_registro) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, pacienteNome);
                stmt.setString(2, medicoNome);
                stmt.setString(3, dataConsulta);
                stmt.setString(4, queixaPrincipal);
                stmt.setString(5, historiaDoenca);
                stmt.setString(6, exameFisico);
                stmt.setString(7, diagnostico);
                stmt.setString(8, prescricao);
                stmt.setString(9, observacoes);
                stmt.setString(10, dataRegistro);
                
                stmt.executeUpdate();
            }
            
            conn.close();
            response.sendRedirect("fichaClinica?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("fichaClinica?error=true");
        }
    }
} 
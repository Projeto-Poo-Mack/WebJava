package com.mack.clinica.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.mack.clinica.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/excluirFicha")
public class ExcluirFichaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("tipo");
        String userName = (String) session.getAttribute("nome");
        
        System.out.println("DEBUG: Iniciando exclusão de ficha clínica");
        System.out.println("DEBUG: Tipo de usuário: " + userType);
        System.out.println("DEBUG: Nome do usuário: " + userName);
        
        // Verifica se o usuário é médico
        if (!"medico".equals(userType)) {
            System.out.println("DEBUG: Usuário não autorizado");
            response.sendRedirect("index.jsp");
            return;
        }

        // Obtém o ID da ficha a ser excluída
        String fichaId = request.getParameter("fichaId");
        if (fichaId == null || fichaId.trim().isEmpty()) {
            System.out.println("DEBUG: ID da ficha não fornecido");
            response.sendRedirect(request.getContextPath() + "/minhasConsultas?error=true");
            return;
        }

        try {
            String realPath = request.getServletContext().getRealPath("/");
            Connection conn = DatabaseConnection.getConnection(realPath);
            
            // Primeiro verifica se a ficha pertence ao médico logado
            String checkSql = "SELECT id FROM ficha_clinica WHERE id = ? AND medico_nome = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, fichaId);
                checkStmt.setString(2, userName);
                
                if (!checkStmt.executeQuery().next()) {
                    System.out.println("DEBUG: Ficha não encontrada ou não pertence ao médico");
                    response.sendRedirect(request.getContextPath() + "/minhasConsultas?error=true");
                    return;
                }
            }
            
            // Se chegou aqui, a ficha existe e pertence ao médico
            String deleteSql = "DELETE FROM ficha_clinica WHERE id = ? AND medico_nome = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setString(1, fichaId);
                deleteStmt.setString(2, userName);
                
                int rowsAffected = deleteStmt.executeUpdate();
                System.out.println("DEBUG: Ficha excluída. Linhas afetadas: " + rowsAffected);
                
                if (rowsAffected > 0) {
                    response.sendRedirect(request.getContextPath() + "/minhasConsultas?success=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/minhasConsultas?error=true");
                }
            }
            
            conn.close();
            
        } catch (SQLException e) {
            System.err.println("Erro ao excluir ficha clínica: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/minhasConsultas?error=true");
        }
    }
} 
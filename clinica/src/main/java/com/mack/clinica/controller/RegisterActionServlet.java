package com.mack.clinica.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mack.clinica.model.Paciente;
import com.mack.clinica.model.PacienteDAO;
import com.mack.clinica.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerAction")
public class RegisterActionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");
        String cpf = request.getParameter("cpf");
        String celular = request.getParameter("celular");

        // Validar se as senhas coincidem
        if (!senha.equals(confirmarSenha)) {
            response.sendRedirect("register.jsp?erro=senha");
            return;
        }

        String realPathBase = request.getServletContext().getRealPath("/");

        // Verificar se o email já existe
        if (emailJaExiste(email, realPathBase)) {
            response.sendRedirect("register.jsp?erro=email");
            return;
        }

        // Verificar se o CPF já existe
        if (cpfJaExiste(cpf, realPathBase)) {
            response.sendRedirect("register.jsp?erro=cpf");
            return;
        }

        try {
            // Criar novo paciente
            Paciente paciente = new Paciente(nome, email, senha, cpf, celular);
            
            // Cadastrar no banco de dados
            PacienteDAO pacienteDAO = new PacienteDAO();
            pacienteDAO.cadastrarPaciente(paciente, realPathBase);

            // Redirecionar para a página de login com mensagem de sucesso
            response.sendRedirect("index.jsp?sucesso=cadastro");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?erro=geral");
        }
    }

    private boolean emailJaExiste(String email, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT COUNT(*) FROM usuarios WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean cpfJaExiste(String cpf, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT COUNT(*) FROM usuarios WHERE cpf = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, cpf);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
} 
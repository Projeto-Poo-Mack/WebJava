package com.mack.clinica.controller;

import java.io.IOException;
import com.mack.clinica.model.Paciente;
import com.mack.clinica.model.PacienteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/meu-cadastro")
public class MeuCadastroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer pacienteId = (Integer) session.getAttribute("id");
        
        if (pacienteId != null) {
            String realPathBase = getServletContext().getRealPath("/");
            PacienteDAO pacienteDAO = new PacienteDAO();
            Paciente paciente = pacienteDAO.buscarPacientePorId(pacienteId, realPathBase);
            
            if (paciente != null) {
                request.setAttribute("paciente", paciente);
                request.getRequestDispatcher("/meu_cadastro.jsp").forward(request, response);
            } else {
                response.sendRedirect("paciente_dashboard");
            }
        } else {
            response.sendRedirect("login");
        }
    }
} 
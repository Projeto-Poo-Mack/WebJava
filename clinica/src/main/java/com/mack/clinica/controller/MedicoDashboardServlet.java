package com.mack.clinica.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/medico_dashboard")
public class MedicoDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("tipo");
        
        // Verifica se o usuário é médico
        if (!"medico".equals(userType)) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Adiciona o tipo de usuário como atributo para o JSP
        request.setAttribute("userType", userType);
        
        // Adiciona o nome do médico se disponível
        String medicoNome = (String) session.getAttribute("nome");
        if (medicoNome != null) {
            request.setAttribute("medicoNome", medicoNome);
        }

        request.getRequestDispatcher("/medico_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redireciona para o doGet para manter a consistência
        doGet(request, response);
    }
} 
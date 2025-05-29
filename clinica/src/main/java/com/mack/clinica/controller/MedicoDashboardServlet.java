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

        request.getRequestDispatcher("/medico_dashboard.jsp").forward(request, response);
    }
} 
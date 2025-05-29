package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.model.AgendarConsultaDAO;
import com.mack.clinica.model.AgendarConsultaDAO.Consulta;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/minhaAgenda")
public class MinhaAgendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer pacienteId = (Integer) session.getAttribute("id");
        String userType = (String) session.getAttribute("tipo");
        
        // Verifica se o usuário é paciente
        if (!"paciente".equals(userType) || pacienteId == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String realPathBase = request.getServletContext().getRealPath("/");
        AgendarConsultaDAO dao = new AgendarConsultaDAO(realPathBase);
        
        // Busca as consultas do paciente específico
        List<Consulta> consultas = dao.listarConsultasPorPaciente(pacienteId);
        request.setAttribute("consultas", consultas);
        
        request.getRequestDispatcher("/minha_agenda.jsp").forward(request, response);
    }
} 
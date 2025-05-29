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

@WebServlet("/consultarAgenda")
public class ConsultarAgendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("tipo");
        
        // Verifica se o usuário é administrador
        if (!"admin".equals(userType)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String paciente = request.getParameter("paciente");
        String medico = request.getParameter("medico");
        String data = request.getParameter("data");

        String realPathBase = request.getServletContext().getRealPath("/");
        AgendarConsultaDAO dao = new AgendarConsultaDAO(realPathBase);
        
        List<Consulta> consultas = dao.listarConsultas(paciente, medico, data);
        request.setAttribute("consultas", consultas);
        
        // Mantém os filtros na página
        request.setAttribute("filtro_paciente", paciente);
        request.setAttribute("filtro_medico", medico);
        request.setAttribute("filtro_data", data);
        
        request.getRequestDispatcher("/consultar_agenda.jsp").forward(request, response);
    }
} 
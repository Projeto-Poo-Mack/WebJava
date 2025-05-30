package com.mack.clinica.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.mack.clinica.model.AgendarConsultaDAO;

@WebServlet("/cancelarConsulta")
public class CancelarConsultaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer pacienteId = (Integer) session.getAttribute("id");
        String userType = (String) session.getAttribute("tipo");
        
        // Verifica se o usuário é paciente
        if (!"paciente".equals(userType) || pacienteId == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int consultaId = Integer.parseInt(request.getParameter("consultaId"));
            String realPathBase = request.getServletContext().getRealPath("/");
            AgendarConsultaDAO dao = new AgendarConsultaDAO(realPathBase);
            
            // Cancela a consulta
            boolean sucesso = dao.cancelarConsulta(consultaId, pacienteId);
            
            if (sucesso) {
                response.sendRedirect("minhaAgenda?msg=cancelada");
            } else {
                response.sendRedirect("minhaAgenda?msg=erro");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("minhaAgenda?msg=erro");
        }
    }
} 
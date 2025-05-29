package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.model.Medico;
import com.mack.clinica.model.MedicoDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/medico/*")
public class MedicoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MedicoDAO medicoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String realPathBase = request.getServletContext().getRealPath("/");
        medicoDAO = new MedicoDAO();
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Listar médicos
            List<Medico> medicos = medicoDAO.listarMedicos(realPathBase);
            request.setAttribute("medicos", medicos);
            request.getRequestDispatcher("/listar_medicos.jsp").forward(request, response);
        } else if (pathInfo.equals("/novo")) {
            // Formulário de cadastro
            request.getRequestDispatcher("/cadastrar_medico.jsp").forward(request, response);
        } else if (pathInfo.equals("/editar")) {
            // Formulário de edição
            int id = Integer.parseInt(request.getParameter("id"));
            Medico medico = medicoDAO.buscarMedicoPorId(id, realPathBase);
            request.setAttribute("medico", medico);
            request.getRequestDispatcher("/editar_medico.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String realPathBase = request.getServletContext().getRealPath("/");
        medicoDAO = new MedicoDAO();
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Cadastrar novo médico
            Medico medico = new Medico(
                request.getParameter("nome"),
                request.getParameter("email"),
                request.getParameter("senha"),
                request.getParameter("cpf"),
                request.getParameter("celular")
            );
            medicoDAO.cadastrarMedico(medico, realPathBase);
            response.sendRedirect(request.getContextPath() + "/medico");
        } else if (pathInfo.equals("/atualizar")) {
            // Atualizar médico existente
            Medico medico = new Medico(
                request.getParameter("nome"),
                request.getParameter("email"),
                request.getParameter("senha"),
                request.getParameter("cpf"),
                request.getParameter("celular")
            );
            medico.setId(Integer.parseInt(request.getParameter("id")));
            medicoDAO.editarMedico(medico, realPathBase);
            response.sendRedirect(request.getContextPath() + "/medico");
        } else if (pathInfo.equals("/excluir")) {
            // Excluir médico
            int id = Integer.parseInt(request.getParameter("id"));
            medicoDAO.excluirMedico(id, realPathBase);
            response.sendRedirect(request.getContextPath() + "/medico");
        }
    }
} 
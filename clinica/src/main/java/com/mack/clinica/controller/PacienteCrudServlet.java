package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.model.Paciente;
import com.mack.clinica.model.PacienteDAO;
import com.mack.clinica.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/pacientes")
public class PacienteCrudServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String realPathBase = getServletContext().getRealPath("/");
        String action = request.getParameter("action");
        PacienteDAO pacienteDAO = new PacienteDAO();

        if ("editar".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Paciente paciente = pacienteDAO.buscarPacientePorId(id, realPathBase);
            request.setAttribute("paciente", paciente);
            request.getRequestDispatcher("/editar_paciente.jsp").forward(request, response);
        } else {
            List<Usuario> pacientes = pacienteDAO.listarPacientes(realPathBase);
            request.setAttribute("pacientes", pacientes);
            request.getRequestDispatcher("/listar_pacientes.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String realPathBase = getServletContext().getRealPath("/");
        PacienteDAO pacienteDAO = new PacienteDAO();

        if ("cadastrar".equals(action)) {
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            Paciente paciente = new Paciente(nome, email, senha);
            pacienteDAO.cadastrarPaciente(paciente, realPathBase);
            response.sendRedirect("pacientes");
        } else if ("editar".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            Paciente paciente = new Paciente(nome, email, senha);
            paciente.setId(id);
            pacienteDAO.editarPaciente(paciente, realPathBase);
            response.sendRedirect("pacientes");
        } else if ("excluir".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            pacienteDAO.excluirPaciente(id, realPathBase);
            response.sendRedirect("pacientes");
        } else {
            response.sendRedirect("pacientes");
        }
    }
}
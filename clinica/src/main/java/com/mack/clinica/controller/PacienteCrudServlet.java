package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mack.clinica.model.Paciente;
import com.mack.clinica.model.PacienteDAO;
import com.mack.clinica.model.Usuario;

@WebServlet("/pacientes")
public class PacienteCrudServlet extends HttpServlet {

    // Listagem de pacientes (GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String realPathBase = getServletContext().getRealPath("/");
        List<Usuario> pacientes = new PacienteDAO().listarPacientes(realPathBase);
        request.setAttribute("pacientes", pacientes);
        request.getRequestDispatcher("/listar_pacientes.jsp").forward(request, response);
    }

    // Cadastro, edição e exclusão de pacientes (POST)
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
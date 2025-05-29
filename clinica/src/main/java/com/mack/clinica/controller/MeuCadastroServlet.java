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
        String userType = (String) session.getAttribute("tipo");
        
        // Verifica se o usuário é paciente
        if (!"paciente".equals(userType) || pacienteId == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String realPathBase = getServletContext().getRealPath("/");
        PacienteDAO pacienteDAO = new PacienteDAO();
        Paciente paciente = pacienteDAO.buscarPacientePorId(pacienteId, realPathBase);
        
        if (paciente != null) {
            request.setAttribute("paciente", paciente);
            if ("editar".equals(action)) {
                request.getRequestDispatcher("/editar_meu_cadastro.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/meu_cadastro.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("paciente_dashboard");
        }
    }

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

        String action = request.getParameter("action");
        if ("editar".equals(action)) {
            String realPathBase = getServletContext().getRealPath("/");
            PacienteDAO pacienteDAO = new PacienteDAO();
            
            // Obtém os dados do formulário
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String cpf = request.getParameter("cpf").replaceAll("\\D", "");
            String celular = request.getParameter("celular").replaceAll("\\D", "");
            
            // Validação do nome, CPF e telefone
            String errorMessage = null;
            if (!nome.matches("[A-Za-zÀ-ÿ\\s]+")) {
                errorMessage = "O nome deve conter apenas letras e espaços";
            } else if (cpf.length() != 11) {
                errorMessage = "O CPF deve conter exatamente 11 dígitos numéricos";
            } else if (celular.length() != 11) {
                errorMessage = "O telefone deve conter exatamente 11 dígitos (DDD + número com 9)";
            }
            
            if (errorMessage != null) {
                // Se houver erro, recupera os dados do paciente e mostra o erro
                Paciente paciente = pacienteDAO.buscarPacientePorId(pacienteId, realPathBase);
                request.setAttribute("paciente", paciente);
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("/editar_meu_cadastro.jsp").forward(request, response);
                return;
            }
            
            // Se a senha estiver vazia, mantém a senha atual
            if (senha == null || senha.trim().isEmpty()) {
                Paciente pacienteAtual = pacienteDAO.buscarPacientePorId(pacienteId, realPathBase);
                senha = pacienteAtual.getSenha();
            }
            
            // Cria o objeto paciente com os dados atualizados
            Paciente paciente = new Paciente(nome, email, senha, cpf, celular);
            paciente.setId(pacienteId);
            
            // Atualiza o paciente no banco de dados
            pacienteDAO.editarPaciente(paciente, realPathBase);
            
            // Redireciona de volta para a página de visualização
            response.sendRedirect("meu-cadastro");
        } else {
            response.sendRedirect("meu-cadastro");
        }
    }
} 
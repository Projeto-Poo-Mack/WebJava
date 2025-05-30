package com.mack.clinica.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mack.clinica.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/minhasConsultas")
public class MinhasConsultasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("tipo");
        String userName = (String) session.getAttribute("nome");
        
        System.out.println("DEBUG: Iniciando busca de fichas clínicas");
        System.out.println("DEBUG: Tipo de usuário: " + userType);
        System.out.println("DEBUG: Nome do usuário: " + userName);
        
        if (userType == null || !userType.equals("medico")) {
            System.out.println("DEBUG: Usuário não autorizado");
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            String realPath = request.getServletContext().getRealPath("/");
            System.out.println("DEBUG: Real Path: " + realPath);
            Connection conn = DatabaseConnection.getConnection(realPath);
            System.out.println("DEBUG: Conexão com banco de dados estabelecida");
            
            // Criar a tabela se não existir
            String createTableSQL = "CREATE TABLE IF NOT EXISTS ficha_clinica (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "paciente_nome TEXT NOT NULL, " +
                "medico_nome TEXT NOT NULL, " +
                "data_consulta TEXT NOT NULL, " +
                "queixa_principal TEXT, " +
                "historia_doenca TEXT, " +
                "exame_fisico TEXT, " +
                "diagnostico TEXT, " +
                "prescricao TEXT, " +
                "observacoes TEXT, " +
                "data_registro TEXT NOT NULL)";
            
            try (PreparedStatement createStmt = conn.prepareStatement(createTableSQL)) {
                createStmt.execute();
                System.out.println("DEBUG: Tabela ficha_clinica verificada/criada com sucesso");
            }
            
            String sql = "SELECT * FROM ficha_clinica WHERE medico_nome = ? ORDER BY data_registro DESC";
            System.out.println("DEBUG: SQL Query: " + sql);
            System.out.println("DEBUG: Nome do médico para busca: " + userName);
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);
            
            ResultSet rs = stmt.executeQuery();
            List<FichaClinica> fichas = new ArrayList<>();
            
            System.out.println("DEBUG: Iniciando leitura das fichas");
            while (rs.next()) {
                FichaClinica ficha = new FichaClinica();
                ficha.setId(rs.getInt("id"));
                ficha.setPacienteNome(rs.getString("paciente_nome"));
                ficha.setMedicoNome(rs.getString("medico_nome"));
                ficha.setDataConsulta(rs.getString("data_consulta"));
                ficha.setQueixaPrincipal(rs.getString("queixa_principal"));
                ficha.setHistoriaDoenca(rs.getString("historia_doenca"));
                ficha.setExameFisico(rs.getString("exame_fisico"));
                ficha.setDiagnostico(rs.getString("diagnostico"));
                ficha.setPrescricao(rs.getString("prescricao"));
                ficha.setObservacoes(rs.getString("observacoes"));
                ficha.setDataRegistro(rs.getString("data_registro"));
                
                System.out.println("DEBUG: Ficha encontrada - ID: " + ficha.getId() + 
                                 ", Paciente: " + ficha.getPacienteNome() + 
                                 ", Médico: " + ficha.getMedicoNome() +
                                 ", Data Consulta: " + ficha.getDataConsulta() +
                                 ", Data Registro: " + ficha.getDataRegistro());
                
                fichas.add(ficha);
            }
            
            System.out.println("DEBUG: Total de fichas encontradas: " + fichas.size());
            
            rs.close();
            stmt.close();
            conn.close();
            System.out.println("DEBUG: Conexão com banco de dados fechada");
            
            request.setAttribute("fichas", fichas);
            
            String success = request.getParameter("success");
            if (success != null && success.equals("true")) {
                System.out.println("DEBUG: Parâmetro success=true encontrado");
                request.setAttribute("successMessage", "Ficha clínica salva com sucesso!");
            }
            
            request.getRequestDispatcher("minhas_consultas.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("Erro ao buscar fichas clínicas: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erro ao carregar fichas clínicas. Por favor, tente novamente.");
            request.getRequestDispatcher("minhas_consultas.jsp").forward(request, response);
        }
    }

    // Classe interna para representar uma ficha clínica
    public static class FichaClinica {
        private int id;
        private String pacienteNome;
        private String medicoNome;
        private String dataConsulta;
        private String queixaPrincipal;
        private String historiaDoenca;
        private String exameFisico;
        private String diagnostico;
        private String prescricao;
        private String observacoes;
        private String dataRegistro;

        // Getters e Setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        
        public String getPacienteNome() { return pacienteNome; }
        public void setPacienteNome(String pacienteNome) { this.pacienteNome = pacienteNome; }
        
        public String getMedicoNome() { return medicoNome; }
        public void setMedicoNome(String medicoNome) { this.medicoNome = medicoNome; }
        
        public String getDataConsulta() { return dataConsulta; }
        public void setDataConsulta(String dataConsulta) { this.dataConsulta = dataConsulta; }
        
        public String getQueixaPrincipal() { return queixaPrincipal; }
        public void setQueixaPrincipal(String queixaPrincipal) { this.queixaPrincipal = queixaPrincipal; }
        
        public String getHistoriaDoenca() { return historiaDoenca; }
        public void setHistoriaDoenca(String historiaDoenca) { this.historiaDoenca = historiaDoenca; }
        
        public String getExameFisico() { return exameFisico; }
        public void setExameFisico(String exameFisico) { this.exameFisico = exameFisico; }
        
        public String getDiagnostico() { return diagnostico; }
        public void setDiagnostico(String diagnostico) { this.diagnostico = diagnostico; }
        
        public String getPrescricao() { return prescricao; }
        public void setPrescricao(String prescricao) { this.prescricao = prescricao; }
        
        public String getObservacoes() { return observacoes; }
        public void setObservacoes(String observacoes) { this.observacoes = observacoes; }
        
        public String getDataRegistro() { return dataRegistro; }
        public void setDataRegistro(String dataRegistro) { this.dataRegistro = dataRegistro; }
    }
} 
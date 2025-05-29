package com.mack.clinica.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mack.clinica.util.DatabaseConnection;

public class AgendarConsultaDAO {

    private String realPathBase;

    public AgendarConsultaDAO(String realPathBase) {
        this.realPathBase = realPathBase;
    }

    public boolean agendarConsulta(int pacienteId, int profissionalId, String dataHora) {
        String sql = "INSERT INTO consultas (paciente_id, profissional_id, data_hora, status, observacoes) VALUES (?, ?, ?, 'agendada', '')";

        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, pacienteId);
            stmt.setInt(2, profissionalId);
            stmt.setString(3, dataHora);
            int linhasAfetadas = stmt.executeUpdate();
            System.out.println("Linhas afetadas: " + linhasAfetadas);
            return linhasAfetadas > 0;
        } catch (SQLException e) {
            System.out.println("entrou aqui");
            e.printStackTrace();
            return false;
        }
    }

    public List<Usuario> listarMedicos() {
        List<Usuario> medicos = new ArrayList<>();
        String sql = "SELECT id, nome FROM usuarios WHERE tipo = 'medico'";
    
        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
    
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                medicos.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar médicos: " + e.getMessage());
        }
    
        return medicos;
    }
    
    public static class Consulta {
        private int id;
        private String pacienteNome;
        private String medicoNome;
        private String dataHora;
        private String status;
        private String observacoes;

        // Getters and Setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getPacienteNome() { return pacienteNome; }
        public void setPacienteNome(String pacienteNome) { this.pacienteNome = pacienteNome; }
        public String getMedicoNome() { return medicoNome; }
        public void setMedicoNome(String medicoNome) { this.medicoNome = medicoNome; }
        public String getDataHora() { return dataHora; }
        public void setDataHora(String dataHora) { this.dataHora = dataHora; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public String getObservacoes() { return observacoes; }
        public void setObservacoes(String observacoes) { this.observacoes = observacoes; }
    }

    public List<Consulta> listarConsultas(String paciente, String medico, String data) {
        List<Consulta> consultas = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT c.id, p.nome as paciente_nome, m.nome as medico_nome, " +
            "c.data_hora, c.status, c.observacoes " +
            "FROM consultas c " +
            "JOIN usuarios p ON c.paciente_id = p.id " +
            "JOIN usuarios m ON c.profissional_id = m.id " +
            "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (paciente != null && !paciente.trim().isEmpty()) {
            sql.append(" AND LOWER(p.nome) LIKE LOWER(?)");
            params.add("%" + paciente + "%");
        }
        if (medico != null && !medico.trim().isEmpty()) {
            sql.append(" AND LOWER(m.nome) LIKE LOWER(?)");
            params.add("%" + medico + "%");
        }
        if (data != null && !data.trim().isEmpty()) {
            sql.append(" AND DATE(data_hora) = ?");
            params.add(data);
        }

        sql.append(" ORDER BY c.data_hora DESC");

        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Consulta consulta = new Consulta();
                consulta.setId(rs.getInt("id"));
                consulta.setPacienteNome(rs.getString("paciente_nome"));
                consulta.setMedicoNome(rs.getString("medico_nome"));
                consulta.setDataHora(rs.getString("data_hora"));
                consulta.setStatus(rs.getString("status"));
                consulta.setObservacoes(rs.getString("observacoes"));
                consultas.add(consulta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return consultas;
    }

    public List<Consulta> listarConsultasPorPaciente(int pacienteId) {
        List<Consulta> consultas = new ArrayList<>();
        String sql = 
            "SELECT c.id, p.nome as paciente_nome, m.nome as medico_nome, " +
            "c.data_hora, c.status, c.observacoes " +
            "FROM consultas c " +
            "JOIN usuarios p ON c.paciente_id = p.id " +
            "JOIN usuarios m ON c.profissional_id = m.id " +
            "WHERE c.paciente_id = ? " +
            "ORDER BY c.data_hora DESC";

        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, pacienteId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Consulta consulta = new Consulta();
                consulta.setId(rs.getInt("id"));
                consulta.setPacienteNome(rs.getString("paciente_nome"));
                consulta.setMedicoNome(rs.getString("medico_nome"));
                consulta.setDataHora(rs.getString("data_hora"));
                consulta.setStatus(rs.getString("status"));
                consulta.setObservacoes(rs.getString("observacoes"));
                consultas.add(consulta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return consultas;
    }
}

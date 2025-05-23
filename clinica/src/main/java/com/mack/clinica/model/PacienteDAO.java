package com.mack.clinica.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mack.clinica.util.DatabaseConnection;


public class PacienteDAO {

    public void cadastrarPaciente(Paciente paciente, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "INSERT INTO usuarios (nome, email, senha, tipo, cpf , celular) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, paciente.getNome());
            stmt.setString(2, paciente.getEmail());
            stmt.setString(3, paciente.getSenha());
            stmt.setString(4, paciente.getTipo());
            stmt.setString(5, paciente.getCpf());
            stmt.setString(6, paciente.getCelular());
            
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao cadastrar paciente no banco de dados.", e);
        }
    }

    public void editarPaciente(Paciente paciente, String realPathBase){
        try(Connection conn = DatabaseConnection.getConnection(realPathBase)){
            String sql = "UPDATE usuarios SET nome = ?, email = ?, senha = ? , WHERE id = ?, cpf = ?, celular = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);   
            stmt.setString(1, paciente.getNome());
            stmt.setString(2, paciente.getEmail());
            stmt.setString(3, paciente.getSenha());
            stmt.setInt(4, paciente.getId());
            stmt.setString(5, paciente.getCpf());
            stmt.setString(6, paciente.getCelular());


            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao editar paciente.", e);
        }
    }

    public void excluirPaciente(int id, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "DELETE FROM usuarios WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao excluir paciente.", e);
        }
    }

    public List<Usuario> listarPacientes(String realPathBase) {
        List<Usuario> pacientes = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT id, nome FROM usuarios WHERE tipo = 'paciente'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                pacientes.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao listar pacientes.", e);
        }
        return pacientes;
    }

    public Paciente buscarPacientePorId(int id, String realPathBase) {
        Paciente paciente = null;
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT * FROM usuarios WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                paciente = new Paciente(rs.getString("nome"), rs.getString("email"), rs.getString("senha"), rs.getString("cpf"), rs.getString("celular"));
                paciente.setId(rs.getInt("id"));
                paciente.setTipo(rs.getString("tipo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar paciente por ID.", e);
        }
        return paciente;
    }
        
    
}

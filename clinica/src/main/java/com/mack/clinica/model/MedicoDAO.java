package com.mack.clinica.model;
import com.mack.clinica.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicoDAO {
    
    public void cadastrarMedico(Medico medico, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "INSERT INTO usuarios (nome, email, senha, tipo, cpf, celular) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, medico.getNome());
            stmt.setString(2, medico.getEmail());
            stmt.setString(3, medico.getSenha());
            stmt.setString(4, medico.getTipo());
            stmt.setString(5, medico.getCpf());
            stmt.setString(6, medico.getCelular());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao cadastrar médico no banco de dados.", e);
        }
    }

    public void editarMedico(Medico medico, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "UPDATE usuarios SET nome = ?, email = ?, senha = ?, cpf = ?, celular = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, medico.getNome());
            stmt.setString(2, medico.getEmail());
            stmt.setString(3, medico.getSenha());
            stmt.setString(4, medico.getCpf());
            stmt.setString(5, medico.getCelular());
            stmt.setInt(6, medico.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao editar médico.", e);
        }
    }

    public void excluirMedico(int id, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "DELETE FROM usuarios WHERE id = ? AND tipo = 'medico'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao excluir médico.", e);
        }
    }

    public List<Medico> listarMedicos(String realPathBase) {
        List<Medico> medicos = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT * FROM usuarios WHERE tipo = 'medico'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Medico medico = new Medico(
                    rs.getString("nome"),
                    rs.getString("email"),
                    rs.getString("senha"),
                    rs.getString("cpf"),
                    rs.getString("celular")
                );
                medico.setId(rs.getInt("id"));
                medicos.add(medico);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao listar médicos.", e);
        }
        return medicos;
    }

    public Medico buscarMedicoPorId(int id, String realPathBase) {
        Medico medico = null;
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT * FROM usuarios WHERE id = ? AND tipo = 'medico'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                medico = new Medico(
                    rs.getString("nome"),
                    rs.getString("email"),
                    rs.getString("senha"),
                    rs.getString("cpf"),
                    rs.getString("celular")
                );
                medico.setId(rs.getInt("id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar médico por ID.", e);
        }
        return medico;
    }
}

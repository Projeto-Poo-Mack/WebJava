package com.mack.clinica.model;

public class Medico extends Usuario {
    private String email;
    private String senha;

    public Medico(String nome, String email, String senha, String cpf, String celular) {
        super.setCpf(cpf);
        super.setCelular(celular);
        super.setNome(nome);
        this.email = email;
        this.senha = senha;
        super.setTipo("medico");
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
    
}

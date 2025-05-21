package com.mack.clinica.model;

public class Paciente extends Usuario {
    private String email;
    private String senha;

    public Paciente(String nome, String email, String senha) {
        super.setNome(nome);
        this.email = email;
        this.senha = senha;
        super.setTipo("paciente");
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

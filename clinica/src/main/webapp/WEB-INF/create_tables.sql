-- Tabela de Fichas Clínicas
CREATE TABLE IF NOT EXISTS ficha_clinica (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    paciente_nome TEXT NOT NULL,
    medico_nome TEXT NOT NULL,
    data_consulta TEXT NOT NULL,
    queixa_principal TEXT,
    historia_doenca TEXT,
    exame_fisico TEXT,
    diagnostico TEXT,
    prescricao TEXT,
    observacoes TEXT,
    data_registro TEXT NOT NULL
); 
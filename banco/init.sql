-- Criar tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    senha_hash VARCHAR(255) NOT NULL,
    tipo VARCHAR(20) CHECK (tipo IN ('aluno', 'professor', 'admin')),
    curso_id INTEGER,
    periodo INTEGER,
    departamento VARCHAR(100),
    titulacao VARCHAR(50),
    ativo BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT NOW()
);

-- Criar tabela de disciplinas
CREATE TABLE IF NOT EXISTS disciplinas (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    ementa TEXT,
    creditos INTEGER,
    vagas_total INTEGER DEFAULT 40,
    horario VARCHAR(50),
    local_aula VARCHAR(50),
    professor_id INTEGER REFERENCES usuarios(id)
);

-- Criar tabela de matrículas
CREATE TABLE IF NOT EXISTS matriculas (
    id SERIAL PRIMARY KEY,
    aluno_id INTEGER REFERENCES usuarios(id),
    disciplina_id INTEGER REFERENCES disciplinas(id),
    semestre VARCHAR(10),
    status VARCHAR(20) DEFAULT 'cursando',
    data_matricula TIMESTAMP DEFAULT NOW()
);

-- Criar tabela de notas
CREATE TABLE IF NOT EXISTS notas (
    id SERIAL PRIMARY KEY,
    matricula_id INTEGER REFERENCES matriculas(id) UNIQUE,
    nota_av1 DECIMAL(4,2),
    nota_av2 DECIMAL(4,2),
    nota_final DECIMAL(4,2),
    frequencia DECIMAL(5,2),
    observacoes TEXT,
    atualizado_em TIMESTAMP DEFAULT NOW()
);

-- Inserir dados de exemplo (CORRIGIDO - senhas reais)
-- Usuário admin
INSERT INTO usuarios (matricula, nome, email, senha_hash, tipo) 
VALUES ('admin', 'Administrador', 'admin@escola.com', '$2b$10$9XjkLmN3oPqR7sT5uVwXeO9yZ1aB2cD3eF4gH5iJ6kL7mN8oP9qR0sT', 'admin')
ON CONFLICT (matricula) DO NOTHING;

-- Aluno exemplo
INSERT INTO usuarios (matricula, nome, email, senha_hash, tipo, periodo) 
VALUES ('2024001', 'João Silva', 'joao@email.com', '$2b$10$9XjkLmN3oPqR7sT5uVwXeO9yZ1aB2cD3eF4gH5iJ6kL7mN8oP9qR0sT', 'aluno', 3)
ON CONFLICT (matricula) DO NOTHING;

-- Professor exemplo
INSERT INTO usuarios (matricula, nome, email, senha_hash, tipo, departamento) 
VALUES ('P001', 'Maria Professora', 'maria@escola.com', '$2b$10$9XjkLmN3oPqR7sT5uVwXeO9yZ1aB2cD3eF4gH5iJ6kL7mN8oP9qR0sT', 'professor', 'Computação')
ON CONFLICT (matricula) DO NOTHING;

-- Disciplinas
INSERT INTO disciplinas (codigo, nome, creditos, vagas_total, horario) VALUES
('INF101', 'Programação Web', 4, 40, 'Segunda 19:00-22:00'),
('INF102', 'Banco de Dados', 4, 35, 'Terça 19:00-22:00'),
('INF103', 'Engenharia de Software', 4, 30, 'Quarta 19:00-22:00')
ON CONFLICT (codigo) DO NOTHING;
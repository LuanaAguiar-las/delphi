-- ============================================================================
-- SCRIPT DDL - BANCO DE DADOS POSTGRESQL
-- Projeto: Sistema de Controle de Orçamento Financeiro Pessoal
-- Arquivo: schema.sql
-- ============================================================================

-- 1. Tabela: Formas de Pagamento
CREATE TABLE IF NOT EXISTS forma_pagamento (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- 2. Tabela: Categorias
CREATE TABLE IF NOT EXISTS categoria (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- 3. Tabela: Orçamento (Master)
CREATE TABLE IF NOT EXISTS orcamento (
    id SERIAL PRIMARY KEY,
    mes_ano VARCHAR(7) NOT NULL CONSTRAINT uk_orcamento_mes_ano UNIQUE,
    salario_liquido NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    renda_extra NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    meta_investimento NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    observacao TEXT
);

-- 4. Tabela: Despesas do Orçamento (Detail)
CREATE TABLE IF NOT EXISTS orcamento_despesa (
    id SERIAL PRIMARY KEY,
    id_orcamento INT NOT NULL,
    id_categoria INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    valor NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    pago BOOLEAN NOT NULL DEFAULT FALSE,
    
    CONSTRAINT fk_despesa_orcamento 
        FOREIGN KEY (id_orcamento) 
        REFERENCES orcamento(id) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_despesa_categoria 
        FOREIGN KEY (id_categoria) 
        REFERENCES categoria(id),
        
    CONSTRAINT fk_despesa_forma_pagamento 
        FOREIGN KEY (id_forma_pagamento) 
        REFERENCES forma_pagamento(id)
);

-- Índices de otimização para junções e buscas
CREATE INDEX IF NOT EXISTS idx_orcamento_despesa_orcamento ON orcamento_despesa(id_orcamento);
CREATE INDEX IF NOT EXISTS idx_orcamento_despesa_categoria ON orcamento_despesa(id_categoria);
CREATE INDEX IF NOT EXISTS idx_orcamento_despesa_forma_pagto ON orcamento_despesa(id_forma_pagamento);
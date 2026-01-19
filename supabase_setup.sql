-- Execute este SQL no Supabase SQL Editor para criar as tabelas

-- Tabela de Propostas
CREATE TABLE IF NOT EXISTS propostas (
    id BIGINT PRIMARY KEY,
    data TEXT,
    loja TEXT,
    cliente TEXT,
    telefone TEXT,
    site TEXT,
    itens JSONB,
    banners INTEGER DEFAULT 0,
    bonus INTEGER DEFAULT 0,
    subtotal INTEGER DEFAULT 0,
    total INTEGER DEFAULT 0,
    cupom TEXT,
    desconto_cupom INTEGER DEFAULT 0,
    pix BOOLEAN DEFAULT FALSE,
    desconto_pix INTEGER DEFAULT 0,
    parcelas INTEGER DEFAULT 1,
    prazo INTEGER DEFAULT 7,
    status TEXT DEFAULT 'Pendente',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela de Cupons
CREATE TABLE IF NOT EXISTS cupons (
    id SERIAL PRIMARY KEY,
    codigo TEXT UNIQUE NOT NULL,
    desconto INTEGER NOT NULL,
    indicador TEXT,
    usos INTEGER DEFAULT 0,
    valor_gerado INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela de Leads
CREATE TABLE IF NOT EXISTS leads (
    id BIGINT PRIMARY KEY,
    nome TEXT NOT NULL,
    loja TEXT,
    telefone TEXT NOT NULL,
    cupom TEXT,
    status TEXT DEFAULT 'novo',
    data TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela de Previews das Aplicações
CREATE TABLE IF NOT EXISTS previews (
    id SERIAL PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL,
    codigo TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar RLS (Row Level Security) - Opcional para seguranca
ALTER TABLE propostas ENABLE ROW LEVEL SECURITY;
ALTER TABLE cupons ENABLE ROW LEVEL SECURITY;
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
ALTER TABLE previews ENABLE ROW LEVEL SECURITY;

-- Politicas para permitir acesso anonimo (necessario para funcionar sem login)
CREATE POLICY "Permitir tudo propostas" ON propostas FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Permitir tudo cupons" ON cupons FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Permitir tudo leads" ON leads FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Permitir tudo previews" ON previews FOR ALL USING (true) WITH CHECK (true);

-- Inserir cupom VIZZU10 padrao
INSERT INTO cupons (codigo, desconto, indicador) 
VALUES ('VIZZU10', 10, 'Site VIZZU') 
ON CONFLICT (codigo) DO NOTHING;

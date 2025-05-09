# 📋 Sistema de Gerenciamento de Vendas (e-Commerce)

## 🛍️ **Visão Geral do Projeto**
Este é um sistema de banco de dados completo para gerenciamento de vendas online (e-commerce), desenvolvido para PostgreSQL e implementado no PGAdmin. O projeto simula um ambiente real de comércio eletrônico com:

- Cadastro de clientes
- Controle de produtos e estoque
- Processamento de pedidos
- Formas de pagamento
- Relatórios analíticos

## 🎯 **Objetivo Principal**
Fornecer uma base sólida para estudos de banco de dados relacionais, incluindo:
- Modelagem de dados avançada
- Consultas SQL complexas
- Operações CRUD completas
- Boas práticas de normalização

## 🏗️ **Estrutura do Banco de Dados**

### 📂 **Tabelas Principais**
1. **`clientes`** - Cadastro de clientes (dados pessoais e status)
2. **`produtos`** - Catálogo de produtos com categorias
3. **`estoque`** - Controle de inventário e localização
4. **`formas_pagamento`** - Opções de pagamento disponíveis
5. **`pedidos`** - Registro de vendas
6. **`itens_pedido`** - Detalhamento dos produtos vendidos

## 💡 **Cenário Implementado**
O banco simula uma loja virtual de **produtos variados** (eletrônicos, roupas, alimentos) com:

- 10+ clientes cadastrados
- 12 produtos em estoque
- 10 pedidos processados
- 5 formas de pagamento diferentes
- Relacionamentos completos entre entidades

## 🛠️ **Tecnologias Utilizadas**
- **PostgreSQL 15+** (SGBD relacional)
- **PGAdmin 4** (Interface de gerenciamento)
- **SQL** (Linguagem de consulta)

## 📊 **Recursos Implementados**
✅ Modelagem ER com chaves primárias/estrangeiras  
✅ Constraints de validação (CHECK, NOT NULL, UNIQUE)  
✅ 50+ registros de exemplo distribuídos nas tabelas  
✅ 10 consultas SQL analíticas prontas  
✅ Operações de atualização e exclusão condicional  
✅ Exemplos de ALTER TABLE para evolução do esquema  

## 🚀 **Como Utilizar**
1. Execute o script SQL completo no PGAdmin
2. Explore as tabelas através das consultas exemplo
3. Modifique/adicione dados conforme necessidade
4. Use como base para seus próprios desenvolvimentos

## 📝 **Notas de Desenvolvimento**
- Projeto 100% funcional e testado
- Dados fictícios mas realistas
- Compatível com PostgreSQL 12+
- Ideal para estudos acadêmicos ou protótipos

*"Um sistema completo para aprender na prática como bancos de dados relacionais funcionam em ambientes de e-commerce reais."*

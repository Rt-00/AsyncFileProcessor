# Async File Processing

Sistema completo de **processamento assíncrono de arquivos**, com backend em **Ruby on Rails** e frontend em **Svelte**.

Este projeto demonstra uma arquitetura moderna baseada em filas de background, upload de arquivos e comunicação entre serviços, utilizando boas práticas de desenvolvimento tanto no frontend quanto no backend.

---

## 📂 Estrutura do projeto

```
async_file_processing_api # API RESTful em Ruby on Rails
async_file_processing_frontend # Interface Web em Svelte
```

---

## ⚙️ Backend — Rails API

### 📌 Requisitos

- Ruby 3.2+
- Rails 7+
- SQLite (ou PostgreSQL, opcional)
- Redis (para processamento assíncrono com Sidekiq, se usado)

### 🚀 Instalação

```bash
cd async_file_processing_api
bundle install
rails db:setup
docker-compose up -d # Setup do redis
rails s # Roda o servidor rails
bundle exec sidekiq # Roda o sidekiq configurado para os jobs assíncronos
```

A API estará disponível em `http://localhost:3000`

---

## 💻 Frontend — Svelte

### 📌 Requisitos

- Node.js 20+
- npm ou pnpm

🚀 Instalação

```bash
cd async_file_processing_frontend
npm install
npm run dev
```

A aplicação estará disponível em `http://localhost:5173`

---

## 🔄 Fluxo de funcionamento

1. O usuário faz upload de um arquivo pelo frontend.
2. O arquivo é enviado para a API Rails.
3. A API agenda o processamento do arquivo de forma assíncrona (via Sidekiq).
4. O resultado é armazenado no banco e disponibilizado para consulta.
5. O frontend exibe o progresso e os resultados em tempo real.

---

## 🧱 Tecnologias utilizadas

### Backend

- Ruby on Rails 7
- Sidekiq
- Redis
- SQLite

### Frontend

- SvelteKit
- TailwindCSS
- Typescript
- Fetch API

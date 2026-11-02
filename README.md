# Agência RISE — Gestão Operacional

Este repositório tem duas partes:

| Parte | Onde roda | O que faz |
|---|---|---|
| `index.html`, `404.html`, `assets/` | **GitHub Pages** (estático) | Página de entrada da equipe, com o status do sistema e o botão de acesso. |
| `src/` (Next.js + PostgreSQL) | **Servidor Node.js** | O sistema completo: login, clientes, OS, produção, agenda, ideias, financeiro e equipe. |

O GitHub Pages hospeda somente arquivos estáticos. Ele não executa Node.js, banco de dados nem as rotas `/api`, então o sistema completo precisa de uma hospedagem com servidor (Vercel, Render, Railway ou uma VPS) e de um PostgreSQL.

## Publicar a página estática no GitHub Pages

1. Envie o repositório para o GitHub (branch `main`).
2. Em **Settings → Pages → Build and deployment**, escolha **Source: GitHub Actions**.
3. O workflow `.github/workflows/pages.yml` publica apenas `index.html`, `404.html`, `.nojekyll` e `assets/`. O código do servidor não é exposto.

> Alternativa: **Deploy from a branch → `main` / `(root)`** também funciona, porque o `index.html` está na raiz e todos os caminhos são relativos. Nesse modo, porém, todos os arquivos do repositório ficam acessíveis publicamente.

## Apontar para o sistema

Edite `assets/config.js` e defina `APP_URL` com o endereço onde o sistema completo está hospedado (com `https://` e sem barra no final). A página consulta `APP_URL + /api/health` para mostrar se o sistema está online.

## Rodar o sistema completo

```bash
cp .env.example .env      # preencha DATABASE_URL
npm install
npx drizzle-kit push      # cria as tabelas
npm run build && npm run start
```

Nunca envie o arquivo `.env` ao GitHub; ele já está no `.gitignore`.

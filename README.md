# Agência RISE — Gestão Operacional

Sistema interno da Agência RISE: clientes, contratos e pacotes, ordens de serviço, produção de conteúdo (Kanban), agenda de gravações, banco de ideias, financeiro, equipe e permissões.

**Stack:** Next.js 16 (App Router) · React 19 · TypeScript · Tailwind CSS 4 · PostgreSQL · Drizzle ORM · Zod

> ⚠️ Este projeto **não funciona no GitHub Pages**. Ele precisa de servidor (rotas de API, login, sessões) e de um banco PostgreSQL. Use a **Vercel** (ou outra hospedagem Node.js).

---

## Estrutura (tudo na raiz do repositório)

```
.
├── drizzle/                  # Migrações SQL geradas a partir do schema
│   ├── 0000_inicial.sql
│   └── meta/
├── public/                   # Arquivos estáticos
├── scripts/
│   └── migrate.mjs           # Aplica migrações e cria o admin inicial (roda no build da Vercel)
├── src/
│   ├── app/                  # Páginas e rotas de API (App Router)
│   │   ├── api/              # actions, auth, data, health, records
│   │   ├── clientes/[id]/    # Página individual do cliente
│   │   ├── globals.css
│   │   ├── icon.svg
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/           # Interface (dashboard, clientes, OS, Kanban, financeiro…)
│   ├── db/                   # Conexão (index.ts) e schema (schema.ts)
│   └── lib/                  # Autenticação, regras de negócio, validação
├── .env.example              # Modelo das variáveis de ambiente
├── .gitignore
├── drizzle.config.ts
├── eslint.config.mjs
├── next.config.ts
├── package.json
├── package-lock.json
├── postcss.config.mjs
├── tsconfig.json
└── vercel.json               # Build da Vercel: migrações + next build
```

---

## Publicar na Vercel (passo a passo)

### 1. Criar o banco PostgreSQL
Crie um banco gratuito no **[Neon](https://neon.tech)** (recomendado), Supabase ou na aba *Storage* da Vercel.
Copie a *connection string* (começa com `postgresql://`).

### 2. Enviar para o GitHub
Crie um repositório e envie **o conteúdo desta pasta na raiz** (o `package.json` deve aparecer logo na primeira tela do repositório):

```bash
git init
git add .
git commit -m "Sistema Agência RISE"
git branch -M main
git remote add origin https://github.com/SEU-USUARIO/agencia-rise.git
git push -u origin main
```

> O `.gitignore` já impede o envio de `node_modules`, `.next` e `.env` (senhas).

### 3. Importar na Vercel
1. Acesse [vercel.com/new](https://vercel.com/new) e importe o repositório.
2. **Root Directory:** deixe em branco (raiz).
3. Em **Environment Variables**, cadastre:

| Variável         | Valor                                   |
|------------------|-----------------------------------------|
| `DATABASE_URL`   | connection string do banco              |
| `ADMIN_EMAIL`    | `agencia@gmail.com`                     |
| `ADMIN_PASSWORD` | sua senha (mínimo 8 dígitos)            |
| `ADMIN_NAME`     | `Cleverton` (opcional)                  |

4. Clique em **Deploy**.

No build, o `scripts/migrate.mjs` cria todas as tabelas e o administrador. Depois é só acessar o endereço `https://seu-projeto.vercel.app` e entrar com o e-mail e a senha cadastrados.

> **Importante:** defina `ADMIN_EMAIL` e `ADMIN_PASSWORD` **antes** do primeiro deploy. Sem eles, a tela de configuração inicial fica aberta e o primeiro visitante poderia criar o administrador.

### 4. Verificar
- `https://seu-projeto.vercel.app/api/health` deve responder `{"ok":true}`.
- Os demais membros (Victoria, João Victor, Vitória) são criados sem senha. Ative cada um em **Equipe → editar → senha**.

---

## Rodar localmente

Requisitos: Node.js 20+ e PostgreSQL.

```bash
npm install
cp .env.example .env        # ajuste DATABASE_URL e o admin
node scripts/migrate.mjs     # cria tabelas e administrador
npm run dev                  # http://localhost:3000
```

Outros comandos:

```bash
npm run build                # build de produção
npm run start                # servidor de produção
npm run typecheck            # verificação de tipos
npx drizzle-kit generate     # gera nova migração após alterar src/db/schema.ts
```

---

## Alterações no banco
1. Edite `src/db/schema.ts`.
2. Rode `npx drizzle-kit generate` para criar o novo arquivo em `drizzle/`.
3. Faça commit e push — a Vercel aplica a migração automaticamente no próximo deploy.

## Perfis de acesso
- **Administrador:** acesso completo.
- **Social Media:** clientes (leitura), ordens de serviço, produção, agenda e ideias.
- **Financeiro:** clientes (leitura), lançamentos, mensalidades e pagamentos.

## Segurança
- Senhas com hash `scrypt` + sal individual; sessões armazenadas no banco com cookie `httpOnly`.
- Bloqueio temporário após 5 tentativas de login incorretas.
- Validação de todas as entradas com Zod e verificação de origem nas rotas de escrita.

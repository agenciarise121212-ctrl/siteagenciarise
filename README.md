# Agência Rise — Portfólio

**Para publicar sem tela branca:** consulte [PUBLICAR-NO-GITHUB.md](PUBLICAR-NO-GITHUB.md).
Use o ZIP **site pronto** para envio manual ou o ZIP **projeto completo** com GitHub Actions.
Não publique o `index.html` de desenvolvimento sozinho.

Site institucional/portfólio da **Agência Rise** construído com **React + Vite + Tailwind CSS**.
Mostra os trabalhos em vídeo (Vimeo), os serviços — vídeos e artes, projetos de eventos em 3D
interativo e marketing para comércios —, os planos mensais, um briefing de novos clientes e um
botão de contato direto pelo WhatsApp.

## Stack

- **React 19** + **Vite 7** + **TypeScript**
- **Tailwind CSS 4** (estilos em `src/index.css`)
- **Framer Motion** (animações) e **lucide-react** (ícones)
- **@vimeo/player** (prévias em loop e player completo na própria página)
- **vite-plugin-singlefile** (o build gera um único `dist/index.html` com JS/CSS embutidos)

## Rodando localmente

```bash
npm install        # instala as dependências
npm run dev        # sobe o site em http://localhost:5173
```

## Gerando o build de produção

```bash
npm run build      # gera a pasta dist/
npm run preview    # pré-visualiza o build em http://localhost:4173
npm run package:site  # gera os ZIPs do site pronto e do projeto completo
```

> O build ajusta os caminhos automaticamente e gera `dist/index.html`,
> `dist/briefing/index.html`, `.nojekyll` e as imagens. Os ZIPs ficam em `public/downloads/`.

### Pedido rápido (janela na página inicial)

Ao clicar em **Briefing** (menu, menu do celular ou rodapé), um formulário abre **na própria página
inicial**, como uma janela. Nada é navegado nem recarregado — por isso não há como dar "not found".

O cliente escolhe o que precisa produzir, preenche os dados do negócio e clica em
"ENVIAR PELO WHATSAPP". A conversa da agência abre com a mensagem já pronta e organizada,
para conferir e mandar. **Nada fica salvo**: sem cadastro, sem servidor e sem banco de dados.

**Agendamento:** o cliente escolhe entre **cliente fixo** (dia da semana da gravação + data de início)
ou **cliente avulso** (data desejada, formato — vídeo, foto, 3D ou vídeo e foto —, o que será produzido
e para que será usado). Só os campos do tipo escolhido aparecem.

Arquivos: `src/OrderForm.tsx` (janela) e os estilos ao final de `src/briefing.css`.
O número do WhatsApp fica em `WHATSAPP_DIGITS`, no topo de `src/OrderForm.tsx`.

### Página completa de briefing (`/briefing/`)

A rota `/briefing/` é a área onde o cliente cadastra o que precisa produzir e os dados do negócio,
em cinco etapas. No GitHub Pages ela é gerada em `dist/briefing/index.html`, para abrir diretamente
sem depender de um fallback de SPA.

**Nada fica salvo no site**: não há cadastro, login, servidor nem banco de dados. Ao clicar em
"ENVIAR BRIEFING PARA A RISE", a conversa do WhatsApp da agência abre com a mensagem já pronta e
organizada (negrito e quebras de linha); o cliente confere e confirma o envio dentro do WhatsApp.

---

## Publicando no GitHub Pages

Existem duas formas. Não misture os arquivos ou a configuração das duas opções.
O guia completo está em [PUBLICAR-NO-GITHUB.md](PUBLICAR-NO-GITHUB.md).

### Opção A — GitHub Actions (recomendada)

O ZIP `agencia-rise-projeto-completo.zip` inclui o workflow `.github/workflows/deploy.yml`
que **compila o React e publica somente `dist/`**. Envie também as pastas `src`, `public`,
`scripts` e `.github`; elas são indispensáveis e não podem ficar só no seu computador.

1. Crie um repositório vazio no GitHub (ex.: `agencia-rise`).
2. Suba o código do projeto:

   ```bash
   git init
   git add -A
   git commit -m "Site da Agência Rise"
   git branch -M main
   git remote add origin https://github.com/SEU-USUARIO/agencia-rise.git
   git push -u origin main
   ```

3. No GitHub, vá em **Settings → Pages**.
4. Em **Build and deployment → Source**, escolha **GitHub Actions**.
5. Pronto! Após alguns segundos o site aparece em:
   `https://SEU-USUARIO.github.io/agencia-rise/`

> Cada push no `main` republica o site automaticamente.

### Opção B — Envio Manual do Site Pronto

1. Extraia `agencia-rise-site-pronto.zip` no computador.
2. Envie **todo o conteúdo extraído** para a raiz da branch `main`, incluindo as pastas
   `images` e `briefing`. O `index.html` compilado deve substituir o antigo.
3. Em **Settings → Pages → Source**, escolha **Deploy from a branch**, branch **main**, pasta **/(root)**.
4. Aguarde **pages build and deployment** terminar com sucesso em **Actions**.

Não envie somente o ZIP: o GitHub não o descompacta para publicar.
Não use o workflow de compilação quando o repositório contiver somente o site pronto.

> **Por que o ajuste de caminhos?** O GitHub Pages publica em uma subpasta
> (`usuario.github.io/repo/`). Os caminhos das imagens precisam ser relativos
> (`./images/...`). O `npm run build` e o workflow já fazem isso por você.

### Verificações Antes de Publicar

```bash
npm run check
npm test
npm run build
```

Os testes recusam HTML de desenvolvimento, conferem os caminhos locais e verificam se
todos os passos do workflow têm comandos válidos. A aparência e as funcionalidades do
portfólio não foram modificadas para esta correção de publicação.

---

## Como editar o conteúdo

Quase todo o conteúdo fica em **`src/App.tsx`**, no topo do arquivo:

| O que | Onde |
| --- | --- |
| **Vídeos (Vimeo)** | Array `videos` — `id`, `title`, `category`, `duration`, `orientation` e `posterFallback` |
| **Número de WhatsApp** | Constantes `whatsappNumber` (exibição) e `whatsappLink` (link `wa.me/...`) |
| **Serviços** | Array `services` (vídeos e artes, eventos 3D, marketing) |
| **Perfis de Instagram (artes)** | Array `igProfiles` — `handle`, `name`, `initials`, `highlights` (destaques), `cover` (capa de vídeo opcional) |
| **Clientes do letreiro** | Array `clients` |
| **Programas do estúdio** | Array `studioTools` (nome, sigla e função de cada programa) |
| **Clipes da timeline** | Arrays `studioTracks` (vídeo/gráficos) e `studioPages` — ilustração animada, sem imagens de clientes |
| **Planos mensais** | Array `plans` (Pacote Básico e Marketing Completo) |
| **Perguntas frequentes** | Array `faqs` |
| **Frases/destaques** | Direto no JSX do componente `App` (hero, seções, rodapé) |

Imagens ficam em **`public/images/`** e as capas dos vídeos em **`public/images/videos/`**.

### Trocar os vídeos

Cole o `id` do vídeo do Vimeo (o número do link `vimeo.com/123456789` → `123456789`) e uma imagem
de capa em `public/images/videos/<id>.jpg`. As prévias rodam sem som em loop e, ao clicar, o vídeo
completo abre na própria página.

### Trocar o número de WhatsApp

Atualize as duas constantes no topo de `src/App.tsx`:

```ts
const whatsappNumber = "+55 82 8758-9626";
const whatsappLink = (message: string) => `https://wa.me/558287589626?text=${encodeURIComponent(message)}`;
```

(o número no `wa.me/` é só os dígitos, sem `+`, espaços ou traços).

## Fotos e números reais dos perfis do Instagram

As artes dos perfis na seção "Instagram organizado" já aceitam a foto real e os números de cada cliente:

- **Foto de perfil:** salve a imagem em `public/images/instagram/<perfil>.jpg`
  (ex.: `public/images/instagram/otica_florees.jpg`). Quadrada, ~400 px. Se o arquivo não existir, aparecem as iniciais.
- **Publicações, seguidores e seguindo:** preencha `stats` no perfil em `igProfiles` (`src/App.tsx`), por exemplo
  `stats: { posts: "247", followers: "5.147", following: "169" }`. Sem `stats`, aparecem barras neutras.
- Os números são uma foto do momento: atualize de tempos em tempos.

## Estrutura do projeto

```
├─ index.html                 # HTML base (título, meta, favicon, fontes)
├─ public/
│  ├─ favicon.svg
│  └─ images/                 # imagens do site + capas dos vídeos
├─ scripts/
│  └─ fix-paths.mjs           # ajusta caminhos p/ GitHub Pages (usado no deploy)
├─ src/
│  ├─ App.tsx                 # todo o conteúdo e layout da página
│  ├─ index.css               # estilos (Tailwind + CSS próprio)
│  ├─ main.tsx
│  └─ utils/cn.ts
├─ .github/workflows/deploy.yml  # publicação automática no Pages
└─ deploy.sh                  # build local + ajuste de caminhos
```

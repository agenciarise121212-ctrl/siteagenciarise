# Publicar o Site da Agência Rise

## O Que Causava a Tela Branca

O `index.html` da raiz do **projeto** é um arquivo de desenvolvimento. Ele chama
`/src/main.tsx`, que o GitHub Pages não compila. Enviar só os arquivos soltos da
raiz, sem as pastas, não publica a aplicação.

O arquivo `index.html` do **site pronto**, dentro de `dist/`, já contém o JavaScript
e o CSS compilados. É esse arquivo que precisa ser publicado.

## Opção Mais Simples: Site Pronto

1. Baixe e extraia `agencia-rise-site-pronto.zip` no computador. Não envie o ZIP fechado.
2. Abra o repositório `siteagenciarise` no GitHub.
3. Use **Add file > Upload files** e envie **todo o conteúdo extraído**, incluindo
   `index.html`, `favicon.svg`, `.nojekyll` e as pastas `images` e `briefing`.
4. O arquivo `index.html` deve ficar na **raiz do repositório**, não dentro de
   outra pasta como `dist`, `agencia-rise` ou `site-pronto`.
5. Confirme o envio com **Commit changes**.
6. Em **Settings > Pages > Build and deployment**, escolha **Deploy from a branch**.
7. Selecione **main** e **/(root)**; clique em **Save**.
8. Em **Actions**, aguarde **pages build and deployment** terminar com sucesso.
9. Abra `https://agenciarise121212-ctrl.github.io/siteagenciarise/`.

Estrutura correta do repositório para essa opção:

```text
index.html        <- o HTML compilado do ZIP, substitui o antigo
favicon.svg
.nojekyll
images/
briefing/
  index.html
```

Não misture essa opção com o workflow de compilação. Se existir um arquivo
`.github/workflows/deploy.yml` de um projeto antigo nesse mesmo repositório,
remova esse workflow ao publicar somente o site pronto.

## Opção Para Manter o Código Editável: Projeto Completo

1. Extraia `agencia-rise-projeto-completo.zip`.
2. Envie o projeto inteiro, incluindo **src**, **public**, **scripts** e **.github**,
   além dos arquivos da raiz. Não envie `node_modules` nem `dist`.
3. Em **Settings > Pages > Source**, escolha **GitHub Actions**.
4. Em **Actions > Publicar site da Rise**, use **Run workflow** se necessário.
5. Espere os dois trabalhos, **build** e **deploy**, ficarem verdes.

O workflow instala as dependências, verifica o código e publica **apenas `dist/`**.
Não é necessário adicionar tokens ou senhas para esse workflow.

## Para Gerar Novos Arquivos

Com Node.js 20.19 ou superior instalado:

```bash
npm ci
npm run check
npm test
npm run build
npm run package:site
```

Os ZIPs ficam em `public/downloads/`. O comando `npm run build` já ajusta os
caminhos para `/siteagenciarise/`, cria `.nojekyll`, prepara `/briefing/` e verifica
se você está publicando HTML compilado.

## Se Ainda Não Abrir

Confira primeiro se o processo de publicação ficou verde em **Actions**.
Se o código-fonte da página publicada ainda tiver `/src/main.tsx`, o HTML errado
continua no ar. Nesse caso, substitua-o pelo `index.html` do ZIP **site pronto**,
ou use a opção **projeto completo + GitHub Actions**.

O formulário continua abrindo na própria página, sem gravar respostas. O envio
abre o WhatsApp com a mensagem preenchida; o cliente confirma o envio no aplicativo.
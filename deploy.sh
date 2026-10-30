#!/usr/bin/env bash
#
# Gera o site pronto para publicar no GitHub Pages.
#
# Uso (a partir da raiz do projeto):
#   ./deploy.sh
#
# Ao final, a pasta "dist/" contém o site com caminhos relativos,
# pronto para ser enviado a uma branch "gh-pages" ou publicado
# automaticamente pelo workflow do GitHub Actions.
#
set -euo pipefail

echo "==> 1/4 Instalando dependencias..."
npm ci

echo "==> 2/4 Conferindo o projeto..."
npm run check
npm test

echo "==> 3/4 Gerando o site compilado..."
rm -rf dist
npm run build

echo "==> 4/4 Gerando os arquivos ZIP..."
npm run package:site

echo
echo "Pronto! A pasta 'dist/' está pronta para publicar."
echo
echo "  Site pronto: public/downloads/agencia-rise-site-pronto.zip"
echo "  Projeto completo: public/downloads/agencia-rise-projeto-completo.zip"
echo
echo "  Instrucoes: PUBLICAR-NO-GITHUB.md"

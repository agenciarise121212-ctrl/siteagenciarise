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

echo "==> 1/4 Instalando dependências..."
npm ci

echo "==> 2/4 Limpando build anterior..."
rm -rf dist

echo "==> 3/4 Gerando build de produção..."
npm run build

echo "==> 4/5 Caminhos relativos + página /briefing/..."
node scripts/fix-paths.mjs dist

echo
echo "Pronto! A pasta 'dist/' está pronta para publicar."
echo
echo "  Opção A (recomendada): publique via GitHub Actions"
echo "    -> basta dar push no código; o workflow publica sozinho."
echo "    -> ver .github/workflows/deploy.yml"
echo
echo "  Opção B: publicar manualmente na branch 'gh-pages'"
echo "    -> ./deploy.sh"
echo "    -> cd dist && git checkout --orphan gh-pages && git add -A && git commit -m 'Site' && git push -f origin gh-pages"
echo "    -> (veja o README.md para o passo a passo completo)"

import { defineConfig, globalIgnores } from "eslint/config";
import nextCoreWebVitals from "eslint-config-next/core-web-vitals";

export default defineConfig([
  // Keep the starter on the flat config export that actually runs under the pinned ESLint/Next toolchain.
  ...nextCoreWebVitals,
  // assets/ é a página estática do GitHub Pages (JS de navegador puro, fora do app Next.js).
  globalIgnores([".next/**", "out/**", "build/**", "_site/**", "assets/**", "next-env.d.ts"]),
]);

import { defineConfig } from "vite";
import { compiler, stripGXTDebug } from "@lifeart/gxt/compiler";
import babel from "vite-plugin-babel";

export default defineConfig(({ mode }) => ({
  plugins: [
    mode === "production"
      ? (babel({
          babelConfig: {
            babelrc: false,
            configFile: false,
            plugins: [stripGXTDebug],
          },
        }) as any)
      : null,
    compiler(mode, {
      flags: {
        TRY_CATCH_ERROR_HANDLING: false,
        SUPPORT_SHADOW_DOM: false,
      },
    }),
  ],
  base: "",
  rollupOptions: {
    input: {
      main: "index.html",
      tests: "tests.html",
    },
  },
  build: {
    modulePreload: false,
    target: "esnext",
    minify: "terser",
    terserOptions: {
      module: true,
      compress: {
        hoist_funs: true,
        drop_console: true,
        inline: 2,
        passes: 5,
        unsafe: true,
        unsafe_symbols: true,
      },
      mangle: {
        module: true,
        toplevel: true,
        properties: false,
      },
    },
  },
}));

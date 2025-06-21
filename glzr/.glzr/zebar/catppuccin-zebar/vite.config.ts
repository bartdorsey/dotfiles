import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vite.dev/config/
export default defineConfig({
    base: "/dist/",
    plugins: [react()],
    css: {
        preprocessorOptions: {
            scss: {
                includePath: ["node_modules"],
            },
        },
    },
});

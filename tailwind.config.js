/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        brand: {
          50: "#f3f7fb",
          100: "#e3edf6",
          200: "#c4d8e9",
          300: "#97b9d4",
          400: "#6394ba",
          500: "#43759f",
          600: "#345d83",
          700: "#2c4c6a",
          800: "#274059",
          900: "#23374b",
        },
      },
      fontFamily: {
        sans: [
          "ui-sans-serif",
          "system-ui",
          "-apple-system",
          "Segoe UI",
          "Roboto",
          "Helvetica Neue",
          "Arial",
          "sans-serif",
        ],
      },
    },
  },
  plugins: [],
};

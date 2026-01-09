/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
      colors: {
        primary: '#ff8c00',  // Orange (DarkOrange)
        background: '#ffffff',  // White
        surface: '#d3d3d3',  // LightGray
        'text-main': '#000000',  // Black
      },
    },
  },
  plugins: [],
}


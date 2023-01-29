module.exports = {
  theme: {
    extend: {},
  },
  variants: {
    extend: {}
  },
  content: [
    "./src/index.html",
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
    plugins: [
      require("daisyui")
    ],
}

const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/assets/**/*.svg',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,css,rb}'
  ],
  theme: {
    extend: {
      transitionProperty: {
        'height': 'height',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      dropShadow: {
        glow: [
          "0 0px 20px rgba(255,255, 255, 0.35)",
          "0 0px 65px rgba(255, 255,255, 0.2)"
        ]
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),

    function ({ addUtilities }) {
      const newUtilities = {
        '.text-yellow-glow': {
          'text-shadow': '0 0 4px #FFCC00, 0 0 4px #FFCC00',
        },
      }
      addUtilities(newUtilities, ['responsive', 'hover'])
    },
  ]
}

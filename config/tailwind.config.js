// tailwind.config.js
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      backgroundImage: {
        'orange-pattern': "url('/assets/images/orange.jpg')",
      },
    },
  },
  plugins: [],
}

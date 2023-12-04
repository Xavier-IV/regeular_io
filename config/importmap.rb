# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@tailwindcss/forms', to: 'https://ga.jspm.io/npm:@tailwindcss/forms@0.5.6/src/index.js'
pin 'mini-svg-data-uri', to: 'https://ga.jspm.io/npm:mini-svg-data-uri@1.4.4/index.js'
pin 'picocolors', to: 'https://ga.jspm.io/npm:picocolors@1.0.0/picocolors.browser.js'
pin 'tailwindcss/colors', to: 'https://ga.jspm.io/npm:tailwindcss@3.3.3/colors.js'
pin 'tailwindcss/defaultTheme', to: 'https://ga.jspm.io/npm:tailwindcss@3.3.3/defaultTheme.js'
pin 'tailwindcss/plugin', to: 'https://ga.jspm.io/npm:tailwindcss@3.3.3/plugin.js'
pin 'copy-to-clipboard', to: 'https://ga.jspm.io/npm:copy-to-clipboard@3.3.3/index.js'
pin 'toggle-selection', to: 'https://ga.jspm.io/npm:toggle-selection@1.0.6/index.js'
pin '@sjmc11/tourguidejs', to: 'https://ga.jspm.io/npm:@sjmc11/tourguidejs@0.0.10/dist/tour.js'
pin 'local-time', to: 'https://ga.jspm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js'
pin 'tippy.js', to: 'https://ga.jspm.io/npm:tippy.js@6.3.7/dist/tippy.esm.js'
pin '@popperjs/core', to: 'https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js'

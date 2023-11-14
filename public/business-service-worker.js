// service-worker.js

const CACHE_NAME = 'business-pwa-cache-v1';
const urlsToCache = [
    '/',
    '/assets/application.css',
    '/assets/application.js',
    // Add other static assets you want to cache here
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                return cache.addAll(urlsToCache);
            })
    );
});

self.addEventListener('fetch', (event) => {
    event.respondWith(
        caches.match(event.request)
            .then((response) => {
                return response || fetch(event.request);
            })
    );
});

// service-worker.js

const CACHE_NAME = 'business-pwa-cache-v2';
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

self.addEventListener('push', function(event) {
    const data = event.data?.json();
    console.log(data)
    self.registration.showNotification(data.title, {
        body: data.body,
        // other notification options
    });
});
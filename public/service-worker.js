// service-worker.js

const CACHE_NAME = 'pwa-cache-v2';
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

self.addEventListener('push', async function(event) {
    const data = event.data?.json();
    await self.registration.showNotification(data.title, {
        vibrate: [200, 100, 200, 100, 200, 100, 200],
        tag: data.tag,
        body: data.body,
        actions: [
            { action: 'see_promo', title: 'Learn More' }
        ]
        // other notification options
    });
});
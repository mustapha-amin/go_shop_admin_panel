'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "47449507f383a8749a6186500ff598e6",
"assets/AssetManifest.json": "e3a0e7785e8766ee72f2f8af3389131a",
"assets/assets/images/categories/assesories.png": "92fb69bbcdc983d6eb193bb34eb24dc8",
"assets/assets/images/categories/clothes.png": "58c58961515e4e116a9b8b5cf3eba69b",
"assets/assets/images/categories/computers.png": "9830286ba858f6237b0500d8e582c37d",
"assets/assets/images/categories/electronics.png": "fdd311dc33468ef2545e34acc66a4d35",
"assets/assets/images/categories/gaming.png": "5ef8710bf0eb758f66a1e855aac0472a",
"assets/assets/images/categories/shoes.png": "153d121393f6b6bb9d3f1189c207c22c",
"assets/assets/images/categories/smartphones.png": "11c182da6b81d321af7bc58225ace79e",
"assets/assets/images/categories/watches.png": "19dd5e8d08db3aa73369ea5ea3886d2a",
"assets/assets/images/general/add_to_cart.png": "f064a6c843c6224fa4b65904ad0d9055",
"assets/assets/images/general/admin.jpg": "2af8811be1f50b455e7bcb733a4df307",
"assets/assets/images/general/basket.png": "176b0bcd357c1ba64e4f8902a429a978",
"assets/assets/images/general/cart.png": "3d05fb326236ddd54845f84d536e106c",
"assets/assets/images/general/carton.png": "f27395d239ec496f109ba3cd600369c8",
"assets/assets/images/general/cart_dark.png": "dc4f16d3f63cf542ad7e58ae0cdd2431",
"assets/assets/images/general/cart_light.png": "86c3e8b4220f975b53cd1174a092f272",
"assets/assets/images/general/google.png": "544d4fbd203b23b74127a7a05d347c9b",
"assets/assets/images/general/shopping1.jpg": "700e255f47bec6f9637e687573ee5d23",
"assets/assets/images/general/shopping2.jpg": "fbe688cdc67d81bf5669837cfa395827",
"assets/assets/images/general/shopping3.png": "8a110e55c33bd4c864e476f1b9f2d002",
"assets/assets/images/general/shopping4.jpg": "d7f6e103a8b64908d1b549dd7f643723",
"assets/assets/images/general/warning.png": "69889318d174207194a3f26f4d96cac6",
"assets/assets/images/general/wishlist_dark.png": "828c3cee1fcfe391565fbf9e3a11419e",
"assets/assets/images/general/wishlist_light.png": "d6e090c0ed568fd179c92867464a34aa",
"assets/assets/images/offers/airpod.png": "34e9cff3cdb42107803e2bf14d8b79a3",
"assets/assets/images/offers/laptop.png": "73df74250aa8f41105c4978daf83ad01",
"assets/assets/images/offers/shirt.png": "78d095b513ca12fd4b88e281488db8fc",
"assets/assets/images/offers/shoe.png": "ad18ca0990f86b5815fae6d59de72e3f",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "241829b125cdf35fad5094c65ddb34a8",
"assets/NOTICES": "87827a18f112d697d5fc404d5f62d139",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "3206de79fedf9e90f5d9f2cb62744fb6",
"/": "3206de79fedf9e90f5d9f2cb62744fb6",
"main.dart.js": "85e44e1ca894fceb0d96da75bf6004b4",
"manifest.json": "74e3e342f81e88c198f6608cc8a3a743",
"version.json": "8072f3ddae9e72235bdea099114434c3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

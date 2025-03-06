'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f9c8489dc247953b8fce74647ff99d67",
"version.json": "cd9ae4a741d15cc74d9055db061b348f",
"index.html": "8ffd1a621f507c0b1c5497be54114668",
"/": "8ffd1a621f507c0b1c5497be54114668",
"main.dart.js": "42ca4e532f21a0067de1d13df73d2419",
"node_modules/base-x/LICENSE.md": "275affc076a81e10b2d5b1854d4b40ec",
"node_modules/base-x/README.md": "7e8625575c50b5c84d2f247302fcb8e7",
"node_modules/base-x/package.json": "1a6fca83f093be3428b0f8aa4be03899",
"node_modules/base-x/src/esm/index.js": "4e51b80cf24769540c805337fcf4d4ab",
"node_modules/base-x/src/cjs/index.cjs": "d70bd6366dcbd6f4302380686bccd6a5",
"node_modules/base-x/src/cjs/index.d.ts": "6fbfbff4690c6358565705f21a9709dd",
"node_modules/bs58/LICENSE": "69e5f0a98dadb2b8001d8a29af050df6",
"node_modules/bs58/README.md": "7bd8d5e12ab2bde572b166bb15bf5d7c",
"node_modules/bs58/package.json": "bb85074887e81ccbbe761fbdd54c9142",
"node_modules/bs58/src/esm/index.js": "cf63c5af58a3f8eca1516faa266d1d9c",
"node_modules/bs58/src/cjs/index.cjs": "53b5a598b9eae1f6dde83bc337aec092",
"node_modules/bs58/src/cjs/index.d.ts": "dbcc020d8add5bfb908dc7a11cd7e33b",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "7db0226dc2abcfa21f78bfe1c543f2dd",
"package-lock.json": "cf52d108f116ee61013b9a08e397ae0a",
"package.json": "ba28be4841b3c26c25f8db0017ef03ca",
"icons/Icon-192.png": "163cb25d571d9beb2bd151a344445325",
"icons/Icon-maskable-192.png": "163cb25d571d9beb2bd151a344445325",
"icons/Icon-maskable-512.png": "163cb25d571d9beb2bd151a344445325",
"icons/Icon-512.png": "163cb25d571d9beb2bd151a344445325",
"manifest.json": "aee66f35afae078b6d7364ae7172b358",
"wallet_module.js": "1d9346c9ac776d12d3be7dd4b701c2cf",
"assets/AssetManifest.json": "9a5f71ae6238ca0b39b6c7312d990c5c",
"assets/NOTICES": "3494b8aec1d6317cdb2a8cc8d2be9d14",
"assets/FontManifest.json": "0757a755d8e3ca4982ffabc0a0e1338c",
"assets/AssetManifest.bin.json": "af4ae1331181ad1703fbde10c46d3c37",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "cc80c44560b7327c0634bbac02904c31",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "9a38dadba601a4fd271c4df20e4038f1",
"assets/fonts/MaterialIcons-Regular.otf": "aa8a4e0636584b4212d770aa351638ef",
"assets/assets/rive/rotor.riv": "a7b7f8befa6257cb34b234e2bd3e0a56",
"assets/assets/rive/live.riv": "1c17a4eb96e3a2a94292132e865b3b78",
"assets/assets/logos/usdt_logo.png": "0c1936ebc95ab80b970132dd3506bb29",
"assets/assets/logos/usdc_logo.png": "ac6def895eeddd1f30b4af9697785a5e",
"assets/assets/logos/phantom_logo.svg": "fdb1cc37e9d1fbd1f99cb554483728c7",
"assets/assets/logos/spice_logo.svg": "7d27f0461429092e22b194c085ec48d2",
"assets/assets/logos/sol_logo.png": "a3528dd0ad2edbdd3119fd55259daca7",
"assets/assets/icons/x_white_icon.svg": "600fdd836deeb18f5d902605696b9372",
"assets/assets/icons/dune_black_icon.svg": "ca081eefe69352ad137e7d8a9e10aa6f",
"assets/assets/icons/telegram_black_icon.svg": "e8358d0895957bf3eb5c3c764215d042",
"assets/assets/icons/github_white_icon.svg": "df68f9e4c5cad5586835b90c67b39f19",
"assets/assets/icons/docs_black_icon.svg": "a1679473bde166d6a0aa200a9b618f60",
"assets/assets/icons/github_hover_icon.svg": "a2ee960c3ecac8dee603a0d18f15eb2c",
"assets/assets/icons/rotor.svg": "031e8b62f0bef547edc15b289ca7bfbd",
"assets/assets/icons/x_hover_icon.svg": "076bd15285816313253de5ef59d1fb45",
"assets/assets/icons/x_black_icon.svg": "4109ae25a4dfdd8b133dc7f8feb97a41",
"assets/assets/icons/dune_white_icon.svg": "e5ca1701868eab851bfbc49e57052afb",
"assets/assets/icons/telegram_white_icon.svg": "af1397faba40ee78ad2db1579fcf2d64",
"assets/assets/icons/github_black_icon.svg": "b13f687e91f876218e8072ff8d8a619c",
"assets/assets/icons/docs_white_icon.svg": "6f491ff2672ea036d9e9b8ef75879d30",
"assets/assets/icons/docs_hover_icon.svg": "386e81217f79e3c3c4c9792b319e3241",
"assets/assets/icons/telegram_hover_icon.svg": "6185cf4cb35b820b5b9fabf3d6ca243d",
"assets/assets/icons/dune_hover_icon.svg": "35707a4b924579ba920182625bb40b7d",
"assets/assets/fonts/CPMono-Regular.otf": "cec2670064f93d247c30d60ffd375e30",
"assets/assets/fonts/CPMono-Bold.otf": "b889267a6e1b8a5b1e65e3aa5b73dbca",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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

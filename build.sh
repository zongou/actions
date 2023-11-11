#!/bin/sh
set -eu

## Go to source dir
cd "$(dirname $0)/vscode"

## Install dependencies ====
# # Electron and browsers are not required
# # for code-server build.
export ELECTRON_SKIP_BINARY_DOWNLOAD=1
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

# # Install deps

# # Remove telemetry libs
# sed -i -e 's#"@vscode/telemetry-extractor": "^1.9.8",##g' package.json

# # Remove ripgrep, which, for SOME reason,
# # cannot be installed in this case due to proxies.
# sed -i -e 's#"@vscode/ripgrep": "^1.14.2",##g' package.json

# # Set proper node version in yarnrc
# node build/npm/setupBuildYarnrc
# cp ./build/.yarnrc ./.yarnrc
# cp ./build/.yarnrc ./remote/.yarnrc

# # Install node_modules
# yarn $@

# # Install ripgrep.
# # Now it works, no one knows exactly why.
# yarn add @vscode/ripgrep

yarn

## Patch ====
# Prevent electron build
# cat build/lib/preLaunch.js |
#     grep -v "await getElectron();" |
#     grep -v "await getBuiltInExtensions();" \
#         >build/lib/preLaunch.server.js

# Prevent builtin extensions from downloading
# cat product.json
# node -e 'console.log(JSON.stringify({...require("./product.json"), builtInExtensions: []}))' >product.json.tmp
# mv product.json.tmp product.json

## Build ====
yarn gulp vscode-reh-web-linux-x64-min

## Postinstall ====
# mkdir /code-server-oss && cd /code-server-oss

# mv /vscode/.build ./
# mv /vscode/extensions ./
# mv /vscode/node_modules ./
# mv /vscode/out-vscode-reh-web-min ./out
# mv /vscode/product.json ./
# mv /vscode/package.json ./

# [19:17:24] Tasks for /workspaces/build-workflow/repos/vscode/gulpfile.js
# [19:17:24] ├── extract-editor-src
# [19:17:24] ├── editor-distro
# [19:17:24] ├── editor-esm-bundle
# [19:17:24] ├── monacodts
# [19:17:24] ├── transpile-extension:authentication-proxy
# [19:17:24] ├── compile-extension:authentication-proxy
# [19:17:24] ├── watch-extension:authentication-proxy
# [19:17:24] ├── transpile-extension:configuration-editing-build
# [19:17:24] ├── compile-extension:configuration-editing-build
# [19:17:24] ├── watch-extension:configuration-editing-build
# [19:17:24] ├── transpile-extension:configuration-editing
# [19:17:24] ├── compile-extension:configuration-editing
# [19:17:24] ├── watch-extension:configuration-editing
# [19:17:24] ├── transpile-extension:css-language-features-client
# [19:17:24] ├── compile-extension:css-language-features-client
# [19:17:24] ├── watch-extension:css-language-features-client
# [19:17:24] ├── transpile-extension:css-language-features-server
# [19:17:24] ├── compile-extension:css-language-features-server
# [19:17:24] ├── watch-extension:css-language-features-server
# [19:17:24] ├── transpile-extension:debug-auto-launch
# [19:17:24] ├── compile-extension:debug-auto-launch
# [19:17:24] ├── watch-extension:debug-auto-launch
# [19:17:24] ├── transpile-extension:debug-server-ready
# [19:17:24] ├── compile-extension:debug-server-ready
# [19:17:24] ├── watch-extension:debug-server-ready
# [19:17:24] ├── transpile-extension:emmet
# [19:17:24] ├── compile-extension:emmet
# [19:17:24] ├── watch-extension:emmet
# [19:17:24] ├── transpile-extension:extension-editing
# [19:17:24] ├── compile-extension:extension-editing
# [19:17:24] ├── watch-extension:extension-editing
# [19:17:24] ├── transpile-extension:git
# [19:17:24] ├── compile-extension:git
# [19:17:24] ├── watch-extension:git
# [19:17:24] ├── transpile-extension:git-base
# [19:17:24] ├── compile-extension:git-base
# [19:17:24] ├── watch-extension:git-base
# [19:17:24] ├── transpile-extension:github-authentication
# [19:17:24] ├── compile-extension:github-authentication
# [19:17:24] ├── watch-extension:github-authentication
# [19:17:24] ├── transpile-extension:github
# [19:17:24] ├── compile-extension:github
# [19:17:24] ├── watch-extension:github
# [19:17:24] ├── transpile-extension:grunt
# [19:17:24] ├── compile-extension:grunt
# [19:17:24] ├── watch-extension:grunt
# [19:17:24] ├── transpile-extension:gulp
# [19:17:24] ├── compile-extension:gulp
# [19:17:24] ├── watch-extension:gulp
# [19:17:24] ├── transpile-extension:html-language-features-client
# [19:17:24] ├── compile-extension:html-language-features-client
# [19:17:24] ├── watch-extension:html-language-features-client
# [19:17:24] ├── transpile-extension:html-language-features-server
# [19:17:24] ├── compile-extension:html-language-features-server
# [19:17:24] ├── watch-extension:html-language-features-server
# [19:17:24] ├── transpile-extension:ipynb
# [19:17:24] ├── compile-extension:ipynb
# [19:17:24] ├── watch-extension:ipynb
# [19:17:24] ├── transpile-extension:jake
# [19:17:24] ├── compile-extension:jake
# [19:17:24] ├── watch-extension:jake
# [19:17:24] ├── transpile-extension:json-language-features-client
# [19:17:24] ├── compile-extension:json-language-features-client
# [19:17:24] ├── watch-extension:json-language-features-client
# [19:17:24] ├── transpile-extension:json-language-features-server
# [19:17:24] ├── compile-extension:json-language-features-server
# [19:17:24] ├── watch-extension:json-language-features-server
# [19:17:24] ├── transpile-extension:markdown-language-features-preview-src
# [19:17:24] ├── compile-extension:markdown-language-features-preview-src
# [19:17:24] ├── watch-extension:markdown-language-features-preview-src
# [19:17:24] ├── transpile-extension:markdown-language-features-server
# [19:17:24] ├── compile-extension:markdown-language-features-server
# [19:17:24] ├── watch-extension:markdown-language-features-server
# [19:17:24] ├── transpile-extension:markdown-language-features
# [19:17:24] ├── compile-extension:markdown-language-features
# [19:17:24] ├── watch-extension:markdown-language-features
# [19:17:24] ├── transpile-extension:markdown-math
# [19:17:24] ├── compile-extension:markdown-math
# [19:17:24] ├── watch-extension:markdown-math
# [19:17:24] ├── transpile-extension:media-preview
# [19:17:24] ├── compile-extension:media-preview
# [19:17:24] ├── watch-extension:media-preview
# [19:17:24] ├── transpile-extension:merge-conflict
# [19:17:24] ├── compile-extension:merge-conflict
# [19:17:24] ├── watch-extension:merge-conflict
# [19:17:24] ├── transpile-extension:microsoft-authentication
# [19:17:24] ├── compile-extension:microsoft-authentication
# [19:17:24] ├── watch-extension:microsoft-authentication
# [19:17:24] ├── transpile-extension:notebook-renderers
# [19:17:24] ├── compile-extension:notebook-renderers
# [19:17:24] ├── watch-extension:notebook-renderers
# [19:17:24] ├── transpile-extension:npm
# [19:17:24] ├── compile-extension:npm
# [19:17:24] ├── watch-extension:npm
# [19:17:24] ├── transpile-extension:php-language-features
# [19:17:24] ├── compile-extension:php-language-features
# [19:17:24] ├── watch-extension:php-language-features
# [19:17:24] ├── transpile-extension:search-result
# [19:17:24] ├── compile-extension:search-result
# [19:17:24] ├── watch-extension:search-result
# [19:17:24] ├── transpile-extension:references-view
# [19:17:24] ├── compile-extension:references-view
# [19:17:24] ├── watch-extension:references-view
# [19:17:24] ├── transpile-extension:simple-browser
# [19:17:24] ├── compile-extension:simple-browser
# [19:17:24] ├── watch-extension:simple-browser
# [19:17:24] ├── transpile-extension:tunnel-forwarding
# [19:17:24] ├── compile-extension:tunnel-forwarding
# [19:17:24] ├── watch-extension:tunnel-forwarding
# [19:17:24] ├── transpile-extension:typescript-language-features-test-workspace
# [19:17:24] ├── compile-extension:typescript-language-features-test-workspace
# [19:17:24] ├── watch-extension:typescript-language-features-test-workspace
# [19:17:24] ├── transpile-extension:typescript-language-features-web
# [19:17:24] ├── compile-extension:typescript-language-features-web
# [19:17:24] ├── watch-extension:typescript-language-features-web
# [19:17:24] ├── transpile-extension:typescript-language-features
# [19:17:24] ├── compile-extension:typescript-language-features
# [19:17:24] ├── watch-extension:typescript-language-features
# [19:17:24] ├── transpile-extension:vscode-api-tests
# [19:17:24] ├── compile-extension:vscode-api-tests
# [19:17:24] ├── watch-extension:vscode-api-tests
# [19:17:24] ├── transpile-extension:vscode-colorize-tests
# [19:17:24] ├── compile-extension:vscode-colorize-tests
# [19:17:24] ├── watch-extension:vscode-colorize-tests
# [19:17:24] ├── transpile-extension:vscode-test-resolver
# [19:17:24] ├── compile-extension:vscode-test-resolver
# [19:17:24] ├── watch-extension:vscode-test-resolver
# [19:17:24] ├── transpile-extensions
# [19:17:24] ├── compile-extensions
# [19:17:24] ├── watch-extensions
# [19:17:24] ├── compile-extensions-build-legacy
# [19:17:24] ├── compile-extension-media
# [19:17:24] ├── watch-extension-media
# [19:17:24] ├── compile-extension-media-build
# [19:17:24] ├── compile-extensions-build
# [19:17:24] ├── extensions-ci
# [19:17:24] ├── compile-extensions-build-pr
# [19:17:24] ├── extensions-ci-pr
# [19:17:24] ├── compile-web
# [19:17:24] ├── watch-web
# [19:17:24] ├── compile-api-proposal-names
# [19:17:24] ├── watch-api-proposal-names
# [19:17:24] ├── transpile-client-swc
# [19:17:24] ├── transpile-client
# [19:17:24] ├── compile-client
# [19:17:24] ├── watch-client
# [19:17:24] ├── compile
# [19:17:24] ├── watch
# [19:17:24] ├── default
# [19:17:24] ├── compile-cli
# [19:17:24] ├── watch-cli
# [19:17:24] ├── compile-build
# [19:17:24] ├── compile-build-pr
# [19:17:24] ├── check-package-json
# [19:17:24] ├── hygiene
# [19:17:24] ├── minify-vscode-web
# [19:17:24] ├── compile-web-extensions-build
# [19:17:24] ├── vscode-web-ci
# [19:17:24] ├── vscode-web
# [19:17:24] ├── vscode-web-min-ci
# [19:17:24] ├── vscode-web-min
# [19:17:24] ├── node-win32-x64
# [19:17:24] ├── node-darwin-x64
# [19:17:24] ├── node-darwin-arm64
# [19:17:24] ├── node-linux-x64
# [19:17:24] ├── node-linux-armhf
# [19:17:24] ├── node-linux-arm64
# [19:17:24] ├── node-alpine-arm64
# [19:17:24] ├── node-linux-alpine
# [19:17:24] ├── node
# [19:17:24] ├── minify-vscode-reh
# [19:17:24] ├── vscode-reh-win32-x64-ci
# [19:17:24] ├── vscode-reh-win32-x64
# [19:17:24] ├── vscode-reh-win32-x64-min-ci
# [19:17:24] ├── vscode-reh-win32-x64-min
# [19:17:24] ├── vscode-reh-darwin-x64-ci
# [19:17:24] ├── vscode-reh-darwin-x64
# [19:17:24] ├── vscode-reh-darwin-x64-min-ci
# [19:17:24] ├── vscode-reh-darwin-x64-min
# [19:17:24] ├── vscode-reh-darwin-arm64-ci
# [19:17:24] ├── vscode-reh-darwin-arm64
# [19:17:24] ├── vscode-reh-darwin-arm64-min-ci
# [19:17:24] ├── vscode-reh-darwin-arm64-min
# [19:17:24] ├── vscode-reh-linux-x64-ci
# [19:17:24] ├── vscode-reh-linux-x64
# [19:17:24] ├── vscode-reh-linux-x64-min-ci
# [19:17:24] ├── vscode-reh-linux-x64-min
# [19:17:24] ├── vscode-reh-linux-armhf-ci
# [19:17:24] ├── vscode-reh-linux-armhf
# [19:17:24] ├── vscode-reh-linux-armhf-min-ci
# [19:17:24] ├── vscode-reh-linux-armhf-min
# [19:17:24] ├── vscode-reh-linux-arm64-ci
# [19:17:24] ├── vscode-reh-linux-arm64
# [19:17:24] ├── vscode-reh-linux-arm64-min-ci
# [19:17:24] ├── vscode-reh-linux-arm64-min
# [19:17:24] ├── vscode-reh-alpine-arm64-ci
# [19:17:24] ├── vscode-reh-alpine-arm64
# [19:17:24] ├── vscode-reh-alpine-arm64-min-ci
# [19:17:24] ├── vscode-reh-alpine-arm64-min
# [19:17:24] ├── vscode-reh-linux-alpine-ci
# [19:17:24] ├── vscode-reh-linux-alpine
# [19:17:24] ├── vscode-reh-linux-alpine-min-ci
# [19:17:24] ├── vscode-reh-linux-alpine-min
# [19:17:24] ├── minify-vscode-reh-web
# [19:17:24] ├── vscode-reh-web-win32-x64-ci
# [19:17:24] ├── vscode-reh-web-win32-x64
# [19:17:24] ├── vscode-reh-web-win32-x64-min-ci
# [19:17:24] ├── vscode-reh-web-win32-x64-min
# [19:17:24] ├── vscode-reh-web-darwin-x64-ci
# [19:17:24] ├── vscode-reh-web-darwin-x64
# [19:17:24] ├── vscode-reh-web-darwin-x64-min-ci
# [19:17:24] ├── vscode-reh-web-darwin-x64-min
# [19:17:24] ├── vscode-reh-web-darwin-arm64-ci
# [19:17:24] ├── vscode-reh-web-darwin-arm64
# [19:17:24] ├── vscode-reh-web-darwin-arm64-min-ci
# [19:17:24] ├── vscode-reh-web-darwin-arm64-min
# [19:17:24] ├── vscode-reh-web-linux-x64-ci
# [19:17:24] ├── vscode-reh-web-linux-x64
# [19:17:24] ├── vscode-reh-web-linux-x64-min-ci
# [19:17:24] ├── vscode-reh-web-linux-x64-min
# [19:17:24] ├── vscode-reh-web-linux-armhf-ci
# [19:17:24] ├── vscode-reh-web-linux-armhf
# [19:17:24] ├── vscode-reh-web-linux-armhf-min-ci
# [19:17:24] ├── vscode-reh-web-linux-armhf-min
# [19:17:24] ├── vscode-reh-web-linux-arm64-ci
# [19:17:24] ├── vscode-reh-web-linux-arm64
# [19:17:24] ├── vscode-reh-web-linux-arm64-min-ci
# [19:17:24] ├── vscode-reh-web-linux-arm64-min
# [19:17:24] ├── vscode-reh-web-alpine-arm64-ci
# [19:17:24] ├── vscode-reh-web-alpine-arm64
# [19:17:24] ├── vscode-reh-web-alpine-arm64-min-ci
# [19:17:24] ├── vscode-reh-web-alpine-arm64-min
# [19:17:24] ├── vscode-reh-web-linux-alpine-ci
# [19:17:24] ├── vscode-reh-web-linux-alpine
# [19:17:24] ├── vscode-reh-web-linux-alpine-min-ci
# [19:17:24] ├── vscode-reh-web-linux-alpine-min
# [19:17:24] ├── vscode-symbols-win32-x64
# [19:17:24] ├── vscode-symbols-win32-arm64
# [19:17:24] ├── vscode-symbols-darwin
# [19:17:24] ├── vscode-symbols-linux-x64
# [19:17:24] ├── vscode-symbols-linux-armhf
# [19:17:24] ├── vscode-symbols-linux-arm64
# [19:17:24] ├── optimize-vscode
# [19:17:24] ├── minify-vscode
# [19:17:24] ├── core-ci
# [19:17:24] ├── core-ci-pr
# [19:17:24] ├── vscode-win32-x64-ci
# [19:17:24] ├── vscode-win32-x64
# [19:17:24] ├── vscode-win32-x64-min-ci
# [19:17:24] ├── vscode-win32-x64-min
# [19:17:24] ├── vscode-win32-arm64-ci
# [19:17:24] ├── vscode-win32-arm64
# [19:17:24] ├── vscode-win32-arm64-min-ci
# [19:17:24] ├── vscode-win32-arm64-min
# [19:17:24] ├── vscode-darwin-x64-ci
# [19:17:24] ├── vscode-darwin-x64
# [19:17:24] ├── vscode-darwin-x64-min-ci
# [19:17:24] ├── vscode-darwin-x64-min
# [19:17:24] ├── vscode-darwin-arm64-ci
# [19:17:24] ├── vscode-darwin-arm64
# [19:17:24] ├── vscode-darwin-arm64-min-ci
# [19:17:24] ├── vscode-darwin-arm64-min
# [19:17:24] ├── vscode-linux-x64-ci
# [19:17:24] ├── vscode-linux-x64
# [19:17:24] ├── vscode-linux-x64-min-ci
# [19:17:24] ├── vscode-linux-x64-min
# [19:17:24] ├── vscode
# [19:17:24] ├── vscode-min
# [19:17:24] ├── vscode-linux-armhf-ci
# [19:17:24] ├── vscode-linux-armhf
# [19:17:24] ├── vscode-linux-armhf-min-ci
# [19:17:24] ├── vscode-linux-armhf-min
# [19:17:24] ├── vscode-linux-arm64-ci
# [19:17:24] ├── vscode-linux-arm64
# [19:17:24] ├── vscode-linux-arm64-min-ci
# [19:17:24] ├── vscode-linux-arm64-min
# [19:17:24] ├── vscode-translations-export
# [19:17:24] ├── vscode-translations-import
# [19:17:24] ├── vscode-linux-x64-prepare-deb
# [19:17:24] ├── vscode-linux-x64-build-deb
# [19:17:24] ├── vscode-linux-x64-prepare-rpm
# [19:17:24] ├── vscode-linux-x64-build-rpm
# [19:17:24] ├── vscode-linux-x64-prepare-snap
# [19:17:24] ├── vscode-linux-x64-build-snap
# [19:17:24] ├── vscode-linux-armhf-prepare-deb
# [19:17:24] ├── vscode-linux-armhf-build-deb
# [19:17:24] ├── vscode-linux-armhf-prepare-rpm
# [19:17:24] ├── vscode-linux-armhf-build-rpm
# [19:17:24] ├── vscode-linux-armhf-prepare-snap
# [19:17:24] ├── vscode-linux-armhf-build-snap
# [19:17:24] ├── vscode-linux-arm64-prepare-deb
# [19:17:24] ├── vscode-linux-arm64-build-deb
# [19:17:24] ├── vscode-linux-arm64-prepare-rpm
# [19:17:24] ├── vscode-linux-arm64-build-rpm
# [19:17:24] ├── vscode-linux-arm64-prepare-snap
# [19:17:24] ├── vscode-linux-arm64-build-snap
# [19:17:24] ├── vscode-win32-x64-system-setup
# [19:17:24] ├── vscode-win32-arm64-system-setup
# [19:17:24] ├── vscode-win32-x64-user-setup
# [19:17:24] ├── vscode-win32-arm64-user-setup
# [19:17:24] ├── vscode-win32-x64-inno-updater
# [19:17:24] └── vscode-win32-arm64-inno-updater
# Done in 5.65s.

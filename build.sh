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

## Get Node (for in China)
# mkdir -p .build/node/v18.15.0/linux-x64/
# curl -Lk https://mirrors.aliyun.com/nodejs-release/v18.15.0/node-v18.15.0-linux-x64.tar.xz | xz -d | tar -x node-v18.15.0-linux-x64/bin/node -O > .build/node/v18.15.0/linux-x64/node
# chmod +x .build/node/v18.15.0/linux-x64/node

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

## Tasks for /workspaces/build-workflow/repos/vscode/gulpfile.js
## extract-editor-src
## editor-distro
## editor-esm-bundle
## monacodts
## transpile-extension:authentication-proxy
## compile-extension:authentication-proxy
## watch-extension:authentication-proxy
## transpile-extension:configuration-editing-build
## compile-extension:configuration-editing-build
## watch-extension:configuration-editing-build
## transpile-extension:configuration-editing
## compile-extension:configuration-editing
## watch-extension:configuration-editing
## transpile-extension:css-language-features-client
## compile-extension:css-language-features-client
## watch-extension:css-language-features-client
## transpile-extension:css-language-features-server
## compile-extension:css-language-features-server
## watch-extension:css-language-features-server
## transpile-extension:debug-auto-launch
## compile-extension:debug-auto-launch
## watch-extension:debug-auto-launch
## transpile-extension:debug-server-ready
## compile-extension:debug-server-ready
## watch-extension:debug-server-ready
## transpile-extension:emmet
## compile-extension:emmet
## watch-extension:emmet
## transpile-extension:extension-editing
## compile-extension:extension-editing
## watch-extension:extension-editing
## transpile-extension:git
## compile-extension:git
## watch-extension:git
## transpile-extension:git-base
## compile-extension:git-base
## watch-extension:git-base
## transpile-extension:github-authentication
## compile-extension:github-authentication
## watch-extension:github-authentication
## transpile-extension:github
## compile-extension:github
## watch-extension:github
## transpile-extension:grunt
## compile-extension:grunt
## watch-extension:grunt
## transpile-extension:gulp
## compile-extension:gulp
## watch-extension:gulp
## transpile-extension:html-language-features-client
## compile-extension:html-language-features-client
## watch-extension:html-language-features-client
## transpile-extension:html-language-features-server
## compile-extension:html-language-features-server
## watch-extension:html-language-features-server
## transpile-extension:ipynb
## compile-extension:ipynb
## watch-extension:ipynb
## transpile-extension:jake
## compile-extension:jake
## watch-extension:jake
## transpile-extension:json-language-features-client
## compile-extension:json-language-features-client
## watch-extension:json-language-features-client
## transpile-extension:json-language-features-server
## compile-extension:json-language-features-server
## watch-extension:json-language-features-server
## transpile-extension:markdown-language-features-preview-src
## compile-extension:markdown-language-features-preview-src
## watch-extension:markdown-language-features-preview-src
## transpile-extension:markdown-language-features-server
## compile-extension:markdown-language-features-server
## watch-extension:markdown-language-features-server
## transpile-extension:markdown-language-features
## compile-extension:markdown-language-features
## watch-extension:markdown-language-features
## transpile-extension:markdown-math
## compile-extension:markdown-math
## watch-extension:markdown-math
## transpile-extension:media-preview
## compile-extension:media-preview
## watch-extension:media-preview
## transpile-extension:merge-conflict
## compile-extension:merge-conflict
## watch-extension:merge-conflict
## transpile-extension:microsoft-authentication
## compile-extension:microsoft-authentication
## watch-extension:microsoft-authentication
## transpile-extension:notebook-renderers
## compile-extension:notebook-renderers
## watch-extension:notebook-renderers
## transpile-extension:npm
## compile-extension:npm
## watch-extension:npm
## transpile-extension:php-language-features
## compile-extension:php-language-features
## watch-extension:php-language-features
## transpile-extension:search-result
## compile-extension:search-result
## watch-extension:search-result
## transpile-extension:references-view
## compile-extension:references-view
## watch-extension:references-view
## transpile-extension:simple-browser
## compile-extension:simple-browser
## watch-extension:simple-browser
## transpile-extension:tunnel-forwarding
## compile-extension:tunnel-forwarding
## watch-extension:tunnel-forwarding
## transpile-extension:typescript-language-features-test-workspace
## compile-extension:typescript-language-features-test-workspace
## watch-extension:typescript-language-features-test-workspace
## transpile-extension:typescript-language-features-web
## compile-extension:typescript-language-features-web
## watch-extension:typescript-language-features-web
## transpile-extension:typescript-language-features
## compile-extension:typescript-language-features
## watch-extension:typescript-language-features
## transpile-extension:vscode-api-tests
## compile-extension:vscode-api-tests
## watch-extension:vscode-api-tests
## transpile-extension:vscode-colorize-tests
## compile-extension:vscode-colorize-tests
## watch-extension:vscode-colorize-tests
## transpile-extension:vscode-test-resolver
## compile-extension:vscode-test-resolver
## watch-extension:vscode-test-resolver
## transpile-extensions
## compile-extensions
## watch-extensions
## compile-extensions-build-legacy
## compile-extension-media
## watch-extension-media
## compile-extension-media-build
## compile-extensions-build
## extensions-ci
## compile-extensions-build-pr
## extensions-ci-pr
## compile-web
## watch-web
## compile-api-proposal-names
## watch-api-proposal-names
## transpile-client-swc
## transpile-client
## compile-client
## watch-client
## compile
## watch
## default
## compile-cli
## watch-cli
## compile-build
## compile-build-pr
## check-package-json
## hygiene
## minify-vscode-web
## compile-web-extensions-build
## vscode-web-ci
## vscode-web
## vscode-web-min-ci
## vscode-web-min
## node-win32-x64
## node-darwin-x64
## node-darwin-arm64
## node-linux-x64
## node-linux-armhf
## node-linux-arm64
## node-alpine-arm64
## node-linux-alpine
## node
## minify-vscode-reh
## vscode-reh-win32-x64-ci
## vscode-reh-win32-x64
## vscode-reh-win32-x64-min-ci
## vscode-reh-win32-x64-min
## vscode-reh-darwin-x64-ci
## vscode-reh-darwin-x64
## vscode-reh-darwin-x64-min-ci
## vscode-reh-darwin-x64-min
## vscode-reh-darwin-arm64-ci
## vscode-reh-darwin-arm64
## vscode-reh-darwin-arm64-min-ci
## vscode-reh-darwin-arm64-min
## vscode-reh-linux-x64-ci
## vscode-reh-linux-x64
## vscode-reh-linux-x64-min-ci
## vscode-reh-linux-x64-min
## vscode-reh-linux-armhf-ci
## vscode-reh-linux-armhf
## vscode-reh-linux-armhf-min-ci
## vscode-reh-linux-armhf-min
## vscode-reh-linux-arm64-ci
## vscode-reh-linux-arm64
## vscode-reh-linux-arm64-min-ci
## vscode-reh-linux-arm64-min
## vscode-reh-alpine-arm64-ci
## vscode-reh-alpine-arm64
## vscode-reh-alpine-arm64-min-ci
## vscode-reh-alpine-arm64-min
## vscode-reh-linux-alpine-ci
## vscode-reh-linux-alpine
## vscode-reh-linux-alpine-min-ci
## vscode-reh-linux-alpine-min
## minify-vscode-reh-web
## vscode-reh-web-win32-x64-ci
## vscode-reh-web-win32-x64
## vscode-reh-web-win32-x64-min-ci
## vscode-reh-web-win32-x64-min
## vscode-reh-web-darwin-x64-ci
## vscode-reh-web-darwin-x64
## vscode-reh-web-darwin-x64-min-ci
## vscode-reh-web-darwin-x64-min
## vscode-reh-web-darwin-arm64-ci
## vscode-reh-web-darwin-arm64
## vscode-reh-web-darwin-arm64-min-ci
## vscode-reh-web-darwin-arm64-min
## vscode-reh-web-linux-x64-ci
## vscode-reh-web-linux-x64
## vscode-reh-web-linux-x64-min-ci
## vscode-reh-web-linux-x64-min
## vscode-reh-web-linux-armhf-ci
## vscode-reh-web-linux-armhf
## vscode-reh-web-linux-armhf-min-ci
## vscode-reh-web-linux-armhf-min
## vscode-reh-web-linux-arm64-ci
## vscode-reh-web-linux-arm64
## vscode-reh-web-linux-arm64-min-ci
## vscode-reh-web-linux-arm64-min
## vscode-reh-web-alpine-arm64-ci
## vscode-reh-web-alpine-arm64
## vscode-reh-web-alpine-arm64-min-ci
## vscode-reh-web-alpine-arm64-min
## vscode-reh-web-linux-alpine-ci
## vscode-reh-web-linux-alpine
## vscode-reh-web-linux-alpine-min-ci
## vscode-reh-web-linux-alpine-min
## vscode-symbols-win32-x64
## vscode-symbols-win32-arm64
## vscode-symbols-darwin
## vscode-symbols-linux-x64
## vscode-symbols-linux-armhf
## vscode-symbols-linux-arm64
## optimize-vscode
## minify-vscode
## core-ci
## core-ci-pr
## vscode-win32-x64-ci
## vscode-win32-x64
## vscode-win32-x64-min-ci
## vscode-win32-x64-min
## vscode-win32-arm64-ci
## vscode-win32-arm64
## vscode-win32-arm64-min-ci
## vscode-win32-arm64-min
## vscode-darwin-x64-ci
## vscode-darwin-x64
## vscode-darwin-x64-min-ci
## vscode-darwin-x64-min
## vscode-darwin-arm64-ci
## vscode-darwin-arm64
## vscode-darwin-arm64-min-ci
## vscode-darwin-arm64-min
## vscode-linux-x64-ci
## vscode-linux-x64
## vscode-linux-x64-min-ci
## vscode-linux-x64-min
## vscode
## vscode-min
## vscode-linux-armhf-ci
## vscode-linux-armhf
## vscode-linux-armhf-min-ci
## vscode-linux-armhf-min
## vscode-linux-arm64-ci
## vscode-linux-arm64
## vscode-linux-arm64-min-ci
## vscode-linux-arm64-min
## vscode-translations-export
## vscode-translations-import
## vscode-linux-x64-prepare-deb
## vscode-linux-x64-build-deb
## vscode-linux-x64-prepare-rpm
## vscode-linux-x64-build-rpm
## vscode-linux-x64-prepare-snap
## vscode-linux-x64-build-snap
## vscode-linux-armhf-prepare-deb
## vscode-linux-armhf-build-deb
## vscode-linux-armhf-prepare-rpm
## vscode-linux-armhf-build-rpm
## vscode-linux-armhf-prepare-snap
## vscode-linux-armhf-build-snap
## vscode-linux-arm64-prepare-deb
## vscode-linux-arm64-build-deb
## vscode-linux-arm64-prepare-rpm
## vscode-linux-arm64-build-rpm
## vscode-linux-arm64-prepare-snap
## vscode-linux-arm64-build-snap
## vscode-win32-x64-system-setup
## vscode-win32-arm64-system-setup
## vscode-win32-x64-user-setup
## vscode-win32-arm64-user-setup
## vscode-win32-x64-inno-updater
## vscode-win32-arm64-inno-updater

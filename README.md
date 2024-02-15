# NOTE

- each time you build, don't forgot to add the meta tags to the index.html generated by build script. Vue-Meta does not have a stable release for Vue 3 yet, so have to do it manually

```
<meta property="og:title" content="Map for Grasslands" />
<meta property="og:description" content="Grasslands and their wildlife are vanishing. The North American Grasslands Conservation Act works to reverse this trend by protecting places vital to animals and people." />
<meta property="og:image" content="https://mapforgrasslands.org/images/grasslands-social-preview.png" />
<meta property="og:url" content="https://mapforgrasslands.org/" />
<meta property="og:type" content="website" />
    ```

# Vue 3 + Vite

This template should help get you started developing with Vue 3 in Vite. The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.

## Recommended IDE Setup

- [VS Code](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur) + [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin).

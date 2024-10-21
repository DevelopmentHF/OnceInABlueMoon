# Once In A Blue Moon

A quick 'n dirty implementation of a silly minigame idea.
Find and destroy all moons, but not the blue one!

> [!IMPORTANT]
> This template uses [middleclass](https://github.com/kikito/middleclass?tab=readme-ov-file) for basic OOP structuring, and [anim8](https://github.com/kikito/anim8/tree/master) for easier animation handling.

## Running the development build

Execute this from top-most directory of your created game folder

```bash
/Applications/love.app/Contents/MacOS/love game
```

## Building

### Web Building

To build for web in order to publish to itch.io,

```bash
npm i love.js
```

```bash
npx love.js game build
```

then zip the build and upload it.

This repository has had issues with this technique of building. An alternative approach is to zip the **contents** of the `game/` directory, not `game/` itself into `build.love` then run

```bash
npx love.js game/build.love build
```

>[!CAUTION]
> Due to quirks with `love.js` make sure to turn on the experimental `SharedArrayBuffer` support option.


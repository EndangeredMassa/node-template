# node template projects

This is a collection of node template projects.

- [[master](https://github.com/EndangeredMassa/node-template/tree/master)] single-page application

## single-page application project

Install with:

```
git clone --depth=1 -b master git@github.com:EndangeredMassa/node-template.git && cd node-template && rm -rf .git
```

The following primary technologies are used herein.

**code**

- coffeescript
- stylus
- facile
- express

**test**

- mocha
- assertive
- bond
- testium

**build**

- gulp
- browserify

### tasks

The standard `npm test` and `npm start`
do what you would expect.
Beyond that,
[gulp](https://github.com/gulpjs/gulp)
is used as a simple task runner
and build system.
The definition for the the tasks
can be found under `/tasks`.

```
.
├── gulpfile.js
└── tasks
    ├── clean.coffee
    ├── gulp-digest.js
    ├── images.coffee
    ├── index.coffee
    ├── scripts.coffee
    ├── styles.coffee
    ├── templates.coffee
    ├── test.coffee
    └── watch.coffee
```

The default task is a listing of all tasks.

```
$ gulp
[gulp] Using gulpfile ~/#{YOUR_PATH}/gulpfile.js
[gulp] Starting 'default'...

Main Tasks
------------------------------
    assets
    clean
    default
    images
    scripts
    styles
    test
    watch

Sub Tasks
------------------------------
    test-scripts
```


### require

For client-side code and unit tests,
`require` has a special enhancement.
Any path that starts with `~`
refers to the `/src`.

```
Model = require '~/entity/model'
```

when compiled becomes:

```
var Model = require('/home/someone/node-template/src/entity/model');
```

This makes it very easy to require code under test.
It also makes it easy to jump out of
your current directory without an arbitrary
number of `../../` trackbacks.
This should be done rarely within `/src`,
but you can go nuts under `/test`.


### digest

TODO: explain

`/digest.json`

`NODE_ENV=production`


### application code

The code itself is structured under `/src`.

```
.
└── src
    ├── bootstrap
    │   ├── colors.styl
    │   ├── index.coffee
    │   ├── layout.styl
    │   └── styles.styl
    ├── entity
    │   ├── model.coffee
    │   ├── styles.styl
    │   ├── template.html
    │   └── view.coffee
    └── server
        ├── index.coffee
        └── index.html
```

It is organized by module, not file type.
Any coffeescript, stylus, or html files
can be located inside a module's directory.
The html can be required as a string,
which is often used here by
[facile](https://github.com/EndangeredMassa/facile.js)
to compile it as a template.
The server here is just another module.

## license

[MIT](LICENSE)


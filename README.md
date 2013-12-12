# grunt-write-bower-json

[![Build Status](https://travis-ci.org/testdouble/grunt-write-bower-json.png?branch=master)](https://travis-ci.org/testdouble/grunt-write-bower-json)

### Overview

This is a simple little grunt task for dynamically generating a bower.json file
using a JSON template which can interpolate `<%= %>` tags with any value in your
grunt config using [grunt.template.process](http://gruntjs.com/api/grunt.template#grunt.template.process)

With a configuration like this:

```js
writeBowerJson: {
  options: {
    bowerJsonTemplate: 'config/bower-template.json'
  }
}
```

You can define a file in `config/bower-template.json`

``` json
{
  "name": "<%= pkg.name %>",
  "version": "<%= pkg.version %>",
  "main": "dist/<%= files.js.uncompressedDist %>",
  "ignore": [
    "app",
    "config",
    "spec",
    "tasks",
    ".travis.yml",
    "Gruntfile.js",
    "main.js",
    "package.json"
  ],
  "dependencies": {
  },
  "devDependencies": {
  }
}

```

And running `grunt writeBowerJson` should output like this:

```
Running "writeBowerJson" task
Wrote `bower.json` from template `config/bower-template.json`

Done, without errors.
```

## Running Specs

* clone this repo
* `npm install`
* `grunt spec`

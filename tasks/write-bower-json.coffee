module.exports = (grunt) ->
  _ = grunt.util._

  grunt.registerTask "writeBowerJson", ->
    options = @options
      bowerJsonTemplate: "config/bower-template.json"
    bowerJson = grunt.file.readJSON(options.bowerJsonTemplate)
    grunt.file.write("bower.json", JSON.stringify(templatize(bowerJson), null, 2))
    grunt.log.writeln("Wrote `bower.json` from template `#{options.bowerJsonTemplate}`")

  templatize = (thing) ->
    if _(thing).isArray()
      _(thing).map (val) -> templatize(val)
    else if _(thing).isFunction()
      thing
    else if _(thing).isObject()
      _({}).tap (obj) ->
        _(thing).each (val, key) ->
          obj[templatize(key)] = templatize(val)
    else if _(thing).isString()
      grunt.template.process(thing)
    else
      thing


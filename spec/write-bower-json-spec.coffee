grunt  = require("grunt")
spawn  = require("child_process").spawn
bowerJson = "spec/bower.json"
runGruntTask = (task, config, done) ->
  spawn("grunt",
    [
      task,
      "--config", JSON.stringify(config),
      "--tasks", "../tasks"
      "--gruntfile", "spec/Gruntfile.coffee"
    ],
    {stdio: 'ignore'}
  ).on("exit", -> done())

wipe = -> grunt.file.delete(bowerJson) if grunt.file.exists(bowerJson)

beforeEach(wipe)
afterEach(wipe)

describe "writeBowerJson", ->

  Given ->
    @config =
      writeBowerJson:
        options:
          bowerJsonTemplate: "fixtures/some-dir/bower-template.json"

  describe "writes a simple bower.json correctly", ->
    Given -> @config.foo = "hi"
    Given -> @config.bar = "bye"
    When (done) -> runGruntTask("writeBowerJson", @config, done)
    Then -> expect(grunt.file.readJSON(bowerJson)).toEqual
      hi: "bye"
      also: ["bye", "bye"]
      finally:
        bye: "hi"

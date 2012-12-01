require "./lib/mongo-sugar/version"

Gem::Specification.new do |s|
  s.name        = "mongo-sugar"
  s.version     = Mongo::Sugar::VERSION
  s.authors     = ["Endel Dreyer"]
  s.email       = ["endel.dreyer@gmail.com"]
  s.homepage    = "https://github.com/endel/mongo-sugar"
  s.summary     = "Sugar Syntatic for Official MongoDB Driver"
  s.description = "Provide a syntatic sugar for MongoDB ruby driver, similar to an ORM."

  s.files = Dir["{lib}/**/*"] + ["LICENSE", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "mongo", ">= 1.1"
  s.add_dependency "bson_ext", ">= 1.1"
end

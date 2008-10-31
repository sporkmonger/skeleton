namespace :skeleton do
  task :init do
    print "Project Name (titlecase): "
    project_name = gets
    print "Require Name: "
    project_require_name = gets
    puts "Project Description:"
    project_description = gets

    file_list = FileList[
      "lib/**/*", "spec/**/*", "vendor/**/*",
      "tasks/**/*", "website/**/*",
      "[A-Z]*", "Rakefile"
    ].exclude(/database\.yml/).exclude(/[_\.]git$/)

    for file_name in file_list
      contents = File.open(file_name, "r") { |file| file.read }
      contents.gsub!("Skeleton", project_name)
      contents.gsub!("skeleton", project_require_name)
      contents.gsub!("Library description goes here.", project_description)
      File.open(file_name, "w") { |file| file.write(contents) }
    end

    File.delete(__FILE__)
  end
end

namespace :skeleton do
  task :init do
    if File.basename(File.expand_path(".")) == "skeleton"
      puts "Cannot initialize the skeleton itself."
      exit(1)
    end

    print "Project Name (titlecase): "
    project_name = STDIN.gets.strip
    print "Require Name: "
    project_require_name = STDIN.gets.strip
    puts "Project Description:"
    project_description = STDIN.gets.strip
    puts

    file_list = FileList[
      "lib/**/*", "spec/**/*", "vendor/**/*",
      "tasks/**/*", "website/**/*",
      "[A-Z]*", "Rakefile"
    ].exclude(/database\.yml/).exclude(/[_\.]git$/)

    for file_name in file_list
      if File.file?(file_name)
        contents = File.open(file_name, "r") { |file| file.read }
        contents.gsub!("Skeleton", project_name)
        contents.gsub!("skeleton", project_require_name)
        contents.gsub!("Library description goes here.", project_description)
        File.open(file_name, "w") { |file| file.write(contents) }
      end
    end
    for file_name in file_list
      if File.directory?(file_name) && file_name =~ /skeleton/
        File.rename(
          file_name, file_name.gsub(/skeleton/, project_require_name)
        )
      end
    end
    file_list = FileList[
      "lib/**/*", "spec/**/*", "vendor/**/*",
      "tasks/**/*", "website/**/*",
      "[A-Z]*", "Rakefile", ".gitignore"
    ].exclude(/database\.yml/).exclude(/[_\.]git$/).exclude(/skeleton/)

    File.delete(__FILE__)

    system("rm -rf .git")
    system("git init")
    system("git add #{file_list.join(" ")}")
    system("git status")

    puts
    puts "Run 'git commit -m \"Basic project skeleton.\"'."
  end
end

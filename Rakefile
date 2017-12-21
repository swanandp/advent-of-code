require "bundler/gem_tasks"
task default: :spec

def touch_file(file_path, file_content)
  unless File.exists?(file_path)
    File.open(file_path, "wb") do |f|
      f.puts file_content
    end
  end
end

desc "Generate boilerplate for a new day"
task :new, [:day_num, :year] do |_task, args|
  year = args[:year] || "2017"
  day = args[:day_num]
  file_name = "advent_of_code/#{year}/day_#{day}"

  require_file_path = "lib/advent_of_code/#{year}/#{year}.rb"
  require_string = %{require "#{file_name}"}

  unless File.read(require_file_path).include?(require_string)
    File.open(require_file_path, "a+") do |f|
      f.puts require_string
    end
  end

  day_file_content = <<~CLASS
    class Day#{day}
    end
  CLASS

  touch_file(
    "lib/#{file_name}.rb",
    day_file_content
  )

  Dir.mkdir(File.join("spec", "fixtures", year, "day_#{day}"))

  touch_file(
    "spec/fixtures/#{year}/day_#{day}/sample.txt",
    ""
  )

  touch_file(
    "spec/fixtures/#{year}/day_#{day}/input.txt",
    ""
  )
end

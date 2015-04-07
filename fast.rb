#!/usr/bin/ruby

REPO=File.expand_path "~/.m2/repository"

unless File.exists? "pom.xml"
  puts "No pom.xml found in current directory. Giving up!"
  exit(1)
end

unless File.exists? REPO
  print "  => local repo did not exist, creating #{REPO}..."
  system "mkdir -p #{REPO}"
  unless $?.success
    puts
    puts "FAILED to create dir #{REPO}"
    exit(1)
  end
  puts "OK"
end

# Compute dependency closure
print "  => computing transitive closure of dependencies ..."
dep_raw = `mvn dependency:tree -Ddependency.outputFile=#{TMPFILE}`

unless $?.success
  puts
  puts dep_raw
  puts
  puts "FAILED to run 'mvn dependency:tree'"
  exit(1)
end

# Fetch them in parallel...
puts "OK"
print "  => fast-fetching dependencies ..."

puts "OK"
# Continue onward to maven!
exec $* if $1

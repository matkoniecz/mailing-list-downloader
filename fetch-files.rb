def execute_command(command)
  puts command
  `#{command}`
end

Dir.mkdir 'archives' unless File.directory?("archives")
Dir.chdir("archives")

# TODO: better handle updating archives

# TODO: better handle download+unpacking failing because archive is not available for that time as list has not yet existed
#       right now it works but leaves garbage files and confusing output

# rewrite in Python?

["tagging", "talk", "osmf-talk", "legal-talk", "talk-us", "talk-gb", "talk-ca", "talk-pl", "dev", "josm-dev"].each do |mailing_list|
  (2004..Time.now.year).each do |year| # https://lists.openstreetmap.org/pipermail/talk/
    ["January", "February", "March", "April", "May", "June", "July", "August",
     "September", "October", "November", "December"].each_with_index do |month, month_index|
       if year == Time.now.year && (month_index + 1) > Time.now.month
         puts "skipping #{year} #{month} as it is in future"
         next
       end
       if year > Time.now.year
         puts "skipping #{year} #{month} as it is in future"
         next
       end
       base_url = "https://lists.openstreetmap.org/pipermail"
       filename = "#{mailing_list}-#{year}-#{month}.txt.gz"
       command = "curl #{base_url}/#{mailing_list}/#{year}-#{month}.txt.gz > #{filename}"
       execute_command(command)
       execute_command("gunzip --force \"#{filename}\"")
     end
  end
end

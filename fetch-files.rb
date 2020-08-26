def execute_command(command)
  puts command
  `#{command}`
end

["tagging", "talk"].each do |mailing_list|
  [2018, 2019].each do |year|
    ["January", "February", "March", "April", "May", "June", "July",
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
       execute_command("gunzip \"#{filename}\"")
     end
  end
end

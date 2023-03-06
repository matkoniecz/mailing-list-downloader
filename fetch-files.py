import os
import datetime

def execute_command(command):
  print(command)
  os.system(command)

if os.path.isdir("archives") == False:
    os.mkdir('archives')
os.chdir('archives')

# TODO: better handle updating archives

# TODO: better handle download+unpacking failing because archive is not available for that time as list has not yet existed
#       right now it works but leaves garbage files and confusing output

now = datetime.datetime.now()
for mailing_list in ["tagging", "talk", "osmf-talk", "legal-talk", "talk-us", "talk-gb", "talk-ca", "talk-pl", "dev", "josm-dev"]:
  for year_number in range(2004, now.year):
    year = str(year_number)
    for month_index, month in enumerate(["January", "February", "March", "April", "May",
    "June", "July", "August", "September", "October", "November", "December"]):
       if year_number == now.year and (month_index + 1) > now.month:
         print("skipping " + year + " " + month + " as it is in future")
         next
       if year_number > now.year:
         print("skipping " + year + " " + month + " as it is in future")
         next
       base_url = "https://lists.openstreetmap.org/pipermail"
       filename = mailing_list + "-" + year + "-" + month + ".txt.gz"
       command = "curl " + base_url + "/" + mailing_list + "/" + year + "-" + month + ".txt.gz > " + filename + ""
       execute_command(command)
       execute_command("gunzip --force \"" + filename + "\"")

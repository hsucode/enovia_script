
import os

old_file_name = "C:\Tmp\server.xml"
new_file_name = "C:\Tmp\server_backup.xml"
os.rename(old_file_name, new_file_name)

input_file = "C:\Tmp\server_backup.xml"
output_file = "C:\Tmp\server.xml"

with open(input_file, 'r') as f:
    lines = f.readlines()

with open(output_file, 'w') as f:
    for i, line in enumerate(lines):
        if i + 1 == 22:
            line = line.replace('8005', '8006')
            
        if i + 1 == 70:
            line = line.replace('8080', '8081')
        
        if i + 1 == 72:
            line = line.replace('8443', '8444')
            
        f.write(line)

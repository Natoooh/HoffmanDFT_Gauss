#!/u/local/apps/python/3.9.6/gcc-4.8.5/bin

import os


files = os.listdir()
print(files)
for file in files:
    if ".joblog" in file:
        # print(file)
        log_file_name = file
    if ".rwf" in file:
        # print(file)
        rwf_file_name = file
    if ".com" in file:
        # print(file)
        com_file_name = file


with open(log_file_name, "r") as f:

    file_text = f.read()
    file_text = file_text.split("\n")
    for line in file_text:
        if "GAUSS_SCRDIR" in line:
            id = line
            print(line)
id = id.split("=")[1]

SCRDIR = os.listdir(id)
for file in SCRDIR:
    if ".rwf" in file:
        # print(file)
        rwf_file_name = file

RWFLine = "%RWF=" + id + "/" + rwf_file_name
#print(RWFLine)

with open(com_file_name, "r") as F_R:
    text = F_R.read()
    text = text.split("\n")
    # print(text)

with open(com_file_name, "w+") as F_W:
    for line in text:
        if line.startswith("#"):
            #print(line)
            F_W.write(RWFLine)
            F_W.write("\n")
            F_W.write("#Restart")
            F_W.write("\n")
        else:
            F_W.write(line)
            F_W.write("\n")

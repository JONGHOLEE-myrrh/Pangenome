import os, sys

f_out_file = open("Ortholog_list.txt", "w")

s_list_files = []
#s_list_pan_files  = []
for i in os.listdir("./"):
    if i.endswith(".txt"):
        if (i.startswith("Pan") or i.startswith("Core")):
            s_list_files.append(i)
#        if i.startswith("Core"):
#            s_list_core_files.append(i)
#        elif i.startswith("Pan"):
#            s_list_pan_files.append(i)
        else: continue
    else: continue
# End of for loop.

s_ortholog_list = []
for s_file in s_list_files:
    f_file = open(s_file, "r")

    for s_readline in f_file.readlines():
        s_readline = s_readline.strip()
        s_new_line = "%s\t%s\t%s"%(s_file.split(".")[0].split("_")[1], s_readline, s_file.split(".")[0].split("_")[0])
        s_ortholog_list.append(s_new_line)
    # End of for loop.
    f_file.close()
# End of for loop.

print("Genomes\tOrthologs\tStatus", file=f_out_file)
for s_final_line in s_ortholog_list:
    print(s_final_line, file=f_out_file)
# End of for loop.
f_out_file.close()

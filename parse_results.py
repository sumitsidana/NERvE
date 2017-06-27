with open('results') as infile, open('results_output', 'w') as outfile:
    for line in infile:
        if not line.strip(): continue  # skip the empty line
        outfile.write(line)  # non-empty line. Write it to output
	
f = open('results_output', 'r')
f1 = open('model_0_1', 'w')
f2 = open('model_1_0', 'w')
f3 = open('model_1_1', 'w')

flag_0_1 = False
flag_1_0 = False
flag_1_1 = False

for line in f:

    line = line.strip('\n')

    if line == "alpha: 0, beta: 1":
        flag_0_1 = True
        flag_1_1 = False
        flag_1_0 = False
        f3.write('\n')
        continue

    if line == "alpha: 1, beta: 0":
        flag_0_1 = False
        flag_1_1 = False
        flag_1_0 = True
        f1.write('\n')
        continue

    if line == "alpha: 1, beta: 1":
        flag_0_1 = False
        flag_1_1 = True
        flag_1_0 = False
        f2.write('\n')
        continue

    if flag_0_1:
        if "map@10" in line:
            f1.write(line[7:])
        else:
            f1.write(line[7:]+" ")
            continue

    if flag_1_0:
        if "map@10" in line:
            f2.write(line[7:])
        else:
            f2.write(line[7:]+" ")
            continue

    if flag_1_1:
        if "map@10" in line:
            f3.write(line[7:])
        else:
            f3.write(line[7:]+" ")
            continue


f1.close()
f2.close()
f3.close()
f.close()


#f1 = open('model_0_1', "r+")

#Move the pointer (similar to a cursor in a text editor) to the end of the file.
#f1.seek(0, SEEK_END)

#This code means the following code skips the very last character in the file -
#i.e. in the case the last line is null we delete the last line
#and the penultimate one
#pos = f1.tell() - 1

#Read each character in the file one at a time from the penultimate
#character going backwards, searching for a newline character
#If we find a new line, exit the search
#while pos > 0 and f1.read(1) != "\n":
#    pos -= 1
#    f1.seek(pos, SEEK_SET)

#So long as we're not at the start of the file, delete all the characters ahead of this position
#if pos > 0:
#    f1.seek(pos, SEEK_SET)
#    f1.truncate()

#f1.close()

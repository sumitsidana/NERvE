# with open('results') as infile, open('results_output', 'w') as outfile:
#     for line in infile:
#         if not line.strip(): continue  # skip the empty line
#         outfile.write(line)  # non-empty line. Write it to output
	
# f = open('results_output', 'r')
import sys
f = open('/data/sidana/recnet_draft/'+sys.argv[1]+'/recnet_objective_batches/results', 'r')
f1 = open('/data/sidana/recnet_draft/'+sys.argv[1]+'/recnet_objective_batches/objective_batches_'+sys.argv[1], 'w')

flag_0_1 = False
flag_1_0 = False
flag_1_1 = False

flag_write=False

for line in f:

    line = line.strip('\n')

    if line == "alpha: 0, beta: 1":
        flag_0_1 = True
        flag_1_1 = False
        flag_1_0 = False
        continue

    if line == "alpha: 1, beta: 0":
        flag_0_1 = False
        flag_1_1 = False
        flag_1_0 = True
        continue

    if line == "alpha: 1, beta: 1":
        flag_0_1 = False
        flag_1_1 = True
        flag_1_0 = False
        continue

    if "number of batches:" in line:
        index = line.index(" ",19)
        num_batches = line[19:index]
        flag_write = True
        f1.write(num_batches + " ")

    else:
        if "No rating diversity in train set for user" in line:
            continue
        else:
            objective = line[0:]
            if flag_write:
                if flag_1_1:
                    f1.write(objective + "\n")
                    flag_write = False
                else:
                    f1.write(objective + " ")

f1.close()
f.close()


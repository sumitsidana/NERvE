# with open('results') as infile, open('results_output', 'w') as outfile:
#     for line in infile:
#         if not line.strip(): continue  # skip the empty line
#         outfile.write(line)  # non-empty line. Write it to output
	
# f = open('results_output', 'r')
import sys
f = open('/data/sidana/recnet_draft/param_tune/'+sys.argv[1]+'/recnet/results', 'r')
f1 = open('/data/sidana/recnet_draft/param_tune/'+sys.argv[1]+'/recnet/embeddings', 'w')

flag_0_1 = False
flag_1_0 = False
flag_1_1 = False

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

    if flag_1_1:
        if "map@1:" in line:
            f1.write(line[7:])
            f1.write('\n')

    elif flag_1_0:
        if "map@1:" in line:
            f1.write(line[7:]+" ")
    else:
        if "map@1:" in line:
            f1.write(line[7:]+" ")
        elif "Latent Factor" in line and "Regularization: 0.0001 Hidden Units: 64" in line:
            f1.write(line[15:16] + " ")

f1.close()
f.close()


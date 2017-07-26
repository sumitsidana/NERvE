# with open('results') as infile, open('results_output', 'w') as outfile:
#     for line in infile:
#         if not line.strip(): continue  # skip the empty line
#         outfile.write(line)  # non-empty line. Write it to output
	
# f = open('results_output', 'r')
import sys
f = open('/data/sidana/recnet_draft/param_tune/'+sys.argv[1]+'/recnet/results', 'r')
f1 = open('/data/sidana/recnet_draft/param_tune/'+sys.argv[1]+'/recnet/model_0_1', 'w')
f2 = open('/data/sidana/recnet_draft/param_tune/'+sys.argv[1]+'/recnet/model_1_0', 'w')
f3 = open('/data/sidana/recnet_draft/param_tune/'+sys.argv[1]+'/recnet/model_1_1', 'w')

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
            continue
        else:
            f1.write(line[7:]+" ")
            continue

    if flag_1_0:
        if "map@10" in line:
            f2.write(line[7:])
            continue
        else:
            f2.write(line[7:]+" ")
            continue

    if flag_1_1:
        if "map@10" in line:
            f3.write(line[7:])
        elif "Latent Factor" in line:
            pass
        else:
            f3.write(line[7:]+" ")
            continue


f1.close()
f2.close()
f3.close()
f.close()


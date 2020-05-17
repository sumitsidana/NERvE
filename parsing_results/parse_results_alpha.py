# with open('results') as infile, open('results_output', 'w') as outfile:
#     for line in infile:
#         if not line.strip(): continue  # skip the empty line
#         outfile.write(line)  # non-empty line. Write it to output
	
# f = open('results_output', 'r')
import sys
f = open('/data/sidana/recnet/recnet_alpha/'+sys.argv[1]+'/results', 'r')
f1 = open('/data/sidana/recnet/recnet_alpha/'+sys.argv[1]+'/alpha_'+sys.argv[1], 'w')

flag_0_1 = False
flag_1_0 = False
flag_1_1 = False


for line in f:

    line = line.strip('\n')

    if "map@1:" in line:
        map1 = line[7:]
        f1.write(map1 + " ")
        continue

    if "map@5:" in line:
        map1 = line[7:]
        f1.write(map1 + " ")
        continue

    if "map@10:" in line:
        map1 = line[7:]
        f1.write(map1 + "\n")
        continue

    if "alpha_value:" in line:
        index = line.index(" ",13)
        alpha = line[13:index]
        f1.write(alpha + " ")


f1.close()
f.close()


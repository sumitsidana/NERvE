import sys

f = open('/data/sidana/recnet_draft/param_tune/'+sys.argv[1]+'/recnet/results', 'r')


flag_0_1 = False
flag_1_0 = False
flag_1_1 = False

map_01_1 = 0.0
map_01_5 = 0.0
map_01_10 = 0.0

map_10_1 = 0.0
map_10_5 = 0.0
map_10_10 = 0.0

map_11_1 = 0.0
map_11_5 = 0.0
map_11_10 = 0.0

param_line = ""

param_01_1 = ""
param_01_5 = ""
param_01_10 = ""

param_10_1 = ""
param_10_5 = ""
param_10_10 = ""

param_11_1 = ""
param_11_5 = ""
param_11_10 = ""


for line in f:

    line = line.strip('\n')
    if "Latent Factor" in line:
        param_line = line

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

    if line[0:5] == "map@1" or line[0:5]== "map@5" or line[0:6]=="map@10":
        line_value = float(line[7:])
        if line[0:6]=="map@10":
            print(line[7:])

    if flag_0_1:
        if "map@1" in line:
            if line_value > map_01_1:
                param_01_1 = param_line
                map_01_1 = line_value
            continue
        if "map@5" in line:
            if line_value > map_01_5:
                param_01_5 = param_line
                map_01_5 = line_value
            continue
        if "map@10" in line:
            if line_value > map_01_10:
                param_01_10 = param_line
                map_01_10 = line_value
            continue

    if flag_1_0:
        if "map@1" in line:
            if line_value > map_10_1:
                param_10_1 = param_line
                map_10_1 = line_value
            continue
        if "map@5" in line:
            if line_value > map_10_5:
                param_10_5 = param_line
                map_10_5 = line_value
            continue
        if "map@10" in line:
            if line_value > map_10_10:
                param_10_10 = param_line
                map_10_10 = line_value
            continue

    if flag_1_1:
        if "map@1" in line:
            if line_value > map_11_1:
                param_11_1 = param_line
                map_11_1 = line_value
            continue
        if "map@5" in line:
            if line_value > map_11_5:
                param_11_5 = param_line
                map_11_5 = line_value
            continue
        if "map@10" in line:
            if line_value > map_11_10:
                param_11_10 = param_line
                map_11_10 = line_value
            continue

print('map_01_1: '+ str(map_01_1)+' for parameters:'+str(param_01_1))
print('map_01_5: ' + str(map_01_5)+' for parameters:'+str(param_01_5))
print('map_01_10:'+ str(map_01_10)+' for parameters:'+str(param_01_10))
print('map_10_1: ' + str(map_10_1)+' for parameters:'+str(param_10_1))
print('map_10_5: ' + str(map_10_5)+' for parameters:'+str(param_10_5))
print('map_10_10:'+str(map_10_10)+' for parameters:'+str(param_10_10))
print('map_11_1: '+str(map_11_1)+' for parameters:'+str(param_11_1))
print('map_11_5: '+str(map_11_5)+' for parameters:'+str(param_11_5))
print('map_11_10:'+str(map_11_10)+' for parameters:'+str(param_11_10))
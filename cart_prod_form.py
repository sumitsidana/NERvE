import pandas as pd
import numpy as np
import sys

df = pd.read_csv('/data/sidana/recnet_draft/'+sys.argv[1]+'/recnet_all/train_all_raw.csv',sep=',',header=0)

users = set(df['userId'])
users = list(users)
items_all = set(df['movieId'])
items_all = list(items_all)
user_item_dict = {}
new_df_data = []
ts = 1

for user in users:
    
    df_user  = df[df['userId']==user].sort_values(by='timestamp')#subdataset for each user, sorted by timestamp
    click = df_user['rating']
    click = list(click)
    it_for_u = df_user['movieId']
    it_for_u = list(it_for_u)
    clicks = []
    
    for i in click:
        if (i >= 4):
            clicks = clicks + [1]
        else:
            clicks = clicks + [0]
    
    for n in range(len(clicks)):#saving all negative for each user for the next training        
        if (clicks[n] == 1):
            user_item_dict[(user,it_for_u[n])] = 1

    for item in items_all:
        if (user, item) in user_item_dict:
            new_df_data.append([user,item,4,ts])
        else:
            new_df_data.append([user,item,1,ts])
        ts += 1                   
        
                        
df2 = pd.DataFrame(new_df_data,columns=['userId', 'movieId', 'rating', 'timestamp'])
df2.to_csv('/data/sidana/recnet_draft/'+sys.argv[1]+'/recnet_all/train_all_cart_raw.csv', index = False)
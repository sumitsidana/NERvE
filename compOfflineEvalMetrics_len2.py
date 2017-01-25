
# coding: utf-8

# In[36]:

import numpy as np
import rank_metrics
import sys
relevanceVector = np.loadtxt(open(sys.argv[1]+"/rv/relevenceVector_"+sys.argv[2]),delimiter = " ")
f = open(sys.argv[1]+'/em/evalMetrics_'+sys.argv[2],'w')
for k in range(1,11):
    total_precision_k = 0
    total_dcg_k = 0
    total_ndcg_k = 0
    for row in relevanceVector:
        precision_k = rank_metrics.precision_at_k(row,k)
        dcg_k = rank_metrics.dcg_at_k(row,k,0)
        ndcg_k = rank_metrics.ndcg_at_k(row,k,0)
        total_precision_k = total_precision_k + precision_k
        total_dcg_k = total_dcg_k + dcg_k
        total_ndcg_k = total_ndcg_k + ndcg_k
    f.write("precision@"+str(k)+": "+str(total_precision_k)+"\n")
    f.write("dcg@"+str(k)+": "+str(total_dcg_k)+"\n")
    f.write("ndcg@"+str(k)+": "+str(total_ndcg_k)+"\n")
        
mrr = rank_metrics.mean_reciprocal_rank(relevanceVector)
f.write("Mean Reciprocal Rank: "+str(mrr)+"\n")
maP = rank_metrics.mean_average_precision(relevanceVector)
f.write("Mean Average Precision: "+ str(maP)+"\n")
f.close()


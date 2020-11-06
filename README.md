
# Representation Learning and Pairwise Ranking for Implicit Feedback in Recommendation Systems

This repository contains the code for "Representation Learning and Pairwise Ranking for Implicit Feedback in Recommendation Systems". Read the paper [here](https://arxiv.org/abs/1705.00105) 

# Authors
[Sumit Sidana](https://github.com/sumitsidana)

[Mikhail Trofimov](https://github.com/geffy)

[Oleg.Gorodnitskii](https://faculty.skoltech.ru/people/yurymaximov)

[Charlotte Laclau](https://laclauc.github.io/)

[Massih-Reza Amini](http://ama.liglab.fr/~amini/)

# Models

This repository uses:

- Tensorflow
- A neural network Model which combines pairwise ranking loss and embedding based loss

# Dataset
- Movielens-100k
- Movielens-1M
- [KASANDR](https://archive.ics.uci.edu/ml/datasets/KASANDR)
- Netflix

*How To Run

To install cachedrandom module -- use `make_ext.sh`

This repository contains the code for "Representation Learning and Pairwise Ranking for Implicit Feedback in Recommendation Systems". Read the paper here: https://arxiv.org/abs/1705.00105

The main file which executes nerve is nerve.py for "interacted offers" setting and nerve_all.py for "all offers" setting.

compared_approaches contains all the other approaches.

bash_scripts contains all the automation scripts.

evaluation contains all the evaluation (mean average precision) scripts.

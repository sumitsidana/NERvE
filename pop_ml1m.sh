# recnet_draft: Popularity
# :yy 1,749p
#paste -d' ' test.users mostpopularitems.txt > vectors/pr_ml1m
bash ./writerelevancevectorpop.sh ml1m one
bash ./writerelevancevectorpop.sh ml1m five
bash ./writerelevancevectorpop.sh ml1m ten

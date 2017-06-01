# recnet_draft: Popularity
# :yy 1,749p
#paste -d' ' test.users mostpopularitems.txt > vectors/pr_ml100k
bash ./writerelevancevectorpop.sh ml100k one
bash ./writerelevancevectorpop.sh ml100k five
bash ./writerelevancevectorpop.sh ml100k ten

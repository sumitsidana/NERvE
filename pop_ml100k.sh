# recnet_draft: Popularity
# :yy 1,749p
paste -d' ' test.users mostpopularitems.txt > vectors/pr_ml100k
bash ./writerelevancevectorpi.sh ml100k one
bash ./writerelevancevectorpi.sh ml100k five
bash ./writerelevancevectorpi.sh ml100k ten

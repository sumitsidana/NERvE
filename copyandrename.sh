DIRECTORY=./scala/src/main/scala/

for file in $DIRECTORY/*ml1m*; do
    cp "$file" "${file/ml1m/ml100k}"
done

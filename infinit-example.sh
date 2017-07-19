#!/bin/bash

counter=0
while true #run indefinitely
do
    counter=$((counter+1))
    echo
    echo "$counter. Waiting for source changes... (press enter to interrupt)"
    inotifywait -r -e modify,attrib,move,delete --exclude \.swp -q ${1}
    pushd dataflow-generator/build > /dev/null
    make -j8 && ./bin/dataflow ../test/struct/test.bc -O0 -o test
    popd > /dev/null
done


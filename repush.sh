#!/bin/bash

head -1 /dev/random > newfile1
# echo "Safe push" > newfile1
git add newfile1
git commit -m "Commit"
git push

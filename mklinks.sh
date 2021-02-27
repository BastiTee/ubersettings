#!/bin/bash

files=$1
target="$2"

echo $files
echo "$target"

for file in $files; do
  mkdir -vp "${target}"
  rm -vf "${target}"/$file
  ln -vs $(pwd)/$file "${target}"/$file
done

#!/bin/bash
echo "Beginning Build..."
firstline=$(head -n 1 source/changelog.md)
read -a splitfirstline <<< $firstline
version=${splitfirstline[1]}
echo "Building version: $version"
echo "Are you sure you want to build? (1/0)"
read versioncontinue
if [ $versioncontinue == 1 ]
then
  if [ ! -e build/ ]
  then
    mkdir build/
  fi
  for filename in source/*
  do
    if [ $filename == "source/secretinfo.md" ]
    then
      echo "ERROR: Not copying file: $filename"
    else 
    
      echo "Copying file: $filename"
      cp $filename build/
    fi
  done
  cd build/
  echo "Build version $version contains:"
  ls
  cd ..
  zip -r build.zip build > log.txt
  rm -r build/
else
  echo "Please come back when you are ready"
fi
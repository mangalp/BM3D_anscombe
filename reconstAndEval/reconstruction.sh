#!/bin/bash

base=../19-08-2019/
dvstacksall=07-DVStacks/
modepath=Noisy/
modeall=Noisy/*
reconstructions=08-DVReconstructions/
readDir="$base$dvstacksall$modeall"
writeDir=$base$reconstructions

for file in $readDir; do
  echo "$base$dvstacksall$modepath${file##*/}"
  ./cudaSireconDriver "$base$dvstacksall$modepath${file##*/}" "$writeDir$modepath${file##*/}" 528.otf -c 528config 
done


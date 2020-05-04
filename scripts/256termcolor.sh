#!/usr/bin/bash
for i in {0..255} ; do
  if [ $((i % 8)) -eq 0 ]; then
    printf "\n"
  fi
  printf "\033[38;5;%dmcolour%03d " $i $i
done
printf "\n"

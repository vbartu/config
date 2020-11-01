#!/usr/bin/bash
for i in {0..255} ; do
  if [ $((i % 8)) -eq 0 ]; then
    printf "\n"
  fi
  printf "\033[38;5;%dmcolour\033[1m%03d\033[0m " $i $i
done
printf "\n"

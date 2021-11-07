if [[ $1 == "-e" ]]; then
	CMD="pacman -Qqe"
else
	CMD="pacman -Qq"
fi

for i in $($CMD)
do
  grep "\[ALPM\] installed $i" /var/log/pacman.log
done | \
  sort -u | \
  sed -e 's/\[ALPM\] installed //' -e 's/(.*$//'

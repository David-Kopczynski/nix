# Konsave theme
echo "Backup Konsave theme:"
konsave -s theme -f
konsave -e theme -f
mv -f theme.knsv modules/konsave/

# Prismatik profiles
echo "Backup Prismatik profiles"
cp ~/.Prismatik modules/lightpack/

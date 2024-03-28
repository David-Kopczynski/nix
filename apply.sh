# Konsave theme
echo "Apply Konsave theme"
konsave -i modules/konsave/theme.knsv
konsave -a theme

# Prismatik profiles
echo "Apply Prismatik profiles"
cp modules/lightpack/.Prismatik ~

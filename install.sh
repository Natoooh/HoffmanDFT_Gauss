#!/bin/bash

# define the stuff
DIR="$HOME/.local/bin"
USERNAME=$(whoami)
USERINIT=${USERNAME:0:1}
OGSTRING="\/u\/home\/h\/hootan\/.local\/bin\/submit_gaussian16_hootan.sh"
URSTRING="\/u\/home\/\$USERINIT\/\$USERNAME\/.local\/bin\/submit_gaussian16_hootan.sh"

#echo $USERNAME
#echo $USERINIT

mkdir -p "$DIR"
cd "$DIR"

# Get the Git and put files in the right place
git clone https://github.com/Natoooh/HoffmanDFT_Gauss
cd HoffmanDFT_Gauss
rm -rf .git
mv * ..

for file in *; do
  if [[ -f "$file" ]]; then
    sed -i "s/$OGSTRING/$URSTRING/g" "$file" # Replace the string
  fi
done

for file in *; do
	if [[ -f "$file" ]]; then
		dos2unix $file
	fi
done

cd $HOME

# Aliases
declare -A aliases=(
  ["qs"]="qstat -u \$USERNAME"
  ["gsub"]="/u/home/\$USERINIT/\$USERNAME/.local/bin/Submit-Gauss.sh"
	["gsubS"]="/u/home/\$USERINIT/\$USERNAME/.local/bin/Submit_Gauss-8.sh"
	["gsubL"]="/u/home/\$USERINIT/\$USERNAME/.local/bin/Submit_Gauss-24.sh"
	["gsubXL"]="/u/home/\$USERINIT/\$USERNAME/.local/bin/Submit_Gauss-32.sh"
	["grest"]="python3 /u/home/\$USERINIT/\$USERNAME/.local/bin/Gauss-Freq-Restart.py;echo"
	["fchk"]="/u/home/\$USERINIT/\$USERNAME/.local/bin/Fchk.sh"
)

for alias_name in "${!aliases[@]}"; do
  command=${aliases[$alias_name]}

  # Replace placeholders with actual values
  string_alias=$(echo "$command" | sed "s/\$USERNAME/$USERNAME/g" | sed "s/\$USERINIT/$USERINIT/g")
   echo "alias $alias_name='$string_alias'" >> ~/.bashrc
done

source ~/.bashrc


echo "Installation complete!"
echo "give appropiate permissions to the installed file if needed using 'chmod 777 [filename]'"
echo "qs : shows your job queue \n gsub : submits .com file at medium expense \n gsubS, gsubL, gsubXL increase or decrease computational expense \n grest : creates a new input file such that it can be resubmitted with the gsub commands"







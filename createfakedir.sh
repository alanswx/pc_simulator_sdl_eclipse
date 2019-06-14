#!/bin/bash
input="nes.txt"
while IFS= read -r line
do
   filename="${line##*/}"                      # Strip longest match of */ from start
   base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
   ext="${filename:${#base} + 1}"                  # Substring from len of base thru end
   if [ "${#ext}"  -eq "3" ]; then
      echo $ext
      mkdir -p -v  "$(dirname "NES/$line")" 
      echo  "$(dirname "NES/$line")" 
      touch "NES/${line}"
      echo "NES/${line}"
   fi
   #echo $filename
   #echo $ext
   #if ($EXTENSION) then
   #  echo $EXTENSION
   #fi
   #mkdir -p -v  "$(dirname "NES/$line")" 
   #echo  "$(dirname "NES/$line")" 
   #touch "NES/${line}"
   #echo "NES/${line}"
done < "$input"

exit

for fullpath in "$@"
do
    filename="${fullpath##*/}"                      # Strip longest match of */ from start
    dir="${fullpath:0:${#fullpath} - ${#filename}}" # Substring from 0 thru pos of filename
    base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
    ext="${filename:${#base} + 1}"                  # Substring from len of base thru end
    if [[ -z "$base" && -n "$ext" ]]; then          # If we have an extension and no base, it's really the base
        base=".$ext"
        ext=""
    fi

    echo -e "$fullpath:\n\tdir  = \"$dir\"\n\tbase = \"$base\"\n\text  = \"$ext\""
done

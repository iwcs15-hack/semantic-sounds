#
# every-pair.sh, 17 Apr 15

file="$1"
IFS=","

while read w1 w2 n1 n2 n3 n4; do
   echo -n "$w1,$w2,$n1,$n2,$n3,$n4,"
   echo "$w1 $w2" | ../../sounds/slike.0.1.3/slike -gen phon | ./levdist
   done < "$file"


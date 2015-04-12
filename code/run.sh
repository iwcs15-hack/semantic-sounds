# 4.5 hours on 8 CPUs
time python3 sem_sim.py > deb
# Seconds
awk -F, '{ if (NF == 3) print }' < deb > semantic.csv
# Minutes on 1 CPU
python3 join.py | sort --parallel=7 -t, -nk6 | tac > sorted.csv
head -1 header.csv sorted.csv | gzip -c > sorted.csv.gz

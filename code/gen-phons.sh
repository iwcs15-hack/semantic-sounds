# gen-phon.sh, 12 Apr 15
# Generate phoneme sequence for every word in a file
# slike is from: https://github.com/Derek-Jones/sounds-like

word-list.txt | slike -gen phon+ > phon-list.txt

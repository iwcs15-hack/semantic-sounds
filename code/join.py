from Levenshtein import jaro
from stemming.porter2 import stem
# load semantic similarity
semsim = [x.rstrip().lower().split(',') for x in open('semantic.csv').readlines()]
# load words and their phonemes
words = [x.rstrip() for x in open('fixed-words.txt').readlines()]
phonemes = [x.rstrip() for x in  open('fixed-words-phon.txt').readlines()]
word_phonemes = dict()
matched = dict()
# Map words to their phonemes
for i in range(len(words)):
  word_phonemes[words[i]] = phonemes[i]

print ("word1,word2,semantic_similarity,phonetic_similarity,word_similarity,sem_x_phon_similarity")
for triade in semsim:
  a = triade[0]
  b = triade[1]
  # ignore duplicated (b,a)
  dup = matched.get(b + "_" + a, None)
  if dup:
    continue
  matched[a + "_" + b] = True
  # ignore pairs with the same stem
  if (stem(a) == stem(b)):
    continue
  # Get their phonemes
  ph1 = word_phonemes.get(a, None)
  ph2 = word_phonemes.get(b, None)
  if ph1 is None or ph2 is None:
    continue
  # Semantic similarity
  ss = float(triade[2]) 
  # Phonetic similarity
  ps = jaro(ph1, ph2)
  # Word similarity
  ld = jaro(a,b) 
  print ("%s,%s,%.4f,%.4f,%.4f,%.4f" % (a,b, ss, ps, ld, ss*ps))

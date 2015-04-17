# plot.R, 17 Apr 15
# 'heatmap' of the output

wd=read.csv("sounds/150-phon-sem.csv")
str(wd)
# 'data.frame':	1959711 obs. of  6 variables:
#  $ word1                : Factor w/ 60622 levels "aardvark","aardvarks",..: 41795 2464 2465 41794 2466 30389 21080 14783 11840 22771 ...
#  $ word2                : Factor w/ 61619 levels "a","aaliyah",..: 42308 2471 2472 42307 2473 30572 21137 14682 11742 22754 ...
#  $ semantic_similarity  : num  0.92 0.926 0.911 0.881 0.902 ...
#  $ phonetic_similarity  : num  1 0.974 0.972 1 0.974 ...
#  $ word_similarity      : num  0.933 0.874 0.974 0.926 0.976 ...
#  $ sem_x_phon_similarity: num  0.92 0.902 0.886 0.881 0.879 ...
plot(wd$phonetic_similarity, wd$semantic_similarity)

smoothScatter(wd$phonetic_similarity, wd$word_similarity,
	xlab="Phonetic (Jaro-Winker)", ylab="Letter (Jaro-Winkler)")
smoothScatter(wd$phonetic_similarity, wd$semantic_similarity,
	xlab="Phonetic (Jaro-Winker)", ylab="Semantic (word co-occurrence)")
smoothScatter(wd$word_similarity, wd$semantic_similarity,
	xlab="Letter (Jaro-Winker)", ylab="Semantic (word co-occurrence)")


wbu=read.csv("sounds/150-phon-sem-BUS.csv")
# 'data.frame':   532025 obs. of  10 variables:
#  $ word1                : Factor w/ 28111 levels "aardvark","aback",..: 9761 6909 7769 5182 12117 1943 7754 1858 5955 15688 ...
#  $ word2                : Factor w/ 27758 levels "a","abacus","abaft",..: 9420 6555 27109 4870 14516 1811 19576 1736 5659 15197 ...
#  $ semantic_similarity  : num  0.917 0.861 0.96 0.833 0.91 ...
#  $ phonetic_similarity  : num  0.944 1 0.869 1 0.9 ...
#  $ word_similarity      : num  0.944 0.926 0.926 0.967 0.926 ...
#  $ sem_x_phon_similarity: num  0.866 0.861 0.835 0.833 0.819 ...
#  $ phon1                : Factor w/ 27707 levels "a","aAF","aBaaO",..: 10078 1481 12183 20924 12216 24237 20452 24292 21650 27013 ...
#  $ phon2                : Factor w/ 27387 levels "","a","A","aAF",..: 10162 1446 13253 20793 27125 23964 21974 24012 21499 26684 ...
#  $ levenshtein          : num  1 0 2 0 3 1 2 1 0 1 ...
#  $ norm_lev             : num  0.833 1 0.75 1 0.7 0.875 0.667 0.889 1 0.857 ...

smoothScatter(wbu$norm_lev, wbu$semantic_similarity,
	xlab="Phonetic (Normalised Levenshtein)", ylab="Semantic (word co-occurrence)")
smoothScatter(wbu$phonetic_similarity, wbu$semantic_similarity,
	xlab="Phonetic (Jaro-Winkler)", ylab="Semantic (word co-occurrence)")
smoothScatter(wbu$norm_lev, wbu$phonetic_similarity,
	xlab="Phonetic (Normalised Levenshtein)", ylab="Phonetic (Jaro-Winkler)")
smoothScatter(wbu$Levenshtein, wbu$semantic_similarity,
	xlab="Phonetic (Levenshtein)", ylab="Semantic (word co-occurrence)")
smoothScatter(wbu$word_similarity, wbu$semantic_similarity,
	xlab="Letter (Jaro-Winker)", ylab="Semantic (word co-occurrence)")
smoothScatter(wbu$phonetic_similarity, wbu$word_similarity,
	xlab="Phonetic (Jaro-Winker)", ylab="Letter (Jaro-Winkler)")

plot(table(wbu$norm_lev), log="y",
	ylim=c(1, 200000),
	xlab="Phonetic (Levenshtein)", ylab="Number of word pairs\n")

# dev.copy(device=png) ; dev.off()


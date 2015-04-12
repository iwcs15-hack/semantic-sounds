Given a list of words from Google news for which a 'semantic' distance was available
https://drive.google.com/file/d/0B7XkCwpI5KDYNlNUTTlSS21pQmM/edit?usp=sharing

Take the top most 150 semantically similar word pairs for each of the 70k words

Calculate phonetic similarity for each word pair (using https://github.com/Derek-Jones/sounds-like)

Removed all pairs where the two words had the same stem (used Porter stemming).

Output of just under 2 million word pairs (1959712).

[Pretty pictures](http://iwcs15-hack.github.io/semantic-sounds) and some
interesting word pairs.


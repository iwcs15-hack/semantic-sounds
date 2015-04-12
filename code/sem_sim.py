import csv
import time
from queue import Queue
from threading import Thread
from itertools import chain
import pandas as pd
import seaborn as sns
import sys 
from gensim.models.word2vec import Word2Vec
from sklearn.metrics.pairwise import cosine_similarity 
# Load GoogleNews corpus
model = Word2Vec.load_word2vec_format('GoogleNews-vectors-negative300.bin', binary=True)
# Load words
most_common_content_words = [x.rstrip() for x in open('fixed-words.txt').readlines()]
# Queue for results
ret_queue = Queue(maxsize=0)
# Return top 150 words semantically similar
limit_top = 150
def handle(w):
  # Triade of word1, word2, 0..1 semantic similarity
  ret = [(w, w2, score) for w2, score in model.most_similar(w, topn=limit_top)]
  return ret

# Get semantically similar words and put them to the result queue
def do_stuff(q):
  while True:
    word = q.get()
    try:
      ret = handle(word)
      for item in ret:
        ret_queue.put(item)
    except:
      pass
    finally:
      q.task_done()

# Queue for words to process
q = Queue(maxsize=0)
num_threads = 10
 
# Start 10 threads to handle words
for i in range(num_threads):
  worker = Thread(target=do_stuff, args=(q,))
  worker.setDaemon(True)
  worker.start()

# One thread to print results from ret_queue
def print_stuff(qq):
    i = 0
    while True:
      i = i+1
      if i % 20 == 0:
        print ('progress',time.time(), q.unfinished_tasks)
      item = qq.get()
      try:
        item = [str(x) for x in item]
        print (",".join(item))
      finally:
        qq.task_done()
printer = Thread(target=print_stuff, args=(ret_queue,))
printer.setDaemon(True)

# Put words onto the queue and wait for all results. For 71k words it takes 4.5 hours on 8 CPUs.
for word in most_common_content_words:
  q.put(word) 
printer.start()
q.join()
ret_queue.join()

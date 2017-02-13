#  File: extract_words.py

import fileinput
import re
from collections import Counter, defaultdict

word_dict = {}
word_lists = []

def main():
  frequency_analysis()
  all_words()
  unique_words()
  word_frequency()

def frequency_analysis():
  for line in fileinput.input():
    line = line.strip()
    line = line.lower() 
    word_list = re.findall("([a-z]+)", line)

    for word in word_list:
      word_lists.append(word)
      if word in word_dict:
        word_dict[word] += 1
      else:
        word_dict[word] = 1

  fileinput.input().close()

def unique_words():
  uniquewords = open("uniquewords.txt", "w")
  for i in word_dict:
    uniquewords.write(i+"\n")
  uniquewords.close()

def all_words():
  allwords = open("allwords.txt", "w")
  for i in word_lists:
    allwords.write(i+"\n")
  allwords.close()

def word_frequency():
  wordfrequency = open("wordfrequency.txt", "w")
  freqword = defaultdict(list)
  for word,freq in Counter(word_lists).items():
    freqword[freq].append(word)
  for freq in sorted(freqword):
    wordfrequency.write(str(freq)+": "+str(len(sorted(freqword[freq])))+"\n")
  wordfrequency.close()

main()
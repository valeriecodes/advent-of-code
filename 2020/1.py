from functools import reduce

f = open("day1input.txt", "r")
items = list(map(int, f.read().rstrip().split("\n")))

# Part 1
def find_result(items):
  result1 = None
  result2 = None
  for i in range(len(items) - 1):
    for j in range(i + 1, len(items)):
      if items[i] + items[j] == 2020:
        result1, result2 = items[i], items[j]
  return [result1, result2]

print(reduce((lambda x, y: x * y), find_result(items)))

# Part 2
def find_triple_result(items):
  result1 = None
  result2 = None
  result3 = None
  for i in range(len(items) - 2):
    for j in range(i + 1, len(items) - 1):
      for k in range(j + 1, len(items)):
        if items[i] + items[j] + items[k] == 2020:
          result1, result2, result3 = items[i], items[j], items[k]
  return [result1, result2, result3]

print(reduce((lambda x, y: x * y), find_triple_result(items)))

import re
text = "The quick brown fox"
pattern = r"brown"

search = re.search(pattern,text)
if search:
    print("Pattern found",search.group())
else:
    print("pattern not found")


#output:Pattern found brown
          
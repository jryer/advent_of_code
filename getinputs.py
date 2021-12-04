import requests
import os
from datetime import date
import browser_cookie3
import sys

#Get cookies from the browser
cj = browser_cookie3.firefox()

year = str(sys.argv[1])
day = str(sys.argv[2])


path = f"https://adventofcode.com/{year}/day/{day}/input"
print(f"Initializing day {day}")

os.chdir(year)
if not os.path.exists(day):
    os.mkdir(day)

os.chdir(day)

print("Getting inputs")
print(path)
r = requests.get(path, cookies = cj)
with open(f"input","w") as f:
    f.write(r.text)

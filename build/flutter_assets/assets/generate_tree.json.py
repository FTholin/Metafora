import glob
import json

items = glob.glob("styles/*.*")
pictures = glob.glob("styles/**/*.*")
levels = glob.glob("levels/*.*")


jsonFile = {}
jsonFile["items"] = []
jsonFile["pictures"] = []
jsonFile["levels"] = []

for item in items:
    print(item)
    item = item.replace("styles\\", 'assets/styles/')
    jsonFile["items"].append(item.replace('\\', '/'))

for picture in pictures:
    print(picture)
    picture = picture.replace("styles\\", 'assets/styles/')
    jsonFile["pictures"].append(picture.replace('\\', '/'))

for level in levels:
    print(level)
    level = level.replace("levels\\", 'assets/levels/')
    jsonFile["levels"].append(level.replace('\\', '/'))

res = json.dumps(jsonFile, indent=4)
print(res)

with open("tree.json", 'w') as outfile:
    outfile.write(res)

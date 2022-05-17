# Strange Attractor Tools written with Swift

create image with algorithm 'Strange Attractor' (2D)

## Usage

create image
```
swift run StrangeAttractor image ~/tmp/a.json -o ~/Downloads/a.png
```

with iterations count.
```
swift run StrangeAttractor image ~/tmp/a.json -N 100000 -o ~/Downloads/a.png
```

with image size.
```
swift run StrangeAttractor image ~/tmp/a.json -w 480 -h 360 -o ~/Downloads/a.png
```

with high density
```
swift run StrangeAttractor image ~/tmp/a.json -d 8 -o ~/Downloads/a.png
```

export as csv (for spreadsheet)
```
swift run StrangeAttractor export ~/tmp/a.json -o ~/tmp/a.csv
```

random search
```
swift run StrangeAttractor search PeterDeJong -o ~/tmp/random.json
```

mutation search and save to file
```
swift run StrangeAttractor mutation ~/tmp/base.json -o ~/tmp/mutation.json
```

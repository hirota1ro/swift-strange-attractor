# Strange Attractor Tools written with Swift

create image with algorithm 'Strange Attractor' (2D)

<p>
  <img width="512" alt="Clifford(a=1 70,b=1 70,c=0 60,d=1 20)" src="https://user-images.githubusercontent.com/45020018/168707907-61903aeb-b7ef-4fac-8434-00f50cdaa795.png">
  <img width="512" alt="PeterDeJong(a=2 01,b=-2 53,c=1 61,d=-0 33)" src="https://user-images.githubusercontent.com/45020018/168708015-84dec0bc-216d-42ff-8d80-c3cf73da1042.png">
  <img width="512" alt="GumowskiMira((F,G)=(2,1),α=0 01,σ=0 05,μ=-0 50)" src="https://user-images.githubusercontent.com/45020018/168708082-94b14e34-e9cc-4f37-b254-2781dd01123d.png">
  <img width="512" alt="Tinkerbell(a=0 90,b=-0 60,c=2 00,d=0 50,x0=-0 72,y0=-0 64)" src="https://user-images.githubusercontent.com/45020018/168708127-d0bdde20-8bf2-40b3-8142-808ea11b8dbf.png">
</p>

## Usage

create image
```
StrangeAttractor image ~/tmp/a.json -o ~/Downloads/a.png
```

with iterations count.
```
StrangeAttractor image ~/tmp/a.json -N 100000 -o ~/Downloads/a.png
```

with image size.
```
StrangeAttractor image ~/tmp/a.json -w 480 -h 360 -o ~/Downloads/a.png
```

with high density
```
StrangeAttractor image ~/tmp/a.json -d 8 -o ~/Downloads/a.png
```

export as csv (for spreadsheet)
```
StrangeAttractor export ~/tmp/a.json -o ~/tmp/a.csv
```

random search
```
StrangeAttractor search PeterDeJong -o ~/tmp/random.json
```

mutation search and save to file
```
StrangeAttractor mutation ~/tmp/base.json -o ~/tmp/mutation.json
```

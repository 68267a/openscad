import os
from PIL import Image

DPI = 300 # dots per inch. 300 default
LPI = 60 #lines per inch, taken from the lens design

# Conversions
# length[mm] = pixel * 25.4mm (1 in) / dpi
# pixel = dpi * mm / 25.4 mm (1 in)
# dpi = pixel * 25.4 mm (1 in) / mm
i2cm = 25.4 #inch to cm
DP2cm = DPI / i2cm
LPcm = LPI / i2cm #lines per cm
# stripwidth = LPcm
stripwidth = 10

ima = Image.open(r"batman.png")
imb = Image.open(r"darthvader.png")
outfile = 'batvader_' + str(stripwidth) + '.png'

os.chdir(os.path.dirname(os.path.abspath(__file__)))
# imb = ima.transpose(method=Image.FLIP_LEFT_RIGHT)
# imb.save('colorsflipped.png')
width, height = ima.size
# 60 LPI
# 300 PPI
numstrips = round(width/stripwidth)

print("width" + str(width)+ " stripwidth" + str(stripwidth))
strip = 0
h = height
x = 0
y = stripwidth

imgOut = Image.new("RGB", (width, height), "black")
while strip < numstrips:
	print("strip" + str(strip) + " x" + str(x) + " y" + str(y))
	strip += 1
	strip_a = ima.crop((x,0,y,h))
	strip_b = imb.crop((x,0,y,h))
	imgOut.paste(strip_a,(x,0))
	imgOut.paste(strip_b,(x+stripwidth,0))
	x=x+stripwidth+stripwidth
	y=y+stripwidth+stripwidth


imgOut.save(outfile)
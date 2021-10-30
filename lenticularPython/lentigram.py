import os
from PIL import Image

numstrips = 8
os.chdir(os.path.dirname(os.path.abspath(__file__)))
ima = Image.open(r"colors.png")
imb = ima.transpose(method=Image.FLIP_LEFT_RIGHT)
width, height = ima.size
left = 0
top = 0
right = round(width/numstrips)
bottom = height

strip = 0

while strip < numstrips:
	print("strip")


	strip += 1




ima0 = ima.crop((left,top,right,bottom))


# imgOut = Image.new("RGB", (width*2, height), "black")
# imgOut.paste(ima0, (0,0))
# imgOut.paste(ima1, (right,0))
# imgOut.show()
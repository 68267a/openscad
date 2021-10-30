import os
from PIL import Image

os.chdir(os.path.dirname(os.path.abspath(__file__)))
strips = 8

# im1 = Image.open(r"batman.png")
# im2 = Image.open(r"darthvader.png")

ima = Image.open(r"colors.png")
width, height = ima.size
left = 0
top = 0
right = width/strips
bottom = height

ima0 = ima.crop((left,top,right,bottom))
ima1 = ima0.transpose(method=Image.FLIP_LEFT_RIGHT)
print(right)

# ima.show()
# ima0.show()
# im_flipped.show()

imgOut = Image.new("RGB", (width*2, height), "black")
imgOut.paste(ima0, (0,0))
imgOut.paste(ima1, (44,0))
imgOut.show()
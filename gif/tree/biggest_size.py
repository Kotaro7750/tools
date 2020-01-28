#coding:utf-8
from PIL import Image
import os

maxW = 0
maxH = 0

filelist = os.listdir(".")

for f in filelist:
    _,aug = os.path.splitext(f)
    if aug == ".png":
        im = Image.open(f)
        rgb_im = im.convert('RGB')
        size = rgb_im.size

        if size[0] > maxW:
            maxW = size[0]

        if size[1] > maxH:
            maxH = size[1]

print("{},{}".format(maxW,maxH))

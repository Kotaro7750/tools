#coding:utf-8
from PIL import Image
import sys

args = sys.argv

if len(args) < 2:
    print("python3 seach_root.py filename")
    exit(0)

filename = args[1]

im = Image.open(filename)

#RGBに変換
rgb_im = im.convert('RGB')

size = rgb_im.size

for h in range(size[1]):
    for w in range(size[0]):
        r,g,b = rgb_im.getpixel((w,h))
        if r==0 and g==0 and b==0:
            print("{},{}".format(w,h))
            exit(0)


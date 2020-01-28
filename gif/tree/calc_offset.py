#coding:utf-8
from PIL import Image
import sys
import os

def search_root(rgb_im,size):
    for h in range(size[1]):
        for w in range(size[0]):
            r,g,b = rgb_im.getpixel((w,h))
            if r==0 and g==0 and b==0:
                return w,h

def searchLeft(rgb_im,size):
    for w in range(size[0]):
        for h in range(size[1]):
            r,g,b = rgb_im.getpixel((w,h))
            if r==0 and g==0 and b==0:
                return w,h
    

maxOffset = 0

ret_w=0
ret_h=0

filelist = os.listdir(".")

for f in filelist:
    _,aug = os.path.splitext(f)
    if aug == ".png":
        im = Image.open(f)
        rgb_im = im.convert('RGB')
        size = rgb_im.size

        w,h = searchLeft(rgb_im,size)
        root_w,root_h = search_root(rgb_im,size)

        if root_w - w > maxOffset:
            ret_w = root_w
            ret_h = root_h
            maxOffset = root_w - w


print("{},{}".format(ret_w,ret_h))



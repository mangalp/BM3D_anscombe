import os
import sys
import argparse
import glob
from tifffile import imread, imwrite
import numpy as np
import os


parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--input", help="path to input data", default='./*.tif')
parser.add_argument("--name", help="name", default='./*.tif')

args = parser.parse_args()

stack=imread(str(args.input))

for i in range(30,100,10):
    out=np.mean(stack[:i,...],axis=0)
    outPath=args.name+'-avg'+str(i)
    print(stack[:i,...].shape, out.shape, outPath)
    os.system('mkdir '+ outPath)
    imwrite(outPath+'/'+args.input.replace('.tif','_avg'+str(i)+'.tif'), out)

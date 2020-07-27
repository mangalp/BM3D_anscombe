import os
import sys
import argparse
import glob
from tifffile import imread, imsave
import numpy as np

parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--path", help="path to data", default='./')
parser.add_argument("--num_orientations", help="the number of orientations to split", default=5, type=int)

args = parser.parse_args()
print(args)

path = str(args.path)
orientations = int(args.num_orientations)

# creating directories
os.system('mkdir '+path+'orientations')
for i in range(orientations):
    os.system('mkdir '+path+'orientations/o'+str(i))


files = glob.glob(path+"/*.tif")

for f in files:
    img= imread(f)
    #img.shape=(img.size//(img.shape[-1]*img.shape[-2]),img.shape[-2],img.shape[-1] )
    osize=img.shape[1]//orientations
    for i in range(orientations):
        string="_o"+str(i)
        imgo=img[:,i*osize:(i+1)*osize,...]
        if len(imgo.shape)==len(img.shape):
            print(imgo.shape, (imgo.size//(imgo.shape[-1]*imgo.shape[-2]),imgo.shape[-2],imgo.shape[-1] ))
            #imgo=np.reshape(imgo,( imgo.size//(imgo.shape[-1]*imgo.shape[-2]),imgo.shape[-2],imgo.shape[-1] ) )
        fname=os.path.basename(f)
        nameo=path+"orientations/o" + str(i) + "/" + fname.replace('.tif',string+'.tif')
        print(nameo)
        imsave(nameo, imgo,imagej=True)








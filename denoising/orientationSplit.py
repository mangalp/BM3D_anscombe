import os
import sys
import argparse
import glob
from tifffile import imread, imwrite
import numpy as np

parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--path", help="path to data", default='./')
parser.add_argument("--num_orientations", help="the number of orientations to split", default=3, type=int)
parser.add_argument("--axis", help="axis that contains orientations", default=0, type=int)
parser.add_argument("--modulo", action='store_true', help="use modulo instead of devision to split orientations")


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
    img=np.swapaxes(img,0,int(args.axis))
    osize=img.shape[0]//orientations
    for i in range(orientations):
        string="_o"+str(i)
        if args.modulo:
            imgo=img[i::osize,...]
        else:
            imgo=img[i*osize:(i+1)*osize,...]
        if len(imgo.shape)==len(img.shape):
            imgo=np.swapaxes(imgo,0,int(args.axis))
            print(imgo.shape, (imgo.size//(imgo.shape[-1]*imgo.shape[-2]),imgo.shape[-2],imgo.shape[-1] ))
            #imgo=np.reshape(imgo,( imgo.size//(imgo.shape[-1]*imgo.shape[-2]),imgo.shape[-2],imgo.shape[-1] ) )
        fname=os.path.basename(f)
        nameo=path+"orientations/o" + str(i) + "/" + fname.replace('.tif',string+'.tif')
        print(nameo)
        imwrite(nameo, imgo)








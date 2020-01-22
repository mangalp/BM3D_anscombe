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
os.system('mkdir '+path+'join')

files = glob.glob(path+"o0/*.tif")

for f in files:
    #img.shape=(img.size//(img.shape[-1]*img.shape[-2]),img.shape[-2],img.shape[-1] )
    imgo=None
    for i in range(orientations):
        string="o"+str(i)
        fname=f.replace('o0.tif',string+'.tif').replace( path+"o0/",path+string+'/' )
        print(fname)
        img= imread(fname)
        img=np.swapaxes(img,0,int(args.axis))
        osize=img.shape[0]
        if imgo is None:
            if len(img.shape) == 2:
                shape=(orientations,img.shape[0],img.shape[1])
            if len(img.shape) == 3:
                shape=(img.shape[0]*orientations,img.shape[1],img.shape[2])
            if len(img.shape) == 4:
                shape=(img.shape[0]*orientations,img.shape[1],img.shape[2],img.shape[3])
            if len(img.shape) == 5:
                shape=(img.shape[0]*orientations,img.shape[1],img.shape[2],img.shape[3], img.shape[3])

            imgo=np.zeros(shape)

        if args.modulo:
            imgo[i::osize,...]=img
        else:
            imgo[i*osize:(i+1)*osize,...]=img

        if len(imgo.shape)==len(img.shape):
            imgo=np.swapaxes(imgo,0,int(args.axis))
            print(imgo.shape, (imgo.size//(imgo.shape[-1]*imgo.shape[-2]),imgo.shape[-2],imgo.shape[-1] ))
            #imgo=np.reshape(imgo,( imgo.size//(imgo.shape[-1]*imgo.shape[-2]),imgo.shape[-2],imgo.shape[-1] ) )
        fname=os.path.basename(f)
        nameo=path+"join/" + fname.replace('_o0.tif','_join.tif')
        print(nameo)
        imwrite(nameo, imgo)








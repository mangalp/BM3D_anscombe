import os
import sys
import argparse
import glob
from tifffile import imread, imwrite
import numpy as np


def PSNR(gt, pred, range_= None ):
    if range_ is None:
        range_ = np.max(gt)-np.min(gt)
    mse = np.mean((gt - pred)**2)
    return 20 * np.log10((range_)/np.sqrt(mse))

def zero_mean(x):
    return x-np.mean(x)

def fix_range(gt,x):
    a = np.sum(gt*x) / (np.sum(x*x) )
    return x*a

def fix(gt,x):
    gt_=zero_mean(gt)
    return fix_range(gt_, zero_mean(x)  )

def bestPsnr(gt,pred):
    ra=(np.max(gt)-np.min(gt))/np.std(gt)
    #ra=(np.max(gt)-np.min(gt))/np.std(gt)
    gt_=zero_mean(gt)/np.std(gt)
    return PSNR(zero_mean(gt_), fix(gt_,pred),ra)

parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--input", help="path to input data", default='./*.tif')
parser.add_argument("--gt", help="path to ground truth data", default='./*.tif')

args = parser.parse_args()

inputFiles=sorted(glob.glob(str(args.input)))
gtFiles=sorted(glob.glob(str(args.gt)))



for i in range(len(inputFiles) ):
    iname=inputFiles[i]
    gtname=gtFiles[i%len(gtFiles)]
    if iname == gtname:
        continue
    imgIn=imread(iname)
    imgGT=imread(gtname)
    print(PSNR(imgGT,imgIn), bestPsnr(imgGT,imgIn), inputFiles[i])

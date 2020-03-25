import os
import sys
import argparse
import glob
from tifffile import imread, imwrite
import numpy as np
from skimage.metrics import structural_similarity as ssim
import os

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

def bestSSIM(gt,pred):
    ra=(np.max(gt)-np.min(gt))/np.std(gt)
    #ra=(np.max(gt)-np.min(gt))/np.std(gt)
    gt_=zero_mean(gt)/np.std(gt)
    return ssim(zero_mean(gt_), fix(gt_,pred),range=np.max(gt_) - np.min(gt_))

def bestShiftPsnr(gt,pred):
    result=0
    gt_=gt[1:-1,1:-1]
    sa=gt.shape[0]
    sb=gt.shape[1]
    for a in range(3):
        for b in range(3):
            pred_=pred[2-a:sa-a,2-b:sb-b]
            result=max(result,bestPsnr(gt_,pred_))
    return result

parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--input", help="path to input data", default='./*.tif')
parser.add_argument("--gt", help="path to ground truth data", default='./*.tif')

args = parser.parse_args()

inputFiles=sorted(glob.glob(str(args.input)))
gtFiles=sorted(glob.glob(str(args.gt)))


print("PSNR\t cPSNR\t csPSNR\t SSIM\t filename")
for i in range(len(inputFiles) ):
    iname=inputFiles[i]
    gtname=gtFiles[i%len(gtFiles)]
    if iname == gtname:
        continue
    imgIn=imread(iname)
    imgGT=imread(gtname)
    ssim_val = ssim(imgGT, imgIn, data_range=np.max(imgGT) - np.min(imgGT))
    best_ssim_val = bestSSIM(imgGT, imgIn)
    print(round(PSNR(imgGT,imgIn),2), "\t",
          round(bestPsnr(imgGT,imgIn),2),
          "\t",round(bestShiftPsnr(imgGT,imgIn),2),
          "\t",round(ssim_val,3),
    #      "\t",round(best_ssim_val,3),"\t" ,
          "\t",os.path.basename(inputFiles[i]) )

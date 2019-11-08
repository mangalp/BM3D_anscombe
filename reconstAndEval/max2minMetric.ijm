basepath = "/Users/prakash/Desktop/N2V-SimSim/19-08-2019/";
scheme = "Noisy" // schemes can be "GT", "N2V", "N4V", "PN2V", "Noisy" depending on what sort of data is the result being computed for
input = basepath+ "08-DVReconstructions/"+scheme+"/";
output = basepath+"09-TifReconstructions/"+scheme+"/";
resultpath = basepath+"10-Results/"+scheme+"/";
print(input);

tileList = getFileList(input);
for (i = 0; i <tileList.length; i++)
        preprocessing(input, output, tileList[i]);
selectWindow("Log");
saveAs("Text", resultpath+"max2minMetricLog.txt");
wait(1000);
run("Close");
          
function preprocessing(input, output, filename) {
	run("Bio-Formats Importer", "open=[" + input+filename  + "] color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	run("Intensity Histogram", "specify_manual_noise_cut-off... channel=0");
	selectWindow(filename);
	saveAs("Tiff", output+filename+".tif");
	wait(1000);
    close();
    run("Close");

}
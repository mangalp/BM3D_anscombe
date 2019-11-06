clc
clear all
close all


addpath('bfmatlab')
addpath('DV')

%%%%%%%%%
%Set Date and OutputPath
%%%%%%%%%

projectDate='../19-08-2019/';
path=strcat(projectDate,'03-FlippedNoisyData/');
outputPath=strcat(projectDate,'07-DVStacks/');
filter='Noisy/'; % Use: 'N2V/', 'N4V/', 'PN2V/', 'Noisy/'

%%%%%%%%%
%CORE
%%%%%%%%%
if(filter=="Noisy/")
    fileList = dir(fullfile(path, '*.tif'));
else
    fileList = dir(fullfile(strcat(path,filter), '*.tif'));
end

for i =1:length(fileList)
    filepath=fileList(i).name;
    if(filter=="Noisy/")
        Data = bfOpen3DVolume(strcat(path, filepath));
    else
        Data = bfOpen3DVolume(strcat(path, filter, filepath));
    end
        imgStack=Data{1,1}{1,1};
    hdr = struct('dx',0.08,'dy',0.08,'dz',0.125,'wv1',528);
    writeDV(imgStack, strrep(strcat(outputPath, filter, filepath), '.tif','.dv'), hdr);
end


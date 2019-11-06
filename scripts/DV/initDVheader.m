function hdr = initDVheader(arr,order)
% create empty metadata struct for file format. 
% this metadata struct can be written to file with writeDV
% http://msg.ucsf.edu/IVE/IVE4_HTML/priism_mrc_header.html

if nargin < 1 
    arr = [];
end;

if nargin < 2
    order = 'yxzwt';
end
order = lower(order); 
xo = strfind(order,'x');
yo = strfind(order,'y');
zo = strfind(order,'z');
wo = strfind(order,'w');
to = strfind(order,'t');
arr = permute(arr,[xo yo zo wo to]);

    
hdr.ntst = 0;
hdr.blank = zeros(24,1, 'int32');
hdr.nTitles = 0;
hdr.titles = cell(10,1);
hdr.nx = size(arr,1);
hdr.ny = size(arr,2);
hdr.nz = size(arr,3)*size(arr,4)*size(arr,5);
hdr.pixelType = matlab2dvpixeltype(class(arr)) ;
hdr.mxst = 0;
hdr.myst = 0;
hdr.mzst = 0;
hdr.mx = 1;
hdr.my = 1;
hdr.mz = 1;
hdr.dx = 1;
hdr.dy = 1;
hdr.dz = 1;
hdr.alpha = 90;
hdr.beta = 90;
hdr.gamma = 90;
hdr.colax = 1;
hdr.rowax = 2;
hdr.sectax = 3;
hdr.min = 0;
hdr.max = 0;
hdr.mean = 0;
if ~isempty(arr)
    a = arr(:,:,:,1,:);
    hdr.min = min(a(:));
    hdr.max = max(a(:));
    hdr.mean = mean(a(:));
end
hdr.nspg = 0;
hdr.next = 0;
hdr.dvid = -16224;
hdr.nblank = 0;
hdr.numInts = 8;
hdr.numFloats = 32;
hdr.sub = 0;
hdr.zfac = 0;
if size(arr,4)>1
    a = arr(:,:,:,2,:);
    hdr.min2 = min(a(:));
    hdr.max2 = max(a(:));
end
if size(arr,4)>2
    a = arr(:,:,:,3,:);
    hdr.min3 = min(a(:));
    hdr.max3 = max(a(:));
end
if size(arr,4)>3
    a = arr(:,:,:,4,:);
    hdr.min4 = min(a(:));
    hdr.max4 = max(a(:));
end
if size(arr,4)>4
    a = arr(:,:,:,5,:);
    hdr.min5 = min(a(:));
    hdr.max5 = max(a(:));
end

hdr.imType = 100; 
hdr.lensNum = 10612;
hdr.n1 = 0;
hdr.n2 = 0;
hdr.v1 = 0;
hdr.v2 = 0;
hdr.ntime = size(arr,5);
hdr.imSeq = 0;
hdr.xtilt = 0;
hdr.ytilt = 0;
hdr.ztilt = 0;
hdr.nwaves = size(arr,4);
hdr.wv1 = 0;
hdr.wv2 = 0;
hdr.wv3 = 0;
hdr.wv4 = 0;
hdr.wv5 = 0;
hdr.zorig = 0;
hdr.xorig = 0;
hdr.yorig = 0;
hdr.nslices = size(arr,3);
hdr.nextra = 0;
hdr.extended = struct();
hdr.extended.photosensor = 0;
hdr.extended.timeStamp = 0;
hdr.extended.xstage = 0;
hdr.extended.ystage = 0;
hdr.extended.zstage = 0;
hdr.extended.min = 0;
hdr.extended.max = 0;
hdr.extended.mean = 0;
hdr.extended.expTime = 0;
hdr.extended.ndFilter = 0;
hdr.extended.exwave = 0;
hdr.extended.emwave = 0;
hdr.extended.intenScaling = 0;
hdr.extended.energyConvFactor = 0;


end

function handle=writeDVheaderBAK(arr,filename,dx,dz,wv1,nim)
% function handle=writeDVheader(arr,filename,dx,dz,wv1,nim)
% Write out the header of an DV/NMRC file, and leave the file open,
% returning the file handle, so that data can be written sequentially into
% the file and then the file closed.  Data are written in little-endian style,
% as float32 values.
% If you want to write more images than are contained in map, give the
% number in the optional nim argument.
%
% Example: write out 10,000 images.
%     images=randn(64,64,1000);
%     f=writeDVheader(images,2.8,'test.mrc',10000);
%     fwrite(f,images,'float32');
%     for i=2:10
%         images=randn(64,64,1000);
%         fwrite(f,images,'float32');
%     end;
%     fclose(f);

% could be used as arguments
numInts=8; % number of 4 byte integers stored in the extended header per section.
numFloats=32; % number of 4 byte floating-point numbers stored in the extended header per section
imType=100; % http://msg.ucsf.edu/IVE/IVE4_HTML/IM_ref2.html#ImageTypes
lensNum=10612; % lens identification number
nwaves = 1;
nt = 1;
wv2=0;
wv3=0;
wv4=0;
wv5=0;



hdr=int32(zeros(256,1));

sizes=size(arr);
if numel(sizes)<3
    sizes(3)=1;
end;
if nargin >5
    sizes(3)=nim;
end;


theMean=mean(arr(:));
theMax=max(arr(:));
theMin=min(arr(:));

hdr(1:3)=sizes; % number of columns, rows, sections
hdr(4) = matlab2dvpixeltype(class(arr));
hdr(8:10)=1;  % number of intervals along x,y,z
hdr(11:13)=typecast(single([dx dx dz]),'int32');  % Cell dimensions
hdr(14:16)=typecast(single([90 90 90]),'int32');   % Angles
hdr(17:19)=(1:3);  % Axis assignments
hdr(20:22)=typecast(single([theMin theMax theMean]'),'int32');
hdr(23)=0;  % Space group 0 (default)
hdr(24)=0;  % Extended header size in bytes
hdr(25)=typecast(int16([-16224 0]),'int32'); % dvid and nblank
hdr(26)=0; % starting time index
hdr(33)=typecast(int16([numInts numFloats]'),'int32');
%hdr(35:40) are used for min/max for waves 2:4
hdr(41)=typecast(int16([imType lensNum]),'int32');
%hdr(42:43) are used for n1,n2,v1,v2
%hdr(44:45) are used for min5 max5
ImgSequence = 1; % (0 = ZTW, 1 = WZT, 2 = ZWT)
hdr(46)=typecast(int16([nt ImgSequence]),'int32');
hdr(50:52)=typecast(int16([nwaves, wv1, wv2, wv3, wv4, wv5]),'int32');
%hdr(53:55) used for x,y,z origin
%hdr(56) used for numTitles
% everthing else (hdr(57:256)) is used for Title info

handle=fopen(filename,'w','ieee-le');
fwrite(handle,hdr,'int32');

end

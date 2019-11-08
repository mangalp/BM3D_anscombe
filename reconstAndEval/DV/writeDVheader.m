function handle=writeDVheader(H,filename)
% handle=writeDVheader(H,filename)
% Write the header of an DV/NMRC file, and leave the file open,
% returning the file handle, so that data can be written sequentially into
% the file and then the file closed.  Data are written in little-endian style,
% as float32 values.
%
% H is a DV header struct, provided by the function initDVheader
%
%


hdr=zeros(256,1,'int32');

hdr(1:3)=[H.nx H.ny H.nz]; % number of columns, rows, sections
hdr(4)=H.pixelType;
hdr(5:7)=[H.mxst H.myst H.mzst];  % Cell dimensions
hdr(8:10)=[H.mx H.my H.mz];  % number of intervals along x,y,z
hdr(11:13)=typecast(single([H.dx H.dy H.dz]),'int32');  % Cell dimensions
hdr(14:16)=typecast(single([H.alpha H.beta H.gamma]),'int32');   % Angles
hdr(17:19)=[H.colax H.rowax H.sectax];  % Axis assignments
hdr(20:22)=typecast(single([H.min H.max H.mean]),'int32');
hdr(23:24)=[H.nspg H.next];  % Space group 0 (default)
hdr(25)=typecast(int16([H.dvid 0]),'int32'); % dvid and nblank
hdr(26)=H.ntst; % starting time index
hdr(33)=typecast(int16([H.numInts H.numFloats]'),'int32');
%hdr(35:40) are used for min/max for waves 2:4
hdr(41)=typecast(int16([H.imType H.lensNum]),'int32');
%hdr(42:43) are used for n1,n2,v1,v2
%hdr(44:45) are used for min5 max5
hdr(46)=typecast(int16([H.ntime H.imSeq]),'int32');
hdr(50:52)=typecast(int16([H.nwaves, H.wv1, H.wv2, H.wv3, H.wv4, H.wv5]),'int32');
%hdr(53:55) used for x,y,z origin
%hdr(56) used for numTitles
% everthing else (hdr(57:256)) is used for Title info

handle=fopen(filename,'w','ieee-le');
fwrite(handle,hdr,'int32');

% write extended header
if H.next > 0
    hdrext = zeros(H.next/4, 1,'int32');
    for z = 1:H.nz
        offset = (z-1)*(H.numFloats+H.numInts)+1;
        hdrext(offset:offset+H.numInts-1)=zeros(H.numInts, 1,'int32');
        hdrext(offset+H.numInts:offset+H.numInts+13) = ...
               typecast(single([H.extended(z).photosensor
                                H.extended(z).timeStamp
                                H.extended(z).xstage
                                H.extended(z).ystage
                                H.extended(z).zstage
                                H.extended(z).min
                                H.extended(z).max
                                H.extended(z).mean
                                H.extended(z).expTime
                                H.extended(z).ndFilter
                                H.extended(z).exwave
                                H.extended(z).emwave
                                H.extended(z).intenScaling
                                H.extended(z).energyConvFactor]),'int32');
    end
    fwrite(handle,hdrext,'int32');
end

    
end

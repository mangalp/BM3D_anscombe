function [hdr,handle] = readDVheader(F)
% [hdr,handle] = readDVheader(F)
%
% read metadata from MRC/DV file format:
% http://msg.ucsf.edu/IVE/IVE4_HTML/priism_mrc_header.html

if exist(F, 'file') == 0
   error(['File not found: ' F]);
end

hdr = struct();
handle=fopen(F,'r');

a=num2cell(fread(handle, 10,'int32'));
b=num2cell(fread(handle, 6,'single'));
c=num2cell(fread(handle, 3,'int32'));
d=num2cell(fread(handle, 3,'single'));
e=num2cell(fread(handle, 2,'int32'));
f=num2cell(fread(handle, 2,'int16'));
hdr.ntst=fread(handle, 1,'int32');
hdr.blank=fread(handle, 24,'char');
i=num2cell(fread(handle, 4,'int16'));
j=num2cell(fread(handle, 6,'single'));
k=num2cell(fread(handle, 6,'int16'));
l=num2cell(fread(handle, 2,'single'));
m=num2cell(fread(handle, 2,'int16'));
n=num2cell(fread(handle, 3,'single'));
o=num2cell(fread(handle, 6,'int16'));
p=num2cell(fread(handle, 3,'single'));
hdr.nTitles=fread(handle, 1,'int32');
hdr.titles=fread(handle, 800,'char');

[hdr.nx, hdr.ny, hdr.nz, hdr.pixelType, hdr.mxst, hdr.myst, hdr.mzst, hdr.mx, hdr.my, hdr.mz]=a{:};
[hdr.dx, hdr.dy, hdr.dz, hdr.alpha, hdr.beta, hdr.gamma]=b{:};
[hdr.colax, hdr.rowax, hdr.sectax]=c{:};
[hdr.min, hdr.max, hdr.mean]=d{:};
[hdr.nspg, hdr.next]=e{:};
% the total size of the extended header (next) is given by 
% the signed 32-bit integer in header bytes 93 through 96
[hdr.dvid, hdr.nblank]=f{:};
[hdr.numInts, hdr.numFloats, hdr.sub, hdr.zfac]=i{:};
% the extended header contains NumInts (from the signed 16-bit integer 
% in bytes 129 and 130) 4-byte integers and NumFloats (from the signed 
% 16-bit integer in bytes 131 and 132) 4-byte floating-point values per 
% section so the size of the extended header should be at least
% (NumInts + NumFloats) * NumSections * 4

% The extended header values for section k (k in the range of 1 to 
% NumSections) start at the offset (from the beginning of the file),
%    1025 + (k - 1) * (NumInts + NumFloats) * 4
    
[hdr.min2, hdr.max2, hdr.min3, hdr.max3, hdr.min4, hdr.max4]=j{:};
[hdr.imType, hdr.lensNum, hdr.n1, hdr.n2, hdr.v1, hdr.v2]=k{:};
[hdr.min5, hdr.max5]=l{:};
[hdr.ntime, hdr.imSeq]=m{:};
[hdr.xtilt, hdr.ytilt, hdr.ztilt]=n{:};
[hdr.nwaves, hdr.wv1, hdr.wv2, hdr.wv3, hdr.wv4, hdr.wv5]=o{:};
[hdr.zorig, hdr.xorig, hdr.yorig]=p{:};

hdr.nslices=hdr.nz/(hdr.ntime*hdr.nwaves);

if hdr.next>0
    %hdr.extended = struct();
    for sec = 1:hdr.nz        
        fread(handle, hdr.numInts,'int32');
        Eb=fread(handle, hdr.numFloats,'single');
        
        hdr.extended(sec) = struct('photosensor', Eb(1),...
        'timeStamp', Eb(2), 'xstage', Eb(3), 'ystage', Eb(4), 'zstage', Eb(5),...
        'min', Eb(6), 'max', Eb(7), 'mean', Eb(8), 'expTime', Eb(9),...
        'ndFilter', Eb(10), 'exwave', Eb(11), 'emwave', Eb(12),...
        'intenScaling', Eb(13), 'energyConvFactor', Eb(14));

    end
    
    extra = hdr.next - ((hdr.numInts + hdr.numFloats) * hdr.nz * 4);
    hdr.extraExtended = fread(handle, extra/4,'int32');
end


logfile = strrep(F, '.dv', '.log');
if exist(logfile, 'file') == 2
   hdr.log=struct();
   fstring = fileread(logfile);
   lines = textscan(fstring,'%s','delimiter','\n');
   for l = 1:numel(lines{1})
       try
           switch lines{1}{l}(1:7)
               case 'OMX ver'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.OMXversion = strtrim(a(2));
               case 'OMX sys'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.OMXsystem = strtrim(a(2));
               case 'drawer:'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.drawer = strtrim(a(2));
               case 'objecti'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.objective = strtrim(a(2));
               case 'Time-la'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.timelapse = strtrim(a(2));
               case 'angles:'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.angles = strtrim(a(2));
               case 'nphases'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.nphases = strtrim(a(2));
               case 'binning'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.binning = strtrim(a(2));
               case 'type:  '
                   a = strsplit(lines{1}{l},':');
                   hdr.log.exptype = strtrim(a(2));
               case 'type of'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.multichanneltype = strtrim(a(2));
               case 'Section'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.secspacing = strtrim(a(2));
               case 'Number '
                   a = strsplit(lines{1}{l},':');
                   hdr.log.numsections = strtrim(a(2));
               case 'Sample '
                   a = strsplit(lines{1}{l},':');
                   hdr.log.thickness = strtrim(a(2));
               case 'Point V'
                   a = strsplit(lines{1}{l},':');
                   hdr.log.pointvisit = strtrim(a(2));
               otherwise
           end
       catch
       end
           
   end
   
end


%fclose(handle);

end

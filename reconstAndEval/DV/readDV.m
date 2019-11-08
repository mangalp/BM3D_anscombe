function [A,hdr] = readDV(F, order)
% [A,hdr] = readDV(F, order)
%
% read DeltaVision (MRC, Priism) file format.  Optional order string
% dictates the arrangement of the returned array A.
% returned hdr is a struct with the metadata from the file header.

if nargin<2
    order='yxzwt'; % order of the returned array
end

if exist(F, 'file') == 0
   error(['File not found: ' F]);
end

[hdr,handle] = readDVheader(F);
pixtype = dvpix2matlabtype(hdr.pixelType);

A = zeros(hdr.nx,hdr.ny,hdr.nslices,hdr.nwaves,hdr.ntime,pixtype);
if hdr.pixelType == 4 % IW_COMPLEX 8-byte complex value as 2 4-byte floating-point 
    for section = 1:(hdr.nz)
        in = fread(handle, [2, hdr.nx*hdr.ny],'single');
        A(:,:,section) = reshape(complex(in(1,:),in(2,:)),[hdr.nx, hdr.ny]);
    end
elseif hdr.pixelType == 3 % IW_COMPLEX_SHORT 4-byte complex value as 2 2-byte signed integers
    for section = 1:(hdr.nz)
        in = fread(handle, [2, hdr.nx*hdr.ny],'int16=>single');
        A(:,:,section) = reshape(complex(in(1,:),in(2,:)),[hdr.nx, hdr.ny]);
    end
else
    for section = 1:(hdr.nz)
        A(:,:,section) = fread(handle, [hdr.nx, hdr.ny], strcat(pixtype,'=>',pixtype));
    end
end


% imseq is the DV image sequence type
% 0 = XYZTW
% 1 = XYWZT
% 2 = XYZWT
if hdr.imSeq == 0 % XYZTW
    A = reshape(A,[hdr.nx, hdr.ny, hdr.nslices, hdr.ntime, hdr.nwaves]);
elseif hdr.imSeq == 1 % XYWZT
    A = reshape(A,[hdr.nx, hdr.ny, hdr.nwaves, hdr.nslices, hdr.ntime]);
elseif hdr.imSeq == 2 % XYZWT
    A = reshape(A,[hdr.nx, hdr.ny, hdr.nslices, hdr.nwaves, hdr.ntime]);
else
end

A = reorderhyperstack(A,hdr.imSeq,order);
hdr.order = order;

% matlab inverts the Y axis... this is to make images opened elsewhere
% appear the same as they do in matlab;
A = flipud(A);

%A = cast(squeeze(A),pixtype);

fclose(handle);

end
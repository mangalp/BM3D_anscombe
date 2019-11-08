function writeDV(arr,filename,hdr)
% writeDV(arr,filename,dx,dz,wv1)
% Write out a 2D image or a 3D volume as DV file
% 
% hdr is a struct with metadata (see initDVheader for field names)
% example:
% 
%     im = rand(128,128,28);
%     writeDV(im,'~/Desktop/example.dv',...
%             struct('dx',0.05,'dy',0.05,'dz',0.17,'wv1',587));
% 
    
if nargin<3
    hdr=struct();
end
if ~isfield(hdr,'order')
    hdr.order = 'yxzwt';
end

% convert double to single
if isa(arr,'double')
    arr=single(arr);
end

% matlab inverts the Y axis... this is to make images opened elsewhere
% appear the same as they do in matlab;
arr = flipud(arr);

% create new DV header from the array and update with values provided
% by the user
H = initDVheader(arr);
fn = fieldnames(hdr);
% these fields are all determined by the input array itself, so the struct
% that the user provides should not be allowed to overwrite them
protectedFields={'nx','ny','nz','pixelType','min','max','mean',...
                'min2','max2','min3','max3','min4','max4','min5','max5'...
                'ntime','nwaves','nslices'};
% with 'next' as a protectedField, extended header will not be transferred
for fi=1:numel(fn)
    if ~ismember(fn{fi},protectedFields)
        H.(fn{fi}) = hdr.(fn{fi});
    end
end

% reorder the stack into the order required by DV imSeq
% H.order is the order of the input array, should be supplied by the user
% if not, assume yxzwt
arr = reorderhyperstack(arr, H.order, H.imSeq);
handle=writeDVheader(H,filename);

fwrite(handle,arr,class(arr));
fclose(handle);

return;

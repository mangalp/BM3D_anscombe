function stackout = reorderhyperstack(stackin, orderin, orderout)
% stackout = reorderhyperstack(stackin, orderin, orderout)
%
% helper function to reorder a multidimensional array according to a
% provided input order and desired output orer
% orderin and orderout can also be entered as a DV image sequence type
% where:
% 0 = XYZTW
% 1 = XYWZT
% 2 = XYZWT

    
    if isa(orderin,'numeric')
        orderin = dvimseq2order(orderin);
    end
    if isa(orderout,'numeric')
        orderout = dvimseq2order(orderout);
    end
    
    strrep(orderin,'c','w');
    strrep(orderout,'c','w');
    
    if logical(any(setdiff(orderin,orderout))) || logical(any(setdiff(orderout,orderin)))
    error('Characters in order in dont match characters in order out');
    end
    
    if ndims(stackin)<numel(orderin)
        %orderin=orderin(1:ndims(stackin));
    elseif ndims(stackin)>numel(orderin)
        error(['Not enough characters in order in (' num2str(orderin) ...
            ') for num dimensions in matrix (' ...
            num2str(ndims(stackin)) ')']);
    end
    if ndims(stackin)<numel(orderout)
        %orderout=orderout(1:ndims(stackin));
    elseif ndims(stackin)>numel(orderout)
       error(['Not enough characters in order out (' num2str(orderout) ...
            ') for num dimensions in matrix (' ...
            num2str(ndims(stackin)) ')']);
    end
    
    reorder = zeros(numel(orderout),1);
    for i = 1:numel(orderout)
        reorder(i) = strfind(orderin,orderout(i));
    end
    stackout = permute(stackin,reorder);


end

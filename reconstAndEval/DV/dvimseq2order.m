function order = dvimseq2order(imseq)
% convert DV image sequence type to hyperstack order
switch imseq
    case 0 %XYZTW
        order='xyztw';
    case 1 %XYWZT
        order='xywzt';
    case 2 %XYZWT
        order='xyzwt';
    otherwise
        error(['unsupported image sequence type: ' imseq]);
end

end

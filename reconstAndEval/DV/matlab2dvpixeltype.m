function t = matlab2dvpixeltype(str) 
% t = matlab2dvpixeltype(str) 
% convert matlab type to DV image pixel type
%
% 0 = uint8 (1 byte unsigned int)
% 1 = int16 (2 byte signed int)
% 2 = single (4 byte floating point)
% 3 = (4 byte complex value as 2 2-byte signed ints)
% 4 = (8-byte complex value as 2 4-byte floating-point (IEEE) values)
% 5 = (2-byte signed integer) EM_TOM
% 6 = uint16 (2-byte unsigned int)
% 7 = int32 (4-byte signed int)

switch str
    case 'uint8'
        t=0;
    case 'int16'
        t=1;
    case {'single','double'}
        % but double needs coersion to single
        t=2;
    case 'uint16'
        t=6;
    case 'int32'
        t=7;
    otherwise
        error(['unsupported data type: ' str]);
end
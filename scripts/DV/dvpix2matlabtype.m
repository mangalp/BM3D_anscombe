function t = dvpix2matlabtype(n) 
% convert DV format pixel type to matlab type
    switch n
        case 0 % 1-byte unsigned integer
            t = 'uint8';
        case 1 % 2-byte signed integer (two's complement for negative values)
            t = 'uint16';
        case 6 % 2-byte unsigned integer
            t = 'uint16';
        case 2 % 4-byte floating-point
            t = 'single';
        case 7 % 4-byte signed integer
            t = 'int32';
        case 4 % 8-byte complex value as 2 4-byte floating-point
            t = 'double';
        case 3 % 4-byte complex value as 2 2-byte signed integers
            t = 'single';
        otherwise
            error(['unsupported DV pixel type: ' n]);
    end
end
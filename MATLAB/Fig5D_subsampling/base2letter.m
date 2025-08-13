function l = base2letter(b)
switch b
    case '1000'
        l = 'A';
    case '0100'
        l = 'C';
    case '0010'
        l = 'G';
    case '0001'
        l = 'T';        
    case '1100'
        l = 'M';
    case '1010'
        l = 'R';
    case '1001'
        l = 'W';
    case '0110'
        l = 'S';        
    case '0101'
        l = 'Y';
    case '0011'
        l = 'K'; 
    otherwise
        l = 1;
end

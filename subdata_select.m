function x = subdata_select(x,mode,S,d)

switch mode
    case 1
        x = x(S);
    case 2
        y = zeros(d);
        y(S) = x;
        x = y(:);
end
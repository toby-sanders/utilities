function y = mm_operator(x,mode,W,p,q,r)

switch mode
    case 1
        x = reshape(x,p*q,r);
        y = col(W*x);
    case 2
        x = reshape(x,size(W,1),r);
        y = col(W'*x);
        % y =  col((reshape(x,size(W,1),slices)'*W)');
end
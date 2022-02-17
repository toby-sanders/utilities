function indices = createrec(d1,d2,corner,dim)
    indices  = zeros(d1*d2,1);
    corner = corner(1)+dim*(corner(2)-1);
    for i = 1:d2
        indices(i*d1-d1+1:i*d1)=corner+(i-1)*dim:corner+(i-1)*dim+d1-1;
    end
end
function TVWB = buildTVWB(n)
  %constructs transform that computes variation values and haar
  %coefficients for signal of size 2^n x 2^n
    largest = 5;
    y = zeros(2^(2*n+2)-2^(n+1)-2+4^n*(3*largest+1),3);
    y(1:2:2^(2*n+2)-2^(n+1)-3,3)=1;
    y(2:2:2^(2*n+2)-2^(n+1)-2,3)=-1;
    y(1:2:2^(2*n+1)-3,2)=1:2^(2*n)-1;
    y(2:2:2^(2*n+1)-2,2)=2:2^(2*n);
    y(2^(2*n+1)-1:2:2^(2*n+2)-2^(n+1)-3,2)=1:2^(2*n)-2^n;
    y(2^(2*n+1):2:2^(2*n+2)-2^(n+1)-2,2)=2^n+1:2^(2*n);
    y(1:2^(2*n+2)-2^(n+1)-2,1)=floor(1:1/2:2^(2*n+1)-1-2^n+1/2);
    
    
    
    %y(2^(largest+1)-1:2^(largest+1):2^(2*n+2)-2^(n+1)-2,3)=100;
    %y(2^(largest+1):2^(largest+1):2^(2*n+2)-2^(n+1)-3,3)=-100;
    % q is the current level for y
    %q1 will be the level for the TVWB, to go in y(q,1)
    q= 2^(2*n+2)-2^(n+1)-2;
    q1 = 2^(2*n+1)-2^n;
    for i = largest:-1:1
        k = n-i;
        c= 1/2^i;
        if i==largest
            for k1 = 1:2^k
                for k2 = 1:2^k
                    y(q+1:q+2^(2*i),3)=c;
                    y(q+1:q+2^(2*i),1)=q1;
                    y(q+1:q+2^(2*i),2)=...
                        createrec(2^i,2^i,[(k1-1)*2^i+1,(k2-1)*2^i+1],2^n);
                    q = q+2^(2*i);
                    q1 = q1+1;
                end
            end
        end

        for k1 = 1:2^k
            for k2 = 1:2^k
                
                %this is for the vertical elements
                 y(q+1:q+2^(2*i),1)=q1;
                y(q+1:q+2^(2*i-1),3)=c;
                y(q+1:q+2^(2*i-1),2)=...
                    createrec(2^i,2^(i-1),[(k1-1)*2^i+1,(k2-1)*2^i+1],2^n);
                q = q + 2^(2*i-1);
                y(q+1:q+2^(2*i-1),3)=-c;
                y(q+1:q+2^(2*i-1),2)=...
                    createrec(2^i,2^(i-1),[(k1-1)*2^i+1,(k2-1/2)*2^i+1],2^n);
                
                q = q+2^(2*i-1);
                q1 = q1+1;
                
                
                %for the horizontal elements
                 y(q+1:q+2^(2*i),1)=q1;
                y(q+1:q+2^(2*i-1),3)=c;
                y(q+1:q+2^(2*i-1),2)=...
                    createrec(2^(i-1),2^i,[(k1-1)*2^i+1,(k2-1)*2^i+1],2^n);                
                q = q + 2^(2*i-1);
                y(q+1:q+2^(2*i-1),3)=-c;
                y(q+1:q+2^(2*i-1),2)=...
                    createrec(2^(i-1),2^i,[(k1-1/2)*2^i+1,(k2-1)*2^i+1],2^n);
                
                q = q+2^(2*i-1);
                q1 = q1+1;
                
                %for the checkered elements
                y(q+1:q+2^(2*i),1)=q1;
                y(q+1:q+2^(2*i-2),3)=c;
                y(q+1:q+2^(2*i-2),2)=...
                    createrec(2^(i-1),2^(i-1),[(k1-1)*2^i+1,(k2-1)*2^i+1],2^n);
                q = q+2^(2*i-2);
                y(q+1:q+2^(2*i-2),3)=c;
                y(q+1:q+2^(2*i-2),2)=...
                    createrec(2^(i-1),2^(i-1),[(k1-1/2)*2^i+1,(k2-1/2)*2^i+1],2^n);
                q = q+2^(2*i-2);
                y(q+1:q+2^(2*i-2),3)=-c;
                y(q+1:q+2^(2*i-2),2)=...
                    createrec(2^(i-1),2^(i-1),[(k1-1/2)*2^i+1,(k2-1)*2^i+1],2^n);
                q = q+2^(2*i-2);
                y(q+1:q+2^(2*i-2),3)=-c;
                y(q+1:q+2^(2*i-2),2)=...
                    createrec(2^(i-1),2^(i-1),[(k1-1)*2^i+1,(k2-1/2)*2^i+1],2^n);
                
                q = q+2^(2*i-2);
                q1 = q1+1;
            end
        end
    end
    TVWB = sparse(y(:,1),y(:,2),y(:,3),2^(2*n+1)-1-2^n+2^(2*n),2^(2*n));
    
    






end
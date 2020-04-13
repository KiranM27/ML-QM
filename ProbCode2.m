function P=PRBM(x,w,a,b)
    b_len=length(b);
    a_len=length(a);
    
    
    P1= exp(a*x.');
    P2=1;
    sum1=0;
    for i =1:b_len
        
            temp_sum=w(i,:)*x.'+b(i);
            ijk=sum(temp_sum);
            P2=2*cosh(temp_sum)*P2;
        
    end
    P=P1*P2;

end

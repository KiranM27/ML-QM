function x3= Metropolis(x1,w1,a1,b1)
    x2=ones(1,length(x1))
   for number=1:10
       n=randi(length(x1),1,500);
    for i =size(n,1)
        k=n(1,i);  
        if x1(1,k)==1
        x2(1,k)=-1;
    elseif x1(1,k)==-1
        x2(1,k)=1;
        end
    faraday=PRBM(x2,w1,a1,b1)/PRBM(x1,w1,a1,b1);
    m=rand(1,1);
    if m<= faraday
        x1=x2;   
    end
    end
    x2
end
end


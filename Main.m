% J: interaction strength 
% h: transverse field 
% L: system size 

%% Parameters

paramH = struct('J', 1, 'h', 0.5, 'L', 4)
paramMC = stuct('N',500, 'epochs', 50)

nx = paramH.L
nh = 2*paramH.L

% NQS: neuronetwork quantum state 
NQS = struct('a', rand(1,nx), 'b', rand(1,nh), 'w', rand(nx,nh), 'nx', nx, 'nh', nh)

gNQS = struct('Ga', 0, 'Gb', 0, 'Gw', 0)

RBM(NQS,[1,1,0,1])
PRBM([1,1,0,1], transpose(NQS.w), NQS.a, NQS.b)

%% Define Restricted Boltzmann Machine (RBM) 

function p = RBM(NQS,x)
p = 1;
for i=1:NQS.nh 
p = p * 2*cosh(NQS.b(i) + (x * NQS.w(:,i)));
end 
p=exp(NQS.a*transpose(x))*p;    
end 
%% Metropolis Hasting
% Gives configurations & use these to evaluate energies and gradients 

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

%% Extra
function P=PRBM(x,w,a,b)
    b_len=length(b);
    a_len=length(a);
    
    
    P1= exp(a*x.')
    P2=1;
    sum1=0;
%     temp_sum=w(1,:)*x.'+b(1)

    for i =1:b_len
        
            temp_sum=w(i,:)*x.'+b(i);
            ijk=sum(temp_sum);
            P2=2*cosh(temp_sum)*P2;
        
    end
    P=P1*P2;

end

function [P] = prob(h,a,b,w,x)
P=exp((h)*(w)*(x.')+(h)*(b.')+(x)*(a.'));
end



 
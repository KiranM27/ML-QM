function f_gamma= fg(x,NQS)
    f_gamma = struct('fa',0,'fb',0,'fw',0); 
    function functiona = fa(x)
        functiona=x;
    end
    function functionb = fb(x,NQS)
        functionb=tanh(x*(NQS.w)+NQS.b);
    end
    function functionw = fw(x,NQS)
        functionw=(tanh(x*(NQS.w)+NQS.b)'*x)';
    end
    f_gamma.fa=fa(x); 
    f_gamma.fb=fb(x,NQS); 
    f_gamma.fw=fw(x,NQS); 
end
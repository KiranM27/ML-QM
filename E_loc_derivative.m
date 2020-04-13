function [da,db,dw] = E_loc_derivative(NQS, initial_state, H)
    a = NQS.a; 
    b = NQS.b;
    w = NQS.w;
    h = H.h;
    
    da = zeros(size(a));
    db = zeros(size(b));
    dw = zeros(NQS.nx,NQS.nh);
    
    % Partial E partial a
    for i = 1:NQS.nx
        for j =1:NQS.nx
            coupled_state = initial_state;
            coupled_state(i) = -initial_state(i);
            da(i) = da(i) + (h/2)*sqrt(RBM(coupled_state)/RBM(initial_state)) ...
                  * (coupled_state(i)-initial_state(i));
        end
    end
    
    % Partial E partial b
    for i = 1:NQS.nh 
        for j = 1:NQS.nx
            coupled_state = initial_state;
            coupled_state(i) = -coupled_state(i);
            
            db(i) = db(i) + (h/2)*sqrt(RBM(coupled_state)/RBM(initial_state)) ...
                  * (tanh((coupled_state*w(:,i))+b(i)) ...
                  - tanh(initial_state*w(:,i))+b(i));
        end
    end
    
    % Partial E partial w
    for i = 1:NQS.nx
        for j = 1:NQS.nh
            coupled_state = initial_state;
            coupled_state(i) = -coupled_state(i);
            for k = 1:NQS.nx
                dw(i,j) = dw(i,j) + (h/2)*sqrt(RBM(coupled_state)/RBM(initial_state)) ...
                        * (tanh(coupled_state*w(:,j)+b(j))*coupled_state(k) ...
                        - tanh(initial_state*w(:,j)+b(j))*initial_state(k));
            end
        end
    end
end


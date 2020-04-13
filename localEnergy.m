function Eloc = localEnergy(initial_state, J, h)
    
    n = length(initial_state);
    X = coupled_states(initial_state, n);
    E = 0;
    Eloc = 0;
    
    for i = 1:n-1
        if sum(initial_state(i:i+1)) == 1
            E = E - J;
        else
            E = E + J;
        end
    end 
    
    Eloc = Eloc + E;
    
    for k = 2:n+1
        new_state = X(k,:);
        Eloc = Eloc + sqrt(prob(new_state)/prob(initial_state))*h;
    end
end

function X = coupled_states(x,n)
    X = repmat(x,n+1,1);
    for i = 1:n
        if x(i) == 0
            X(i+1,i) = 1;
        else
            X(i+1,i) = 0;
        end
    end
end
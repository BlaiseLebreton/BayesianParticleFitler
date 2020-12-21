function parts_E = Evolution(parts, h, w)
    parts_E = parts;
    
%     90°  Haut
%     0°   Droite
%     270° Bas
%     180° Gauche

    for k=1:size(parts_E,2)
        
        parts_E(2,k) = parts(2,k) + round(cos(deg2rad(parts_E(4,k))));
        parts_E(3,k) = parts(3,k) - round(sin(deg2rad(parts_E(4,k))));
        
        parts_E(2,k) = max(min(parts_E(2,k), w), 1);
        parts_E(3,k) = max(min(parts_E(3,k), h), 1);
        
        r = randi([0 10]);
        if r < 1
            parts_E(4,k) = mod(parts_E(4,k) + 90, 360);
        elseif r <= 9
            parts_E(4,k) = parts_E(4,k);
        else
            parts_E(4,k) = mod(parts_E(4,k) - 90, 360);
        end
%         parts_E(4,k) = mod(parts_E(4,k) + randi([-1,1])*90,360);
    end
end


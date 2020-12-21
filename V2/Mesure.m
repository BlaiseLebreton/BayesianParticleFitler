function parts_Z = Mesure(parts, I)
    [h, w, ~] = size(I);
    parts_Z = parts;

    for k=1:size(parts,2)
        % Position
        x = parts(2,k);
        y = parts(3,k);
        if I(y,x,1) == 255
            N = I(y-1:y+1,x-1:x+1,1);
            % Direction
            if N(3,2) == 255 % haut
                dir = 90;
            elseif N(2,1) == 255 % droite
                dir = 0; 
            elseif N(1,2) == 255 % bas
                dir = 270;
            elseif N(2,3) == 255 % gauche
                dir = 180;
            end
            
            x2 = 2 + round(cos(deg2rad(dir)));
            y2 = 2 - round(sin(deg2rad(dir))); 
            
            if N(y2,x2) == 0
                parts_Z(1,k) = 1;
                if mod(parts(4,k), 360) == dir
                    parts_Z(1,k) = 2;  
                end
            else
                parts_Z(1,k) = 0.001;                
            end
        else
            parts_Z(1,k) = 0;
        end
    end
end
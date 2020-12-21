function parts_Z = Mesure(parts, I)

    parts_Z = parts;
    p = 1.0;
    
    for k=1:size(parts,2)
        % Si le pixel sous la particule est rouge
        if I(parts(3,k),parts(2,k),1) == 255
            % Attribuer un poids fort
            parts_Z(1,k) = p;
        else
            % Sinon attribuer un poids faible
            parts_Z(1,k) = 1 - p;
        end
    end
end
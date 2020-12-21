function parts_E = Evolution(parts, h, w)
    parts_E = parts;
    
    % Modèle d'évolution propre
    E = [0 1 0;
         1 1 1;
         0 1 0];
     
    % Partie aléatoire +- 0.25 sur chaque
    E = E + E.*(rand(3)-0.5)/2;
    
    % Normalisation
    E = E / sum(sum(E));
    
    % Pour toutes les particules
    for k=1:size(parts_E,2)
        % Trouver les evolution avec une probabilité non nulle
        [ldi,ldj] = find(E > 0);
        
        % Séléction aléatoire de la direction de déplacement parmis les évolutions possible
        stop = 0;
        while stop == 0
            dk = randi([1,size(ldi,1)]);
            stop = E(ldi(dk),ldj(dk)) > rand();
            dx = ldi(dk)-2;
            dy = ldj(dk)-2;
            
            % Respect des bordures de l'image
            if parts(2,k)+dx < 1 || parts(2,k)+dx > w
                stop = 0;
            end
            if parts(3,k)+dy < 1 || parts(3,k)+dy > h
                stop = 0;
            end
        end
        
        % Déplacement
        parts_E(2,k) = parts(2,k)+dx;
        parts_E(3,k) = parts(3,k)+dy;
    end
end


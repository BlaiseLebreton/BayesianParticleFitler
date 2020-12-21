function parts_S = Sampling(parts, h, w, nsample, nselect, radiusp)
    parts_S = parts;
    npart   = size(parts,2);
    
    % Si une des particules a un poids différent
    if min(parts(1,:)) ~= max(parts(1,:))
        
        % Tri des particules par poids
        parts_S = sortrows(parts',1)';
        
        for k=1:nsample
            
            % Séléction aléatoire du père
            father = randi([npart-nselect, npart]);
            
            stop = 0;
            while stop == 0
                % Déplacement aléatoire du fils
                parts_S(2,k) = parts_S(2,father) + randi([-radiusp/2, radiusp/2]);
                parts_S(3,k) = parts_S(3,father) + randi([-radiusp/2, radiusp/2]);
                stop = 1;

                % Respect des bordures de l'image
                if parts_S(2,k) < 1 || parts_S(2,k) > w
                    stop = 0;
                end
                if parts_S(3,k) < 1 || parts_S(3,k) > h
                    stop = 0;
                end
            end
        end
    end
end


function parts_S = Sampling(parts, h, w, nsample, nselect, radiusp)
    parts(6,:) = parts(1,:) + parts(5,:);
    parts_S = parts;
    npart   = size(parts,2);
    
    % Si une des particules a un poids différent
    if min(parts(6,:)) ~= max(parts(6,:))
        
        % Tri des particules par poids
        parts_S = sortrows(parts',6)';
        
        for k=1:nsample
            
            % Séléction aléatoire du père
            father = randi([npart-nselect+1, npart]);
            
            stop = 0;
            while stop == 0
                % Déplacement aléatoire du fils
%                 dx = randi([-radiusp/2, radiusp/2]);
%                 dy = randi([-radiusp/2, radiusp/2]);
                dx = round(randn()*radiusp/3);
                dy = round(randn()*radiusp/3);
                if parts_S(4,father) == 90 || parts_S(4,father) == 270
                    dx = round(dx / 2);
                else
                    dy = round(dy / 2);
                end
                parts_S(2,k) = parts_S(2,father) + dx;
                parts_S(3,k) = parts_S(3,father) + dy;
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


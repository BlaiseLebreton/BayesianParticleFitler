% Sample sur deux temps (celles sur la queue auront un poids plus faible que celles sur la tête)
% https://docs.google.com/document/d/10lD1llNzPLvoAPocoBTIp8YlOIzQaGhqmZTrN_EM70Y/edit
close all; clear; clc;

%% Variables
path = '../snake_color/snake_%04d.png';
n_stop  = 1018;
n_start = 1;
npart = 2000;   % 500
nsample = 1000; % 250
nselect = 1;   % 5
radiusp = 24; % Divisible par 2

%% Affichage
f1 = figure;
f1.WindowState = 'maximized';

%% Particle initalisation
image = imread(sprintf(path, 0));
[h, w, c] = size(image);
parts = zeros(6,npart);

for k=1:npart
   parts(1,k) = 1/npart;      % w
   parts(2,k) = randi([2,w-1]); % x
   parts(3,k) = randi([2,h-1]); % y

   % Partie 2
   parts(4,k) = randi([0,3])*90; % direction de la tête
   parts(5,k) = 1/npart; % w à l'itération précédente
   parts(6,k) = 2/npart; % somme w sur deux itérations
end

%% Boucle de capture
for im=n_start:n_stop
    %% Lecture de l'image
    image = imread(sprintf(path, im));

    %% Prediction
    parts = Evolution(parts, h, w);

    %% Measurement
    parts = Mesure(parts, image);
    
    %% Center of mass
    avx = 1;
    avy = 1;
    if sum(parts(6,:) >= 3) > 0
        c = parts.*(parts(6,:) >= 3);
        avx = round(sum(c(2,:).*c(6,:))/sum(c(6,:)));
        avy = round(sum(c(3,:).*c(6,:))/sum(c(6,:)));
    end

    %% Sampling
    parts = Sampling(parts, h, w, nsample, nselect, radiusp);

    %% Weight propagation
    parts(5,:) = parts(1,:);
    
    %% Display
    % Remove green background
    image(:,:,2) = 0;

    for k=1:npart
        image(parts(3,k),parts(2,k),3) = 255;
    end


    % Add green dot on center of mass
    image(avy,avx,2) = 255;

%     subplot(2,2,3);
    imshow(image,'InitialMagnification','fit')
    title(sprintf("Image %d/%d", im,n_stop))

    pause(0.1);
end

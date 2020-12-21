%% Améliorations :
% Bruit sur la mesure (peut-être ajouté poids = 1/dist ?)
%%
close all; clear; clc;
%% Variables
path = '../snake_color/snake_%04d.png';
n_stop  = 1018;
n_start = 1;
npart = 500;   % 500
nsample = 300; % 250
nselect = 5;   % 5
radiusp = 24; % Divisible par 2

%% Affichage
f1 = figure;
f1.WindowState = 'maximized';

%% Particle initalisation
image0 = imread(sprintf(path, 0));
[h, w, c] = size(image0);
parts = zeros(3,npart);

for k=1:npart
   parts(1,k) = 1/npart;      % w
   parts(2,k) = randi([1,w]); % x
   parts(3,k) = randi([1,h]); % y
end

%% Boucle de capture
for im=n_start:n_stop
    clf
    %% Lecture de l'image
    image = imread(sprintf(path, im));

    %% Prediction
    parts = Evolution(parts, h, w);

    %% Measurement
    parts = Mesure(parts, image);

    %% Center of mass
    avx = 1;
    avy = 1;
    if sum(parts(1,:)) > 0
        avx = round(sum(parts(2,:).*parts(1,:))/sum(parts(1,:)));
        avy = round(sum(parts(3,:).*parts(1,:))/sum(parts(1,:)));
    end
    
    %% Sampling
    parts = Sampling(parts, h, w, nsample, nselect, radiusp);

    %% Display
    for k=1:npart
        image(parts(3,k),parts(2,k),3) = 255;
    end

    % Remove green background
    image(:,:,2) = 0;
    
    % Add green dot on center of mass
    image(avy,avx,2) = 255;

    imshow(image,'InitialMagnification','fit')
    title(sprintf("Image %d/%d", im,n_stop))

    pause(0.1);
end

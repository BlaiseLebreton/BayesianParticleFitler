k = find(parts(2,:) == 69 & parts(3,:) == 51)
I = imread(sprintf(path, im));;
figure;
imshow(I,[])
x = parts(2,k)
y = parts(3,k)
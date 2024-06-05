addpath('imtool3D_td-master');

NiiDir = 'Task01_BrainTumour/imagesTr/';
FileList = dir([NiiDir 'BRATS_*.nii.gz']);
FileNum = length(FileList);

FileNo = 1;
Modality = 1;
FileName = FileList(FileNo).name;
Img = niftiread([NiiDir FileName]);
imtool3D(Img(:,:,:,Modality));

I = imresize(flip(Img(:,:,78,1).'),2);


[Lines,Vertices,Objects] = isocontour(I,eps);
figure, imshow(I), hold on;
Points=Objects{5};
plot(Vertices(Points,2),Vertices(Points,1),'Color',[1 0 0],'LineWidth',2);

[nX,nY,nZ] = size(Img(:,:,:,Modality));

[X,Y,Z] = meshgrid(1:nX,1:nY,1:nZ);
gridsize = [1 1 1];
X = single(gridsize(1)*(floor(X./gridsize(1))));
Y = single(gridsize(2)*(floor(Y./gridsize(2))));
Z = single(gridsize(3)*(floor(Z./gridsize(3))));

[F,V] = MarchingCubes(X,Y,Z,Img(:,:,:,Modality),eps);
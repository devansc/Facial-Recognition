function TrainFaces(varargin)
facesDir = dir('chosen_faces');
i = 1;
l = 1;
for file = facesDir'
    if(file.name(1)=='.') continue; end
    indFaces = dir(fullfile('chosen_faces',file.name,'*.ppm'));
    for face = indFaces'
        faces.images.data(:,:,:,i) = single(imread(fullfile('chosen_faces',file.name,face.name)));
        faces.images.labels(i) = l;
        i = i + 1;
    end
    set_index = (l-1)*50;
    faces.images.set(set_index+1:set_index+45) = 1;
    faces.images.set(set_index+46:set_index+50) = 2;
    l=l+1;
end

% initialize variables 
trainOpts.batchSize = 90 ;
trainOpts.numEpochs = 26 ;
trainOpts.continue = true ;
trainOpts.gpus = [] ;
trainOpts.learningRate = 0.001 ;
trainOpts.expDir = 'data/face-experiment' ;

% center all the faces image data
faces.images.mean = mean(faces.images.data(:)) ;
faces.images.data = faces.images.data - faces.images.mean ;
net = initializeFacesCNN();

[net,~] = cnn_train(net, faces, @getBatch, trainOpts) ;

figure() ; clf ; colormap gray ;
vl_imarraysc(squeeze(net.layers{1}.weights{1}),'spacing',2)
axis equal ; title('filters in the first layer') ;

% --------------------------------------------------------------------
function [im, labels] = getBatch(faces, batch)
% --------------------------------------------------------------------
im = faces.images.data(:,:,:,batch) ;
%im = 256 * reshape(im, 64, 64, 1, []) ;
labels = faces.images.labels(1,batch) ;

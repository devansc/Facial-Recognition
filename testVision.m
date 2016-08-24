faceDetector = vision.CascadeObjectDetector;
I = rgb2gray(imread('TeamImage.JPG'));
bboxes = step(faceDetector, I);
IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
figure, imshow(IFaces), title('Detected faces');

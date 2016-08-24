function [ output_args ] = add_face( name, index, number )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figure(1)
  
subplot(5,5,index), imshow(imread(sprintf('chosen_faces/%s/%s_00%d.ppm',name,name,number)));

end


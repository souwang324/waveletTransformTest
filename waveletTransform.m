
function transform = waveletTransform(picture, kernel, depth)
   transform = waveletPad(picture, depth);
  for level=0:depth-1
       height = size(transform, 1);
       width = size(transform, 2);
       stride = 2^level;
       view = transform(1:stride:height, 1:stride:width);
       view = waveletLevel(view, kernel);
       transform(1:stride:height, 1:stride:width) = view;
       clear view
  end
end

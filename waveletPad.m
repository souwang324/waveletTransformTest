
function padded = waveletPad(picture, depth) 
pictureHeight = size(picture,1);
pictureWidth = size(picture,2);
paddedHeight = paddedSize(pictureHeight, depth);
paddedWidth = paddedSize(pictureWidth, depth);
paddedShape = [paddedHeight, paddedWidth];
padded = zeros(paddedShape);
for  line=1: paddedHeight
    for pixel=1: paddedWidth
        if line<= pictureHeight
            picLine = line;
        else
            picLine = pictureHeight;
        end
        if pixel<= pictureWidth
            picPixel = pixel;
        else
            picPixel = pictureWidth;
        end
        padded(line,pixel) = picture(picLine,picPixel);
    end
end
end

function p = waveletLevelDD97(p, shift) 
  height = size(p, 1);
  width = size(p, 2);

  %%% Do shift to introduce accuracy bits
  if shift 
    for  line=1: height
      for  pixel=1: width
	      p(line, pixel) = bitshift(p(line, pixel), shift);
      end
    end
  end

  %%% horizontal predict
  for  line=1:height
    for pixel=1:2:width
        if (pixel-2)>0
            tap0 = pixel-2;
        else
            tap0 = 1;
        end
        tap1 = pixel;
        if (pixel+2)<width
            tap2 = pixel+2;
        else
            tap2 = width-2+1;
        end
        if (pixel+4)<width
            tap3 = pixel+4;
        else
             tap3 = width-2+1;
        end
        p(line, pixel+1) = p(line, pixel+1) -...
            bitshift(-p(line,tap0)+9*p(line,tap1)+9*p(line,tap2)-p(line,tap3)+8, -4);
    end
  end

  %%% horizontal update
  for line=1: height
    for pixel=1:2 :width
        if (pixel-1)>0
             tap0 = pixel-1;
        else
             tap0 = 1+1 ;
        end
        tap1 = pixel+1;
        p(line, pixel) =p(line, pixel) +bitshift(p(line,tap0)+p(line,tap1) + 2, -2);
    end
  end
  

  %%% vertical predict
  for line=1:2 :height
      if (line-2)>0
         tap0 = line-2;
      else
         tap0 =  0+1;
      end
       tap1 = line;
       if (line+2)<height
          tap2 = line+2;
       else
           tap2 = (height-2)+1;
       end
       if (line+4)<height
           tap3 = line+4;
       else
           tap3 = height-2+1;
       end
      for pixel=1: width
        p(line+1,pixel) =p(line+1,pixel) -...
         bitshift(-p(tap0,pixel)+9*p(tap1,pixel)+9*p(tap2,pixel)-p(tap3,pixel)+8, -4);
      end
  end

  %%% vertical update
  for line=1:2:height
      if (line-1)>0
          tap0 = line-1;
      else
          tap0 =  1 +1;
      end
      tap1 = line+1;
    for pixel=1: width
        p(line,pixel) = p(line,pixel) +bitshift(p(tap0,pixel)+p(tap1,pixel) + 2, -2);
    end
  end
  
end

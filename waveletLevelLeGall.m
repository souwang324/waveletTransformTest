
function p = waveletLevelLeGall(p, shift)

  height = size(p, 1);
  width = size(p, 2);

  %%% Do shift to introduce accuracy bits
  if shift 
    for line=1: height
      for pixel=1: width
	      p(line, pixel) = bitshift(p(line, pixel), shift);
      end
    end
  end
  %%% horizontal LeGall (5,3): Predict
  for  line=1:height
    for pixel=1:2:width
         tap0 = pixel;
         if (pixel+2)<width
             tap1 = pixel+2;
         else
             tap1 = width-2+1;
         end
         p(line, pixel+1) = p(line, pixel+1) - bitshift(p(line, tap0)+p(line, tap1)+1, -1);
    end
  end

  %%% horizontal LeGall (5,3): Update
  for line=1: height
    for pixel=1:2 :width
        if (pixel-1)>0
            tap0 = pixel-1;
        else
            tap0 = 1+1;
        end
        tap1 = pixel+1;
        p(line, pixel) = p(line, pixel) +bitshift(p(line, tap0)+p(line, tap1) + 2, -2);
    end
  end

  %%% vertical LeGall (5,3): Predict
  for line=1:2 : height
       tap0 = line;
       if (line+2)<height
           tap1 = line+2;
       else
           tap1 = height-2+1;
       end
      for pixel=1: width
          p(line+1, pixel) =p(line+1, pixel) - bitshift(p(tap0, pixel)+p(tap1, pixel)+1, -1);
      end
  end

  %%% vertical LeGall (5,3): Update
  for line= 1:2: height
      if (line-1)>0
         tap0 = line-1;
      else
          tap0 = 1+1 ;
      end
      tap1 = line+1;
      for pixel=1: width
          p(line, pixel) = p(line, pixel) +bitshift(p(tap0, pixel)+p(tap1, pixel) + 2, -2);
      end
  end
end

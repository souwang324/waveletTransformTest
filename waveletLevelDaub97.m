
function p = waveletLevelDaub97(p, shift) 

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

  %%% horizontal type 4
  for line=1: height
    for pixel=1:2:width
         tap0 = pixel;
         if (pixel+2)<width
             tap1 = pixel+2;
         else
             tap1 = width-1;
         end
         p(line, pixel+1) = p(line, pixel+1) -...
             bitshift(6497*p(line, tap0)+6497*p(line, tap1)+2048, -12);
    end
  end

  %%% horizontal type 2
  for line=1:height
    for pixel=1:2:width
        if (pixel-1)>0
            tap0 = pixel-1;
        else
            tap0 = 2;
        end
        tap1 = pixel+1;
        p(line, pixel) = p(line, pixel) - bitshift(217*p(line, tap0)+217*p(line,tap1)+2048, -12);
    end
  end

  %%% horizontal type 3
  for line=1: height
    for pixel=1:2: width
        tap0 = pixel;
        if (pixel+2)<width
            tap1 = pixel+2;
        else
            tap1 = width-1;
        end
      p(line, pixel+1) = p(line, pixel+1) +bitshift(3616*p(line,tap0)+3616*p(line,tap1)+2048, -12);
    end
  end

  %%% horizontal type 1
  for line=1:height
    for pixel=1:2:width
        if (pixel-1)>0
            tap0 = pixel-1;
        else
            tap0 = 2;
        end
        tap1 = pixel+1;
        p(line, pixel) = p(line, pixel) +bitshift(1817*p(line,tap0)+1817*p(line,tap1)+2048, -12);
    end
  end

  %%% vertical type 4
  for line=1:2:height
     tap0 = line;
     if (line+2)<height
         tap1 = line+2;
     else
         tap1 = height-1;
     end
    for pixel=1:width
      p(line+1, pixel) = p(line+1, pixel) -bitshift(6497*p(tap0,pixel)+6497*p(tap1,pixel)+2048, -12);
    end
  end
  

  %%% vertical type 2
  for line=1:2:height
      if (line-1)>0
          tap0 = line-1;
      else
          tap0 = 2;
      end
      tap1 = line+1;
      for pixel=1:width
        p(line, pixel) =p(line, pixel) - bitshift(217*p(tap0,pixel)+217*p(tap1,pixel)+2048, -12);
      end
  end

  %%% vertical type 3
  for line=1:2:height
      tap0 = line;
      if (line+2)<height
          tap1 = line+2;
      else
          tap1 = height-1;
      end
      for pixel=1:width
          p(line+1, pixel) =p(line+1, pixel) + bitshift(3616*p(tap0, pixel)+3616*p(tap1, pixel)+2048, -12);
      end
  end

  %%% vertical type 1
  for line=1:2: height
      if (line-1)>0
          tap0 = line-1;
      else
          tap0 = 2;
      end
      tap1 = line+1;
      for pixel=1:width
      p(line, pixel) =p(line, pixel) + bitshift(1817*p(tap0, pixel)+1817*p(tap1, pixel)+2048, -12);
      end
  end
  
end





function p = waveletLevelFidelity(p, shift)

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

  %%% horizontal type 1
  for  line=1:height
    for pixel=1:2:width
        if (pixel-7)>0
            tap0 = pixel-7;
        else
            tap0 =2;
        end
        if (pixel-5)>0
            tap1 = pixel-5;
        else
            tap1 =2;
        end
        if (pixel-3)>0
            tap2 = pixel-3;
        else
            tap2 =2;
        end
        if (pixel-1)>0
            tap3 = pixel-1;
        else
            tap3 =2;
        end
        tap4 = pixel+1;
        if (pixel+3)<width
            tap5 = pixel+3;
        else
            tap5 = width;
        end
        if (pixel+5)<width
            tap6 = pixel+5;
        else
            tap6 =  width-1;
        end
        if (pixel+7)<width
            tap7 = pixel+7;
        else
            tap7 = width;
        end
      p(line, pixel) =p(line, pixel) +...
        bitshift(-8*p(line, tap0)+21*p(line,tap1)-46*p(line, tap2)+161*p(line, tap3)+...
         161*p(line, tap4)-46*p(line, tap5)+21*p(line, tap6)-8*p(line, tap7)+128, -8);
    end
  end

  %%% horizontal type 4
  for line=1: height
    for pixel=1:2 : width
        if (pixel-6)>0
            tap0 = pixel-6;
        else
            tap0 = 1;
        end
        if (pixel-4)>0
            tap1 = pixel-4;
        else
             tap1 =1;
        end
        if (pixel-2)>0
            tap2 = pixel-2;
        else
            tap2 = 1;
        end
        tap3 = pixel;
        if (pixel+2)<width
            tap4 = pixel+2;
        else
            tap4 = width-1;
        end
        if (pixel+4)<width
            tap5 = pixel+4;
        else
            tap5 = width-1;
        end
        if (pixel+6)<width
            tap6 = pixel+6;
        else
            tap6 = width-1;
        end
        if (pixel+8)<width
            tap7 = pixel+8;
        else
            tap7 = width-1;
        end
      p(line, pixel+1) = p(line, pixel+1) -...
        bitshift(-2*p(line,tap0)+10*p(line, tap1)-25*p(line,tap2)+81*p(line,tap3)+...
         81*p(line, tap4)-25*p(line, tap5)+10*p(line, tap6)-2*p(line, tap7)+128, -8);
    end
  end 

  %%% vertical type 1
  for line=1:2:height
      if (line-7)>0
          tap0 = line-7;
      else
          tap0 = 2;
      end
      if (line-5)>0
          tap1 = line-5;
      else
          tap1 = 2;
      end
      if (line-3)>0
          tap2 = line-3;
      else
          tap2 = 2;
      end
      if (line-1)>0
          tap3 = line-1;
      else
          tap3 = 2;
      end
      tap4 = line+1;
      if (line+3)<height
          tap5 = line+3;
      else
          tap5 = height;
      end
      if (line+5)<height
          tap6 = line+5;
      else
          tap6 = height;
      end
      if (line+7)<height
          tap7 = line+7;
      else
          tap7 = height;
      end
      for pixel=1:width
      p(line, pixel) =p(line, pixel) +...
        bitshift(-8*p(tap0, pixel)+21*p(tap1, pixel)-46*p(tap2, pixel)+161*p(tap3, pixel)+...
         161*p(tap4, pixel)-46*p(tap5, pixel)+21*p(tap6, pixel)-8*p(tap7, pixel)+128, -8);
      end
  end
  

  %%% vertical type 4
  for line=1:2:height
      if (line-6)>0
          tap0 = line-6;
      else
          tap0 = 1;
      end
      if (line-4)>0
          tap1 = line-4;
      else
          tap1 = 1;
      end
      if (line-2)>0
          tap2 = line-2;
      else
          tap2 = 1;
      end
      tap3 = line;
      if line+2<height
          tap4 = line+2;
      else
          tap4 = height-1;
      end
      if (line+4)<height
          tap5 = line+4;
      else
          tap5 = height-1;
      end
      if (line+6)<height
          tap6 = line+6;
      else
          tap6 = height-1;
      end
      if (line+8)<height
          tap7 = line+8;
      else
          tap7 = height-1;
      end
    for pixel=1:width
      p(line+1, pixel) =p(line+1, pixel) -...
        bitshift(-2*p(tap0, pixel)+10*p(tap1, pixel)-25*p(tap2, pixel)+81*p(tap3, pixel)+...
         81*p(tap4, pixel)-25*p(tap5, pixel)+10*p(tap6, pixel)-2*p(tap7, pixel)+128, -8);
    end
  end
  

end
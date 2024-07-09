
function p = waveletLevelHaar(p, shift)

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
       p(line, pixel+1) = p(line, pixel+1) -p(line, pixel);
    end
  end

  %%% horizontal update
  for line=1: height
    for pixel=1:2 :width
         p(line, pixel) = p(line, pixel) + floor((p(line, pixel+1) + 1)/2);
    end
  end

  %%% vertical predict
  for pixel=1:width
    for line=1:2:height
       p(line+1, pixel) = p(line+1, pixel) -p(line, pixel);
    end
  end
  

  %%% vertical update
  for  pixel=1: width
    for  line=1:2:height
          p(line, pixel) = p(line, pixel) + floor((p(line+1, pixel) + 1)/2);
    end  
  end

end

function p = waveletLevel(p, kernel) 
switch kernel 
    case 'DD97'  
      p = waveletLevelDD97(p, 1);      
    case 'LeGall'
      p = waveletLevelLeGall(p, 1);      
    case 'DD137'
      p = waveletLevelDD137(p, 1);      
    case 'Haar0'
      p = waveletLevelHaar(p, 0);      
    case 'Haar1'
      p = waveletLevelHaar(p, 1);      
    case 'Fidelity'
      p = waveletLevelFidelity(p, 0);      
    case 'Daub97'
      p = waveletLevelDaub97(p, 1);  
    otherwise
      error('invalid wavelet kernel');
end
end
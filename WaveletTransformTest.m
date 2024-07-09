clear all
clear classes
close all
clc
global lookup
lookup = [base2dec('000000004',16), base2dec('000000005',16), base2dec('000000006',16), base2dec('000000007',16), base2dec('000000008',16), base2dec('00000000A',16), base2dec('00000000B',16), base2dec('00000000D',16),...
base2dec('000000010',16), base2dec('000000013',16), base2dec('000000017',16), base2dec('00000001B',16), base2dec('000000020',16), base2dec('000000026',16), base2dec('00000002D',16), base2dec('000000036',16),...
base2dec('000000040',16), base2dec('00000004C',16), base2dec('00000005B',16), base2dec('00000006C',16), base2dec('000000080',16), base2dec('000000098',16), base2dec('0000000B5',16), base2dec('0000000D7',16),...
base2dec('000000100',16), base2dec('000000130',16), base2dec('00000016A',16), base2dec('0000001AF',16), base2dec('000000200',16), base2dec('000000261',16), base2dec('0000002D4',16), base2dec('00000035D',16),...
base2dec('000000400',16), base2dec('0000004C2',16), base2dec('0000005A8',16), base2dec('0000006BA',16), base2dec('000000800',16), base2dec('000000983',16), base2dec('000000B50',16), base2dec('000000D74',16),...
base2dec('000001000',16), base2dec('000001307',16), base2dec('0000016A1',16), base2dec('000001AE9',16), base2dec('000002000',16), base2dec('00000260E',16), base2dec('000002D41',16), base2dec('0000035D1',16),...
base2dec('000004000',16), base2dec('000004C1C',16), base2dec('000005A82',16), base2dec('000006BA2',16), base2dec('000008000',16), base2dec('000009838',16), base2dec('00000B505',16), base2dec('00000D745',16),...
base2dec('000010000',16), base2dec('000013070',16), base2dec('000016A0A',16), base2dec('00001AE8A',16), base2dec('000020000',16), base2dec('0000260E0',16), base2dec('00002D414',16), base2dec('000035D14',16),...
base2dec('000040000',16), base2dec('00004C1C0',16), base2dec('00005A828',16), base2dec('00006BA28',16), base2dec('000080000',16), base2dec('00009837F',16), base2dec('0000B504F',16), base2dec('0000D7450',16),...
base2dec('000100000',16), base2dec('0001306FE',16), base2dec('00016A09E',16), base2dec('0001AE8A0',16), base2dec('000200000',16), base2dec('000260DFC',16), base2dec('0002D413D',16), base2dec('00035D13F',16),...
base2dec('000400000',16), base2dec('0004C1BF8',16), base2dec('0005A827A',16), base2dec('0006BA27E',16), base2dec('000800000',16), base2dec('0009837F0',16), base2dec('000B504F3',16), base2dec('000D744FD',16),...
base2dec('001000000',16), base2dec('001306FE1',16), base2dec('0016A09E6',16), base2dec('001AE89FA',16), base2dec('002000000',16), base2dec('00260DFC1',16), base2dec('002D413CD',16), base2dec('0035D13F3',16),...
base2dec('004000000',16), base2dec('004C1BF83',16), base2dec('005A8279A',16), base2dec('006BA27E6',16), base2dec('008000000',16), base2dec('009837F05',16), base2dec('00B504F33',16), base2dec('00D744FCD',16),...
base2dec('010000000',16), base2dec('01306FE0A',16), base2dec('016A09E66',16), base2dec('01AE89F99',16), base2dec('020000000',16), base2dec('0260DFC14',16), base2dec('02D413CCD',16), base2dec('035D13F33',16),...
base2dec('040000000',16), base2dec('04C1BF829',16), base2dec('05A82799A',16), base2dec('06BA27E65',16), base2dec('080000000',16), base2dec('09837F052',16), base2dec('0B504F334',16), base2dec('0D744FCCB',16)];

global cachedBits cache  bitsLeft isBounded vc2buf vc2bufcnt
global slice_IO_format  slice_sizes  slice_scalar  single_slice_size
global prev_parse_offset

infileName='TEST8.PPM';
fidMT = fopen(infileName, 'rb');  
tlineMT = fgetl(fidMT);
% fprintf('%s\n', tlineMT);
tlineMT = fgetl(fidMT);
szMT = str2num(tlineMT);
tlineMT = fgetl(fidMT);
MaxvalueMT = str2num(tlineMT);
% fprintf('%d\n', MaxvalueMT);
IMT = fread(fidMT, [3*szMT(1) szMT(2)], 'uint8');
fclose(fidMT);
IMT = IMT';
for i = 1:szMT(2)
    MMT1(:, i) = IMT(:,((i-1)*3+1));
    MMT2(:, i) = IMT(:,((i-1)*3+2)); 
    MMT3(:, i) = IMT(:,((i-1)*3+3));
end
MMT1 = uint8(MMT1);
MMT2 = uint8(MMT2);
MMT3 = uint8(MMT3);
MMT(:, :, 1) = MMT1;
MMT(:, :, 2) = MMT2;
MMT(:, :, 3) = MMT3;
% figure
% imshow(MMT);
% title('MT PPM')


[height, width, dim] = size(MMT);
wfilter={'DD97', 'LeGall', 'DD137', 'Haar0', 'Haar1', 'Fidelity','Daub97'};
shape=[width, height];
nbytes = 1;
verbose = 1;
chromaFormat = {'RGB'};
lumaDepth = 8;
chromaDepth = 8;
interlaced = 0;
topFieldFirst = 0;
kernel = wfilter{4};
waveletDepth = 2;
ySize = 1;
xSize = 1;
compressedBytes = prod(shape);
output = {'STREAM'};

format =  PictureFormat(height, width, chromaFormat);
frame_rate = {'FR0'};

if 0
    fprintf('bytes per sample= %d\n', bytes);
    fprintf('luma depth (bits) = %d\n',lumaDepth);
    fprintf('chroma depth (bits) = %d\n',chromaDepth);
    fprintf('height = %d\n',format.lumaHeight);
    fprintf('width = %d\n' ,format.lumaWidth);
    fprintf('chroma format = %s\n', char(format.chromaFormat));
    fprintf('interlaced = %d\n', interlaced);
    if interlaced 
        fprintf('top field first = true\n') ;
    end
    fprintf('wavelet kernel = %s\n', char(kernel));
    fprintf('wavelet depth = %d\n', waveletDepth);
    fprintf('vertical slice size (in units of 2**(wavelet depth)) = %d\n', ySize);
    fprintf('horizontal slice size (in units of 2**(wavelet depth)) = %d\n', xSize);
    fprintf('compressed bytes = %d\n',compressedBytes);
    fprintf('output = %s\n', char(output));
end


yTransformSize = ySize*2^waveletDepth;
xTransformSize = xSize*2^waveletDepth;
if interlaced
    pictureHeight = height/2;
else
    pictureHeight = height;
end
paddedPictureHeight = paddedSize(pictureHeight, waveletDepth);
paddedWidth = paddedSize(width, waveletDepth);
ySlices = floor(paddedPictureHeight/yTransformSize);
xSlices = floor(paddedWidth/xTransformSize);
if (paddedPictureHeight ~= (ySlices*yTransformSize) )
    error('paddedPictureHeight ~= (ySlices*yTransformSize)');
end
 
if (paddedWidth ~= (xSlices*xTransformSize) )
    error('paddedWidth ~= (xSlices*xTransformSize)');
end

if verbose
   fprintf('Vertical slices per picture          = %d\n',ySlices);
   fprintf('Horizontal slices per picture        = %d\n',xSlices);
%%% Calculate slice bytes numerator and denominator
   if interlaced
       temp1 = compressedBytes/2;
   else
       temp1 = compressedBytes;
   end
    sliceBytesNandD = rationalise( temp1, ySlices*xSlices);
    SliceBytesNum = sliceBytesNandD.numerator;
    SliceBytesDenom = sliceBytesNandD.denominator;
    fprintf('Slice bytes numerator                = %d\n' , SliceBytesNum);
    fprintf('Slice bytes denominator              = %d\n', SliceBytesDenom);
end

%%% Calculate the quantisation matrix
qMatrix = quantMatrix(kernel, waveletDepth);
if (verbose) 
    fprintf('Quantisation matrix = ');
    for k= 1:length(qMatrix)
        fprintf('%d ',qMatrix(k));
    end
    fprintf('\n');
end

pictureSlices = ySlices*xSlices;
if interlaced 
    framePics = 2;
else
    framePics = 1;
end
totalSlices = framePics*pictureSlices;


frame = 1;

if 0 
    fprintf('Writing Sequence Header\n');
    dataunitio.start_sequence;
    %%% outStream << SequenceHeader(PROFILE_LD, format.lumaHeight(), format.lumaWidth(), format.chromaFormat(), interlaced, frame_rate, topFieldFirst, lumaDepth);
    objSequenceHeader = SequenceHeader({'PROFILE_LD'}, format.lumaHeight,...
                                       format.lumaWidth, format.chromaFormat,...
                                       interlaced, frame_rate, topFieldFirst, lumaDepth);
     
    ostreamSequenceHeader(objSequenceHeader);
end

checktransform = 1;

for d = 1:3
    p = MMT(:, :, d);
    transform(:, :, d) = waveletTransform(p, kernel, waveletDepth);
    fprintf('%d Done\n', d);
end 


if interlaced
    pictureBytes = compressedBytes/2;
else
    pictureBytes = compressedBytes;
end   
bytes = slice_bytes(ySlices, xSlices, pictureBytes, 1); 

if norm(bytes -16*ones(ySlices, xSlices)) == 0
    fprintf('IsEuqal\n');
else
    fprintf('Is NOT Equal\n');
end

fprintf('quantIndices Start...\n');
qIndices = quantIndices(transform, qMatrix, bytes);
fprintf('quantIndices Done\n');

if (verbose) 
    fprintf('Quantise transform coefficients Start....\n');
end
quantisedSlices = quantise_transform(transform, qIndices, qMatrix);
fprintf('quantise transform Done\n');

%%%%% split transform into slices
if (verbose) 
    fprintf('split quantised coefficients into slices\n');
end
slices = split_into_blocks(quantisedSlices , ySlices, xSlices);



%  %%%%  imwrite(uint8(picture), 'Test8MT.ppm')
% [rows, cols, dim] = size(quantisedSlices);
% MaxValue = 255;
% filenameP6 ='Test8_quant_trans';
% filenameP6 = strcat(filenameP6, '.ppm'); 
% fidP6 = fopen(filenameP6, 'wb');
% fprintf(fidP6, 'P6\n');
% fprintf(fidP6, '%d %d\n', cols, rows);
% fprintf(fidP6, '%d\n', MaxValue);
% for m = 1:rows
%     for n = 1: cols      
%         for k = 1: dim
%             if quantisedSlices(m, n, k)<0
%                 temp = 256+quantisedSlices(m, n, k);
%             else
%                 temp = quantisedSlices(m, n, k);
%             end
%             fwrite(fidP6, temp, 'uint8');
%         end
%     end
% end
% fclose(fidP6);

outSlices = struct('yuvSlices', {slices}, 'waveletDepth', {waveletDepth},...
    'qIndices', {qIndices});

% outSlices.yuvSlices = slices;
% outSlices.waveletDepth = waveletDepth;
% outSlices.qIndices = qIndices;

rationalBytes = rationalise(pictureBytes, (ySlices*xSlices));
outWrapped = WrappedPicture(frame,kernel, waveletDepth,xSlices,ySlices,rationalBytes,outSlices);

outfileName='TEST8stream.drc';

prev_parse_offset = Bytes(0);

vc2buf = [];
vc2bufcnt = 0;
cachedBits = 0;
cache = 0;
bitsLeft = 0;
isBounded = false;
outfid = fopen(outfileName, 'wb');

slice_IO_format = 0;
slice_sizes = 0;
slice_scalar = 0;
single_slice_size = 0;
if verbose 
    fprintf('Writing compressed picture to file\n');
end

objlowDelay = sliceio.lowDelay(bytes); %%%  Write output in Low Delay mode
ostreamlowDelay(objlowDelay);

ret = ostreamWrappedPicture(outWrapped);
if vc2bufcnt ~= length(vc2buf)
    error('vc2buf length ERROR');
end

for index = vc2bufcnt-12 :vc2bufcnt
    fwrite(outfid, vc2buf(index), 'uchar');
end

for index = 1:vc2bufcnt-13
    fwrite(outfid, vc2buf(index), 'uchar');
end


dataunitio.end_sequence;

fclose(outfid);

% 
% if ~checktransform
%     fprintf('Inverse Wavelet Transform\n');
%     picture = inverseWaveletTransform(transform, kernel, waveletDepth);
% end
% 
% 
% if checktransform
%     fprintf('Check Wavelet Transform\n');
%     picture = transform;
%     subbands = split_into_subbands(picture, waveletDepth);
%      A = subbands{1};
%     for k = 1:waveletDepth
%         upMatrix = cat(1, A, subbands{3*(k-1)+2});
%         downMatrix = cat(1, subbands{3*(k-1)+3}, subbands{3*(k-1)+4});
%         clear A;
%         A = cat(2, upMatrix, downMatrix);    
%     end
% 
%     figure
%     imshow(uint8(A));
%     title('split into subbands')
%     
%     restore_picutre = merge_subbands(subbands);
%     figure
%     imshow(uint8(restore_picutre))
%     title('merge subbands')
%     
%      %%%%  imwrite(uint8(picture), 'Test8MT.ppm')
%     [rows, cols, dim] = size(picture);
%     MaxValue = 255;
%     filenameP6 ='Test8_trans';
%     filenameP6 = strcat(filenameP6, '.ppm'); 
%     fidP6 = fopen(filenameP6, 'wb');
%     fprintf(fidP6, 'P6\n');
%     fprintf(fidP6, '%d %d\n', cols, rows);
%     fprintf(fidP6, '%d\n', MaxValue);
%     for m = 1:rows
%         for n = 1: cols      
%             for k = 1: dim
%                 fwrite(fidP6, picture(m, n, k), 'uint8');
%             end
%         end
%     end
%     fclose(fidP6);
% 
% else
%     fprintf('Restored Image\n');
%     figure
%     imshow(uint8(picture))
%     for d = 1:3
%         diff(d) = norm(picture(:, :, d) - double(MMT(:, :, d)));
%     end
%     fprintf('norm = %f\n', sum(diff));
% end
% 
% 

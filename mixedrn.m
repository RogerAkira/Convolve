%clear all
clc;
%Read all the values in column A(cleanspeech + impulse response)
%x =1
fnm = 'test4.csv';
fid = fopen(fnm,'r');
nxt = textscan(fid,'%s %s %s','HeaderLines',1,'Delimiter',',');
%csi= rn{1,1}{:,1};
%ydata = rn{1,2}{:,1};
%rn = rn{1,3}{:,1};
csil = length(nxt{1,4});
for I = 1:csil
    mx = nxt{1,4}{I,1};
    rn = nxt{1,3}{:,1};
%x=x+1 
%Read filename as a wavfile
[a, FS] = audioread(mx);
[b, FS1] = audioread(rn);
%converting roadnoise length to match cleanspeech length
al = length(a);
bl = length(b);
N = min([al bl]);
A = a(1:N);
B = b(1:N);
%adding roadnoise to cleanspeech
mixed = A + B;
%writing data back into a wav file

newfnm = sprintf('%s%d%s','mixed',I,'.wav');

    %writing data back into a wav file
    audiowrite(newfnm,mixed,FS1);
end

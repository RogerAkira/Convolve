
function[] = Databaseconv(filename,output)
%clear all
clc;
%Read all the values in column A(cleanspeech + impulse response)

fnm = filename;
fid = fopen(fnm,'r');
csv = textscan(fid,'%s %s %s %s %s','HeaderLines',1,'Delimiter',',');

%loop through each filename
csil = length(csv{1,1});
for row = 1:csil
    csi = csv{1,1}{row,1};
    imp = csv{1,2}{:,1};
    
    %Read filename as a wavfile
    [c, FS] = audioread(csi);
    [d, FS1] = audioread(imp);
    %convolving clean speech with impulse response
    conv = filter(d, 1, c);
    %adds convolve speech filename to original csv file for single file input
    
    
    %newfn = sprintf('%s%d%s','conv',J,'.wav');
    fileloc = sprintf('%s%s%d%s',output,'conv',row,'.wav');
    %A = cellstr(newfn);
    B = cellstr(fileloc);
    
    %res = csv{1,3}{J,1};
    %xlswrite(fnm,A,1,strcat('D',num2str(J+1)));
    xlswrite(fnm,B,1,strcat('E',num2str(row+1)));
    %writing data back into a wav file
    %audiowrite(newfn,conv,FS1);
    audiowrite(fileloc,conv,FS1);
end
fnm = filename;
fid = fopen(fnm,'r');
nxt = textscan(fid,'%s %s %s %s %s','HeaderLines',1,'Delimiter',','); 
csil = length(nxt{1,4});

for I = 1:csil      
        mx = nxt{1,5}{I,1};
        rn = nxt{1,3}{:,1};

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

        newfnm1 = sprintf('%s%s%d%s',output,'mixed',I,'.wav');

        %writing data back into a wav file
        audiowrite(newfnm1,mixed,FS1);
end   
    





function[] = Dataconv(filename,output)
%clear all
clc;
%Read all the values in column A(cleanspeech + impulse response)

fnm = filename;
fid = fopen(fnm,'r');
csv = textscan(fid,'%s %s %s %s %s %s %s %s %s %s','HeaderLines',1,'Delimiter',',');

%loop through each filename
csil = length(csv{1,1});
for row = 1:csil
    csf = csv{1,1}{row,1};
    cs = csv{1,2}{row,1};
    impf = csv{1,3}{:,1};
    imp = csv{1,4}{:,1};
    csconv = sprintf('%s%s',csf,cs);
    impconv = sprintf('%s%s',impf,imp);
    %Read filename as a wavfile
    [c, FS] = audioread(csconv);
    [d, FS1] = audioread(impconv);
    %convolving clean speech with impulse response
    conv = filter(d, 1, c);
    %adds convolve speech filename to original csv file for single file input
    
    
    [filepath,name,ext] = fileparts(cs); 
    
    %newfn = sprintf('%s%d%s','conv',J,'.wav');
    fileloc = sprintf('%s%s%s%s',output,'conv',name,'.wav');
    %A = cellstr(newfn);
    B = cellstr(fileloc);
    
    %res = csv{1,3}{J,1};
    %xlswrite(fnm,A,1,strcat('D',num2str(J+1)));
    xlswrite(fnm,B,1,strcat('G',num2str(row+1)));
    %writing data back into a wav file
    %audiowrite(newfn,conv,FS1);
    audiowrite(fileloc,conv,FS1);
end
fnm = filename;
fid = fopen(fnm,'r');
nxt = textscan(fid,'%s %s %s %s %s %s %s %s %s %s','HeaderLines',1,'Delimiter',','); 
csil = length(nxt{1,7});

for I = 1:csil      
        mx = nxt{1,7}{I,1};
        rnf = nxt{1,5}{:,1};
        rn = nxt{1,6}{:,1};
        rnmix = sprintf('%s%s',rnf,rn);
        %Read filename as a wavfile
        [a, FS] = audioread(mx);
        [b, FS1] = audioread(rnmix);
        %converting roadnoise length to match cleanspeech length
        al = length(a);
        bl = length(b);
        N = min([al bl]);
        A = a(1:N);
        B = b(1:N);
        %adding roadnoise to cleanspeech
        mixed = A + B;
        %writing data back into a wav file
        [filepath,name,ext] = fileparts(mx); 
        newfnm1 = sprintf('%s%s%s%s',output,'mixed',name,'.wav');
        newfnm2 = sprintf('%s%s%s','mixed',name,'.wav');
        K = cellstr(newfnm2);
        Z = cellstr(newfnm1);
        xlswrite(fnm,Z,1,strcat('H',num2str(I+1)));
        xlswrite(fnm,K,1,strcat('I',num2str(I+1)));
        %writing data back into a wav file
        audiowrite(newfnm1,mixed,FS1);
end   
    

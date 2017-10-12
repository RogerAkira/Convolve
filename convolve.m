%function[] = convolve()
%clear all
clc;
%Read all the values in column A(cleanspeech + impulse response)

fnm = 'test4.csv';
fid = fopen(fnm,'r');
csv = textscan(fid,'%s %s %s','HeaderLines',1,'Delimiter',',');

%loop through each filename
csil = length(csv{1,1});
for J = 1:csil
    csi = csv{1,1}{J,1};
    imp = csv{1,2}{:,1};
    
    %Read filename as a wavfile
    [c, FS] = audioread(csi);
    [d, FS1] = audioread(imp);
    %convolving clean speech with impulse response
    conv = filter(d, 1, c);
    %adds convolve speech filename to original csv file for single file input
    
    
    newfn = sprintf('%s%d%s','conv',J,'.wav');

    %writing data back into a wav file
    audiowrite(newfn,conv,FS1);
end
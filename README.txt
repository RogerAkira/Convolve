convolve.m is the code just to do convoution by entering filename into code
convolvecs.txt is the code to call function convolvecs() entering text file name.
mixedrn.m is code just to do mixing by entering filename into code
mixrn.txt is the code for the function mixrn()

To convolve a file using functions:

Building csv file is important.
Columns go by:
cleanspeech  	Impulse Response	Roadnoise		Output(cs +IR)
test1.wav		impulse.wav			roadnoise.wav	conv.wav

Input of mix tool is column 4 'Output(cs +IR)'


Call convolvecs('textExample.csv') as csv file in matlab directory
*in the future location will be able to be entered

To mix audio do same as above
mixrn('testExample.csv')

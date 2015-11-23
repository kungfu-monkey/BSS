function  y=importdataFromtxt(filename,tempfile)
fidin=fopen(filename);  
fidout=fopen(tempfile,'w');                        
while ~feof(fidin)                  %判断是否是文件尾                                  
    tline=fgetl(fidin);                                   
    if double(tline(1))>=48&&double(tline(1))<=57&&length(tline)<5       
       fprintf(fidout,'%s\n\n',tline);                   
       continue                                         
    end 
end 
fclose(fidout); 
y=importdata(tempfile);
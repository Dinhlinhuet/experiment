fid=fopen('D:/research_space/databaserelease2/databaserelease2/wn/info.txt');
s=textscan(fid,'%s %s %f','headerlines');
fclose(fid);
x=s{1};
y=s{2};
z=s{3};
celldisp(x)
for j=1:length(x)
    disp(x{j});
end
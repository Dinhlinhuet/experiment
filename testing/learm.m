% fid=fopen('D:/research_space/databaserelease2/databaserelease2/fastfading/info.txt');
% s=textscan(fid,'%s %s %f','headerlines');
% fclose(fid);
% x=s{1};
% y=s{2};
% z=s{3};
% arr = [];
% for i= 1:10
%     arr= [arr,i];
% end
% disp(arr);
% disp(z);
x = 0:0.1:1;
y = [x; x*2];
myDir = 'D:/research_space/testing/';
fileID = fopen(sprintf('%s/writefile.txt',myDir),'w');
fprintf(fileID, '%0.2f a %0.2f\n', y);
function [ output_args ] = corr_plot(X,Y, name)
%CORR_PLOT Summary of this function goes here
%   Detailed explanation goes here
    myDir = 'D:/research_space/testing/';
    figure
    sz=10;
    scatter(X,Y,sz,'filled')
    title(name)
    titl = sprintf('%s%s',myDir,name);
    savefig(titl)

end


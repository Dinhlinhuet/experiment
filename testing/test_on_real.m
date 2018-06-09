function test_on_real()
%refImg = imread('D:/research_space/testing/im_original.tif');
%tesImg = imread('D:/research_space/testing/im_distorted.tif');
%myDir = uigetdir; %gets directory
base_dir = 'D:/research_space/data/data_nghia/';
refDir = 'D:/research_space/data/data_nghia/';
myDir = 'D:/research_space/testing';
% distort = {'jp2k','jpeg','gblur','wn','fastfading'};
distort = {'alpha'};
for dis = distort
    distDir = sprintf('%s',base_dir);
    display(distDir);
    names_file = 'D:/research_space/Deeplearning/IQA_DeepQA_FR_release/data_load/collection.txt';
    fid=fopen(names_file);
    s=textscan(fid,'%d %d %s %s %f %f %f','headerlines');
    fclose(fid);
    x=s{3};
    y=s{4};
    mos=s{5};
    cp_mos = [];
%     celldisp(mos);
%     disp(mos);
    psnrs = [];
    ssims = [];
    msssims = [];
    %mses = [];
    fsims = [];
%     siqes = [];
    for j=1:length(mos)
%     for j=1:5
        cp_mos(end+1,:)= mos(j);
%         disp(cp_mos);
%         fprintf('j:%i',j);
        refImgname = x{j};
        path_refImg = strcat(refDir, refImgname);
%         display(path_refImg);
        refImg = imread(path_refImg);
%         disp(x{j}); 
        disImgname = y{j};
        path_disImg = strcat(distDir, disImgname);
%         display(path_disImg);
        disImg = imread(path_disImg);
%         disp(size(disImg));
%         disp(size(refImg));
        psnr = PSNR(refImg,disImg);
        psnrs=[psnrs;round(psnr)];
    %     mse = MSE(refImg,disImg);
    %     disp(mse);
    %     mses=[mses;round(mse)];
%         refs = rgb2gray(refImg);
%         diss = rgb2gray(disImg);
        [ssm, ssim_map] = ssim(refImg,disImg);
%         disp(ssm);
        ssims = [ssims;ssm];
        mssm = msssim(refImg,disImg);
        msssims = [msssims;mssm];
        disp(mssm);
        [fsim, fsimc] = FSIM(refImg, disImg);
%         disp(fsim);
%         disp(fsimc);
        if isnan(fsimc)
            fsimc = 1;
        end
        fsims = [fsims;fsimc];
    %     adm = ADM(refImg,disImg);
    %     disp(psnr);
    %     disp(adm)
    end

    % disp(size(mos));
    disp(size(ssims));
    disp(size(cp_mos));
%     disp(cp_mos);
    fprintf('mos: %i',size(cp_mos));
    fprintf('psnrs: %i', size(psnrs));
%     disp(psnrs);
%     disp(siqes);
    corr1 = corr(cp_mos, psnrs); 
%     disp(corr1);
%     disp(size(corr1));
    % disp(corr2);
    % disp(size(corr2));
    % fprintf('mses');
    % disp(size(mses));
    % disp(mses);
    % corr3 = corr(mos, mses);
    % disp(corr3);
    % disp(size(corr3));
    corr3 = corr(cp_mos, msssims);
%     disp(corr3);
    disp(size(corr3));
 
    corr4 = corr(cp_mos, ssims);
%     disp(corr4);
    disp(size(corr4));
 
    corr5 = corr(cp_mos, fsims);
%     disp(corr5);
    disp(size(corr5));

%     plot
%     figure
%     subplot(3,2,1)        % add first plot in 2 x 2 grid
%     plot(ssims);
%     title('ssim');
% 
%     subplot(3,2,2)        % add second plot in 2 x 2 grid
%     plot(psnrs);
%     title('psnrs')        % scatter plot
% 
%     subplot(3,2,3)        % add second plot in 2 x 2 grid
%     plot(msssims);
%     title('msssim')
% 
%     subplot(3,2,4)        % add second plot in 2 x 2 grid
%     plot(fsims);
%     title('fsim')
% 
%     subplot(3,2,[5 6])
%     plot(cp_mos);
%     title('mos')   % add third plot to span positions 3 and 4
%     fig_name = sprintf('%smetrics.fig',dis{1});
%     savefig(fig_name);
    %save to file
    corr_plot(psnrs, cp_mos,'psnr_mos');
    fileID = fopen(sprintf('%s/correlation_%s.txt',myDir,dis{1}),'w');
    fprintf(fileID, 'ssim: \n');
    fprintf(fileID, '%0.2f\n', ssims);
    fprintf(fileID, 'correlation: %0.2f\n', corr4);

    fprintf(fileID, 'psnr:\n');
    fprintf(fileID, '%0.2f \n', psnrs);
    fprintf(fileID, 'correlation: %0.2f\n', corr1);

    fprintf(fileID, 'msssim: \n');
    fprintf(fileID, '%0.2f \n', msssims);
    fprintf(fileID, 'correlation: %0.2f\n', corr3);

    fprintf(fileID, 'fsim\n');
    fprintf(fileID, '%0.2f \n', fsims);
    fprintf(fileID, 'correlation: %0.2f\n', corr5);

    fclose(fileID);
end
    % distDir = 'D:/research_space/databaserelease2/databaserelease2/fastfading/';
    % distImgs = dir(fullfile(distDir,'*.bmp'));
    % disp(distImgs)


    % refImgs = dir(fullfile(refDir,'*.bmp'));
    % disp(refImgs)
    %gets all wav files in struct

clc;
clear all;
close all;

files = dir('*.csv');


hold on;

for i = 1:10;
    fname = files(i+1).name;
    x = readmatrix(fname);
    x1 = x(2:end,2);
    h = histfit(log10(x1),40,'kernel');
    h(2).LineStyle = 'none';
    h(2).Color = rand(1,3);
    h(1).FaceAlpha = 0.2;
    h(1).EdgeAlpha = 0.2;
    totalerror(i,:) = x1;
    clear x;
end 


%saveas(gcf,'errorp1p10','svg')
%prctile(totalerror',95)

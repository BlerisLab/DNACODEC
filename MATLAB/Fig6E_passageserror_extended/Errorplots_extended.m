clc;
clear all;
close all;

files = dir('*.csv');


hold on;

for i = 1:5;
    fname = files(i).name;
    x = readmatrix(fname);
    Nzeros = sum(x(:)==0)
    x1 = x(:,3);
    x1(x1<=0) = NaN;  

    xstat(i,1) = min(x1);
    xstat(i,2) = max(x1);
    h = histfit(log10(x1),18,'kernel');
    h(2).LineStyle = 'none';
    h(2).Color = rand(1,3);
    h(1).FaceAlpha = 0.2;
    h(1).EdgeAlpha = 0.2;
    totalerror(i,:) = x1;
    clear x;
end 

set(gca,'XLim',[-4 -1])
saveas(gcf,'error','svg')
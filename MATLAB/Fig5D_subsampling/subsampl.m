clc;
clear all;
close all;

files = dir('*.csv');
fname = files(4).name;
x = readmatrix(fname);


for i = 1:376;
    x1 = x(2:end,i+1);
    e(i) = sum(mink(x1,2));
    f(i) = maxk(x1,1);
    g0 = maxk(x1,2);
    g(i) = g0(2);
end

figure;
h = histfit(e,50);
%saveas(gcf,'errorp0','svg')
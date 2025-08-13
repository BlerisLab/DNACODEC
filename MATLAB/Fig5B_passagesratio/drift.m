clc;
clear all;
close all;

files = dir('*.csv');

for i = 1:10
    fname = files(i).name;
    x = readmatrix(fname);
    x1 = x(2,2:end);
    x2 = x(3,2:end);
    x3 = x(4,2:end);
    x4 = x(5,2:end);
    Atotal(i,:) = x1;
    Ctotal(i,:) = x2;
    Gtotal(i,:) = x3;
    Ttotal(i,:) = x4;
end 

hold on;
for j = 1:376    
    plot(Atotal(:,j));   
    plot(Ctotal(:,j));    
    plot(Gtotal(:,j));   
    plot(Ttotal(:,j));   
end

set(gca,'YLim',[0.3 0.7])
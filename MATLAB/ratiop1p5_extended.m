clc;
clear all;
close all;

files = dir('*.csv');

hold on;
for i = 1:5;
    fname = files(i).name;
    x = readmatrix(fname);
    x1 = [x(:,4),x(:,6)]';
    f = maxk(x1,1);
    ftotal(:,i) = f';
    g0 = maxk(x1,2);
    g = g0(2,:);
    gtotal(:,i) = g';
end
hold off;
ftotal2 = ftotal([184:619,650:1085,1116:1552],:);
gtotal2 = gtotal([184:619,650:1085,1116:1552],:);

hold on;
subplot(2,1,1);
boxplot(ftotal2,'Symbol','');
set(gca,'YLim',[0.2 0.8]);
subplot(2,1,2);
boxplot(gtotal2,'Symbol','');
set(gca,'YLim',[0.2 0.8]);
hold off;

saveas(gcf,'errorp1p15_rev','svg')
clc;
clear all;
close all;

files = dir('*.csv');

reffname = 'P0_R1_001.csv';
ref = readmatrix(reffname);
refset = ref(2:end,2:end);
refset = refset(:,:)>0.1;

samprate = [10,20,50,100,500,1000,5000,10000,50000];

for m = 1:9
    fname = ['P6_',num2str(samprate(m)),'reads_base_frequencies']
    pset = readmatrix(fname);
    pset = pset(2:end,2:end);
    pset = pset(:,:)>0.1;
    
    for i = 1:376
        r = refset(:,i);
        r = num2str(r+0)';
        l(i) = base2letter(r);
    
        p = pset(:,i);
        p = num2str(p+0)';
        k(i) = base2letter(p);
    
        j(i) = strcmp(l,k);
        
    
    end

    acc(m) = sum(j)/3.76
    clear l
    clear k

end 


scatter([10,20,50,100,500,1000,5000,10000,50000],acc);
set(gca,'xscale','log')
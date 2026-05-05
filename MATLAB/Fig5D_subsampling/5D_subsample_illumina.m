clc;
clear all;
close all;

reffname = 'P0_R1_001.csv';
ref = readmatrix(reffname);
refset = ref(2:end,2:end);
refset = refset(:,:)>0.10;


readcount = [10, 20, 50, 100, 500, 1000, 5000, 10000, 50000];
er_th = [0.017 0.02 0.038 0.05 0.1];


for q = 1:9;

    files = dir(['simulated_P1/P1_',num2str(readcount(q)),'reads*.csv']);

    for h = 1:5
        acc = 0;
        for m = 1:100
            fname = files(m).name;
            pset = readmatrix(fname);
            pset1 = pset(2:end,2:end);
            pset2 = pset1(:,:)>er_th(h);
            
            for i = 1:376
                r = refset(:,i);
                r = num2str(r+0)';
                l(i) = base2letter(r);
            
                p = pset2(:,i);
                p = num2str(p+0)';
                k(i) = base2letter(p);
            
                j(i) = strcmp(l,k);            
            end
            
            if sum(j) == 376;
                acc = acc+1;
            end
            clear l
            clear k
    
        end
    
    totalacc(q,h) = acc;
    end 

end


close all;

plot(readcount,totalacc,'.-','MarkerSize',30,'LineWidth',2)
set(gca,'xscale','log')



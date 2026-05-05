clc;
clear all;
%close all;

%[0.15, 1];


err_thresh = [0.1, 0.2, 0.3, 0.5, 1, 2];  %Percent error threshold

readcount = [50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000];

for q = 1:9; %for each read count
    files = dir(['ProcessedData/',num2str(readcount(q)),'reads_*.mat']);

    for i = 1:length(err_thresh); %for each error threshold
        acc = 0;
        
        for m = 1:100; %for subsampling runs
        
        fname = files(m).name;    
        load(fname);
        err = (sum(mink(x,2))./sum(x))*100;
        err_matrix = err > err_thresh(i);
       
        if sum(err_matrix)<=1;
        acc = acc+1;
        end
        
        totalacc(q,i) = acc;

        end

    end
         
end

totalacc
%      |err_thresh|
% count|    X     |


plot(readcount,totalacc,'.-','MarkerSize',30,'LineWidth',2)
set(gca,'xscale','log','XLim',[1E1 1E5])

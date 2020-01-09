clear all;clc; close all;
[baseName, folder]= uigetfile('.xlsx','MultiSelect','on'); %gets directory

addpath(folder);

%%
[~,RAW,~] = xlsread(baseName);
%%
[~,c]=find(strcmp(RAW,'Manufacturer'));
[~,anaT] = find(strcmp(RAW,'AnalysisTime'));
[~,acqT] = find(strcmp(RAW,'AcqTime'));
RAW(1,:)=[];
jan1_2013 = datetime('01-01-2013', 'InputFormat','dd-MM-yyyy');
r=find(cellfun(@isempty,RAW(:,c)),1,'last');
%%
tic
if r==length(RAW)
    r=0;
    RAW(1,:)=[];
end
temp=cell(length(RAW)-r,2);
% temp= datetime(RAW(find(contains(RAW(:,4),'M')),4),'InputFormat','dd/MM/yyyy h:mm:ss a');

for i = 1:length(RAW)-r
   
    
    if contains(RAW(r+i,acqT),'M')
        temp{i,1}= datetime(RAW(r+i,acqT),'InputFormat','dd/MM/yyyy h:mm:ss a');
    else
        temp{i,1}=datetime(RAW{r+i,acqT},'InputFormat','dd-MM-yyyy HH:mm:ss');
    end
    
    if contains(RAW(r+i,anaT),'M')
        temp{i,2}= datetime(RAW(r+i,anaT),'InputFormat','dd/MM/yyyy h:mm:ss a');
    else
        temp{i,2}=datetime(RAW{r+i,anaT},'InputFormat','dd-MM-yyyy HH:mm:ss');
    end
    LagTime(i) = minutes(abs(temp{i,1}-temp{i,2}));
    daysSince(i) = daysact(jan1_2013,temp{i,2});
    
end
toc

%% Finding manufacturers i.e. AGFA, SIEMENS, FUJIFILMS etc.
names = unique(RAW(2:end,c));
if isempty(names{1})
    names(1)=[];
end


symbols = {'r.', 'b.', 'g.', 'mx', 'rx', 'gx', 'ro', 'bo', 'go', 'r+', 'b+', 'g+', 'ko', 'yo'};

figure('units','normalized','outerposition',[0 0 1 1])

for j = 1:length(names)
    row =  find(contains(RAW(:,c),names{j}))-r;
    x= daysSince(row);
    y = LagTime(row);
    semilogy(x,y,symbols{j},'MarkerSize',9)
    hold on
end
legend(names)
xlim([0,max(daysSince)+100]);
ylabel('Delay (Minutes)');
xlabel('Analysis Time (Days Since NY 2013)')
title(baseName(1:end-5))
shg;
saveas(gca, fullfile(folder, baseName(1:end-5)), 'png');

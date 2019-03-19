clc
clear
close all
%该程序在singleNum_feature_extraction.m的基础上，批量读取TrainSet文件夹中
%的各个分类数字的图片，并将所有的数字图片特征保存成一个结构体变量，最后将
%这个变量保存成一个mat文件，方便下一步工作读取
imgDataPath='TrainSet/';
imgDataDir=dir(imgDataPath);
label_num=0;
for i=1:length(imgDataDir)
    if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
       isequal(imgDataDir(i).name,'..')||...
       ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
           continue;
    end
    imgDir=dir([imgDataPath imgDataDir(i).name '/*.jpg']);
    single_feature_struct=cell(length(imgDir),1);
    for j=1:length(imgDir)
        imgPath=[imgDataPath imgDataDir(i).name '/' imgDir(j).name];
        single_feature_struct{j,1}=singleNum_feature_extraction(imgPath);
    end
    label_num=label_num+1;
    featureDataStruct(label_num).label=imgDataDir(i).name;
    featureDataStruct(label_num).feature=single_feature_struct;
end
save featureData.mat   featureDataStruct
    
        
        
        
        
    

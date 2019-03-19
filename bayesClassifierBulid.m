function label=bayesClassifierBulid(img)
%加载已经计算好的训练样本的特征变量
load featureData.mat;
test_feature=singleNum_feature_extraction(img);%获得测试图片的特征数据

%计算先验概率
prior=[];%存储先验概率的矩阵
sum=0;
for i=1:size(featureDataStruct,2)
    sum=sum+size(featureDataStruct(i).feature,1);
end
for i=1:size(featureDataStruct,2)
    prior(i)=size(featureDataStruct(i).feature,1)/sum;
end
%计算类条件概率
likelihood = [];%类条件概率
pij=[];%i类的样本第j个特征为1的概率
for i=1:size(featureDataStruct,2)%数字类别个数
    for j=1:100%每个数字图片提取出来的特征数
        sum=0;
        
        for k=1:size(featureDataStruct(i).feature,1)%每个类别下训练样本的个数
            i_feature=featureDataStruct(i).feature(k);
            sum=sum+i_feature{1}(1,j);
        end
        pij(i,j)=(sum+1)/(size(featureDataStruct(i).feature,1)+2);%计算概率估计值即Pj(ωi)，注意拉普拉斯平滑处理
    end
end
for i=1:size(featureDataStruct,2)%数字类别个数
    multi=1;
    for j=1:100%每个数字图片提取出来的特征数
        if(test_feature(j)==1)
            multi=multi*pij(i,j);
        else
            multi=multi*(1-pij(i,j));
        end
    end
    likelihood(i)=multi;
end
%计算后验概率
p_class=[];%后验概率
sum=0;
for i=1:size(featureDataStruct,2)%数字类别个数
    sum=sum+prior(i)*likelihood(i);
end
for i=1:size(featureDataStruct,2)%数字类别个数
    p_class(i)=prior(i)*likelihood(i)/sum;
end
[maxval,maxpos]=max(p_class);
label=maxpos-1;

    
    
        
        


        
        
        
        
    

    


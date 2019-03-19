function feature_array=singleNum_feature_extraction(image)
%该程序可以提取一张图片中数字的特征，返回的特征数据为1*100的矩阵
%image为待提取特征的图片名
src_image=imread(image);
src_image=rgb2gray(src_image);
[src_width,src_height]=size(src_image);
%将手写板保存下来的图片中显示坐标轴的部分截除掉
num_image=src_image(1:src_width-4,5:src_height,:);
%图像灰度值非0即255
num_width=size(num_image,1);
num_height=size(num_image,2);
for i=1:1:num_width
    for j=1:1:num_height
        if num_image(i,j)<128
            num_image(i,j)=255;
        else
            num_image(i,j)=0;
        end
    end
end
%figure;subplot(2,2,1),imshow(num_image)

%将数字所在的框的图像截取出来
column_sum=sum(num_image,1);
row_sum=sum(num_image,2);
first_nozero_column_index=find(column_sum,1);
last_nozero_column_index=find(column_sum,1,'last');
first_nozero_row_index=find(row_sum,1);
last_nozero_row_index=find(row_sum,1,'last');
cut_num_image=num_image(first_nozero_row_index:last_nozero_row_index,first_nozero_column_index:last_nozero_column_index);
cut_num_image=im2bw(cut_num_image);
%subplot(2,2,2),imshow(cut_num_image)

%将截出来的图分成10*10块，每块中的灰度值为255的像素个数超过一半则将这个块的像素值置为255，否则为0
%thresh_value=graythresh(cut_num_image);
[cut_width,cut_height]=size(cut_num_image);
batch_width=int16(cut_width/10);
batch_height=int16(cut_height/10);
batch_image=zeros(10,10);
feature_array=zeros(1,100);
n=1;
row_start=1;
for i=1:1:10
    row_end=i*batch_width;
    if row_end>cut_width
        row_end=cut_width;
    end
    column_start=1;
    for j=1:1:10
        column_end=j*batch_height;
         if column_end>cut_height
            column_end=cut_height;
         end
        split_batch=cut_num_image(row_start:row_end,column_start:column_end);
        split_area=size(split_batch,1)*size(split_batch,2);
        %figure;imshow(split_batch)
        column_start=j*batch_height+1;
        if sum(split_batch(:))>int16( split_area/10)
            batch_image(i,j)=1;
            feature_array(1,n)=1;
        else
            batch_image(i,j)=0;
            feature_array(1,n)=0;
        end
        n=n+1;
    end
    row_start=i*batch_width+1;
end
%subplot(2,2,3),imshow(batch_image)
        
        








    





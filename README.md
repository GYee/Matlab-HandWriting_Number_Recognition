# 基于Matlab及贝叶斯分类器的手写数字识别
## 项目介绍
这个项目源自于老师布置的一个模式识别大作业，要求使用Matlab实现对手写数字的识别工作，为了展示的直观还设计了GUI界面。因为刚开始，所以首先学会用最传统简单的Bayes分类器去做，之后还会使用神经网络等分类器进行实现，如果后面能够实现出来，将会继续更新的。
## 文件结构及用途介绍  
**Trainset**：使用GUI手写板输入并保存下来的数字图片训练集，一共分为0-9十个类别，每个类别单独放在一个子文件夹中，子文件夹中各有10张手写数字图片

**singleNum_feature_extraction.m**：函数功能为将图片中保留有的坐标轴部分截除（手写板保存下来的图片左边及下边都会有坐标轴相关的线，会一定程度上影响后面特征的提取，故而要去掉），对图片就行二值化，接着获取书写数字所在的区域，将获取的区域图片分成10x10batches，当batch中像素值为1的个数大于该batch像素总数的十分之一时（当然这个阈值可以自己设定），将该batch直接置为1，否则为0。最后这个函数返回的是1x100的行向量，及该数字图片的100个特征值

**feature_struct_build.m**：调用singleNum_feature_extraction.m遍历TrainSet中各类别的所有图片，计算出训练集的特征数据，并保存为有着label和feature两字段的结构体变量，feature为元胞数组，因为每个类别有10张图，所以每个label对应的feature有10个cell，cell中的数据即为每张图片提取出来的1x100特征。最后该结构体变量，以便构造贝叶斯分类器的时候调用。  
  
**featureData.mat**：上述save下来的结构体变量

**bayesClassifierBulid.m**：构造贝叶斯分类器，并返回label。具体原理可参考[CSDN博客](https://blog.csdn.net/weixin_39758398/article/details/86597147)的分类器设计部分。
**interface.m与interface.fig**：GUI文件。下面是GUI的界面：<div align=center><img width="500" height="500" src="https://github.com/GYee/Matlab-HandWriting_Number_Recognition/raw/master/GUI界面.png"/></div>
## 使用方法
将所有files下载放到同一个目录下，打开interface.m文件运行，会跳出一个GUI界面，然后在手写板上用鼠标写0-9其中一个数字，点击“确认”按钮即可。当想再次输入另外一个数字时，请先点击“清除”按钮。

因为训练集是我个人建的，且数量比较少，可能对其他人的手写数字识别的准确度不高，这时你可以自己建立训练集。具体方法为：打开GUI界面，在速写板上用鼠标写数字，点击“确认”，这时候会在文件夹目录下生成一个output.jpg图片，重命名（例如1-1.jpg）后放到TrainSet/1/文件夹中，以此类推，一个类别的训练图片数量不限，越多越好啦！

构建好TrainSet后，打开feature_struct_build.m文件，生成新的featureData.mat。

最后再次在GUI界面中输入手写数字，就能很好地识别啦！

***第一次写，很多不完善的地方，会慢慢改进，还望大家体谅啦哈哈哈哈！！！***
***代码和文字都是一个字一个字打出来的，非常不容易，转载请标明出处哦！***


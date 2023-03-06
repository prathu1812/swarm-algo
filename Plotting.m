clc;
clear all;

data = xlsread('50D_CEC14.xlsx');
x1 = data(:,7);
x2 = data(:,8);
[p,h]=signrank(x1,x2,'alpha',0.01)

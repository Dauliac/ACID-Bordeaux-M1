% transform data with arbitrary distribution to Gaussian distrubution
% written by Geoffrey Goldman, 4/6/2015

clear all
close all

% generate data

N=1000;  % number of data points
data=zeros(1,N);
data=randn(1,N/2) + 2;  % generate data for two Gaussians distriibutions
data(1,N/2+1:N)=randn(1,N/2) - 2;

figure
hist(data,50)
title('hist of data: two Gaussians')

% make linear array over range of data

peak=max(data); 
trough=min(data); 
inc=(peak-trough)/(N-1);
lin_array=trough:inc:peak;

% make pseudo CPDF 

sdata=sort(data);  % sort data

uniform_data=interp1(sdata,lin_array,data);  % transform to uniform distributed data
% warning, data now equal to values in lin_array
% normalize data between 0-1
u1_data=uniform_data/(max(uniform_data)-min(uniform_data));  
u1_data=u1_data -min(u1_data);

figure
hist(u1_data,50)
title('hist of data transformed to uniform')

% generate Gaussian pdf and cpdf

inc2=0.1;
lin2_array=-5:inc2:5;

gauss_array=(1/(2*pi))^0.5*exp(-((lin2_array-mean(lin2_array)).^2)/2);  %

area_1=sum(gauss_array)*inc2;  % check

cpdf_gauss=cumsum(gauss_array*inc2);  % cpdf

gauss_data=interp1(cpdf_gauss,lin2_array,u1_data);

figure
hist(gauss_data,50)
title('hist of data transformed to Gaussian')


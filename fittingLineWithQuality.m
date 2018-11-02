%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gamma calib

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% input variable %%%%%%%%%%%%%%%%
directoryName = 'testscene//4_20_250_unre3_15000g_paperboard//';
filesPath = strcat(directoryName,'daA*.*');
ROICenterX = 622;
ROICenterY = 368;
minStep = 20;
maxStep = 250;
stepSize = 4;
%%%%Read Images and extract ROI graylevel to Iout%%%
Files=dir(filesPath);
numOfData = length(Files);
Iin = double(zeros(1,length(Files)));
Iout =double(zeros(1,length(Files)));

for k=1:numOfData
 FileNames=Files(k).name;
 I=imread(strcat(directoryName,FileNames));
 pixelcount = 0;
 for h=-4:5
     for w=-4:5
         Iout(1,k)=Iout(1,k)+double(I(ROICenterY+h,ROICenterX+w));
         pixelcount = pixelcount + 1;
     end
 end
 Iout(1,k)=Iout(1,k)/pixelcount;
 Iin(1,k)= minStep + (k-1)*stepSize;
end

%%%%fitting%%%
p = polyfit(Iin,Iout,1);
fprintf('p = %f %f\n' ,p(1),p(2));

%%%%plotting%%%
figure
axes(); % produce plot window with axes
plot(Iin,Iout,'o');%Iin_x,Iout_y
ylabel('Ico');
xlabel('Ici');
hold on

Ii_max=max(Iin);
Ii_min=min(Iin);
x_fit = linspace( Ii_min ,Ii_max);
y_fit = polyval(p,x_fit);
plot(x_fit,y_fit,'r');
hold on

% get the root average square error 
totalSqError = 0;
for i=1:numOfData
    SinglePtErr = (p(1) * Iin(i) + p(2)) - Iout(i);
    sqSinglePtErr = SinglePtErr^2;
    totalSqError = totalSqError + sqSinglePtErr;
end
AvgSqErr = totalSqError / numOfData;
rootAvgSqError = sqrt(AvgSqErr);
err = rootAvgSqError;
fprintf('root average square error = %f\n',err );
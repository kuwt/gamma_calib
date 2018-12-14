%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gamma calib

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% input variable %%%%%%%%%%%%%%%%
directoryName = 'testscene//666//';
filesPath = strcat(directoryName,'0*.*');
ROICenterX = 622;
ROICenterY = 368;
minStep = 20;
maxStep = 250;
stepSize = 4;
%%%%Read Images and extract ROI graylevel to Iout%%%
Files=dir(filesPath);
Iin =double(zeros(1,length(Files)));
Iout =double(zeros(1,length(Files)));

for k=1:length(Files)
 if (k ~= 58)
    % continue;
 end
 FileNames=Files(k).name;
 fprintf('FileName = %s\n', FileNames);
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
 fprintf('imageId = %d Iin = %f  Iout = %f pixelcount = %d\n', k, Iin(1,k), Iout(1,k) ,pixelcount );
end

%%%%fitting%%%
p = polyfit(Iout,Iin,7);
fprintf('p = %f %f %f %f %f %f %f %f\n' ,p(1),p(2),p(3),p(4),p(5),p(6),p(7), p(8));

%%%%plotting%%%
figure
axes(); % produce plot window with axes
plot(Iout,Iin,'o');%Iin_x,Iout_y
ylabel('Ici');
xlabel('Ico');
hold on

Io_max=max(Iout);
Io_min=min(Iout);
x_fit = linspace( Io_min ,Io_max);
y_fit = polyval(p,x_fit);
plot(x_fit,y_fit,'r');
hold on

figure
axes(); % produce plot window with axes
plot(Iin,Iout,'o');%Iin_x,Iout_y
ylabel('Ico');
xlabel('Ici');
hold on

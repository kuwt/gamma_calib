
%%%%Read Images and extract ROI graylevel to Iout%%%
directoryName = 'testscene//4_12000//';
%filesPath = strcat(directoryName,'CamB*.*');
filesPath = strcat(directoryName,'daA*.*');
Files=dir(filesPath);
Iin =double(zeros(1,length(Files)));
Iout =double(zeros(1,length(Files)));
ROICenterX = 600;
ROICenterY = 250;

for k=1:length(Files)
 FileNames=Files(k).name;
 I=imread(strcat(directoryName,FileNames));
 pixelcount = 0;
 for h=-10:10
     for w=-10:10
         Iout(1,k)=Iout(1,k)+double(I(ROICenterY+h,ROICenterX+w));
         pixelcount = pixelcount + 1;
     end
 end
 Iout(1,k)=Iout(1,k)/pixelcount;
 Iin(1,k)=(k-1)*4;
end

%%%%fitting%%%
p = polyfit(Iout,Iin,7);

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
save('gamma_p.mat','p');

load('gamma_p');
stepSize = 4;
numOfStep = ceil(255/4);
ProjectSizeCols = 854
ProjectSizeRows = 480

Ico_min=43;
Ico_max=243.6;
Ici_min = 0;
Ici_max = 248;
k =(Ico_max-Ico_min)/(Ici_max - Ici_min);

for i=1:numOfStep
    Ig = 0 + (i -1) * stepSize;
    Ig = min(Ig,255);
    Ig = max(Ig,0);
    Igs = k * (Ig - Ico_min) + Ico_min;
    Id = uint8(p(1)*Igs^7 + p(2)*Igs^6 +p(3)*Igs^5 + p(4)*Igs^4 +p(5)*Igs^3 + p(6)*Igs^2+ p(7)*Igs + p(8));
    
    img= Id * uint8(ones(ProjectSizeRows,ProjectSizeCols,3));
    indx = sprintf('%02d',i - 1);
    imgName = strcat('lr_', indx, '.bmp')
    imwrite(img,imgName);
end
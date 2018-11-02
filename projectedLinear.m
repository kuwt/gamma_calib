stepSize = 4;
minStep = 20;
maxStep = 250;
numOfStep = ceil((maxStep-minStep)/4);
ProjectSizeCols = 854
ProjectSizeRows = 480


for i=1:numOfStep
    graylevel = minStep + (i - 1) * stepSize;
    graylevel = min(graylevel,255);
    graylevel = max(graylevel,0);
    img= graylevel * uint8(ones(ProjectSizeRows,ProjectSizeCols,3));
    indx = sprintf('%02d',i - 1);
    imgName = strcat('lr_', indx, '.bmp')
    imwrite(img,imgName);
end
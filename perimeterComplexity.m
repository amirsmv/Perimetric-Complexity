%% Perimetric Complexity
% Author : Amirhossein Samavi(amirhosseinsamavi79@gmail.com)
% DATE: 25th Jul 2021
function Su = SI (Ipath)
%% Read Data from Excel
data=xlsread('E:\hamidia project\Edited new DataBase\finalNewList.xlsx','A:A');
sources=readcell('E:\hamidia project\Edited new DataBase\finalNewList.xlsx','Range','B:B');
rawNames=readcell('E:\hamidia project\Edited new DataBase\finalNewList.xlsx','Range','C:C');
drifts=xlsread('E:\hamidia project\Edited new DataBase\finalNewList.xlsx','F:F');
counter = 1;
sources = string(sources);
rawNames = string(rawNames);
result = double([]);
%% Do untill end of data
while counter <= length(data)
    counter
    baseURL = 'E:\hamidia project\Edited new DataBase with Resized\';
    path = strcat(baseURL, num2str(data(counter)), '.bmp');
    %prepare image
    I=imread(path);
    I=im2bw(I,0.4);
    I=-I+1;
    [rows,cols] = size(I);
    %make a border with zero
    zerosCol = zeros(rows,1);
    zerosRow = zeros(1, cols+2);
    I = [zerosCol,I,zerosCol];
    I = [zerosRow;I;zerosRow];
    [rows,cols] = size(I);
    perimeter = 0;
    oneNum = 0;
    for i=1:rows
        for j=1:cols
            if I(i,j) == 1
                neighboursNum = 0;
                oneNum = oneNum + 1;
                %check right, left, top and bottom for counting zero neighbours
                if I(i+1,j) == 0 
                    neighboursNum = neighboursNum + 1; 
                end
                if I(i-1,j) == 0
                    neighboursNum = neighboursNum + 1; 
                end  
                if I(i,j+1) == 0
                    neighboursNum = neighboursNum + 1; 
                end
                if I(i,j-1) == 0
                    neighboursNum = neighboursNum + 1; 
                end
                %count all sides for computing the perimeter
                perimeter = perimeter + neighboursNum;
            end
        end
    end
    %compute index
    C = perimeter^2/(4*pi*oneNum);
    result(counter) = C;
    counter = counter + 1
end
%% export Output
output = [data, sources(2:end),rawNames(2:end),drifts,transpose(result)]
xlswrite('pc.xlsx', output);
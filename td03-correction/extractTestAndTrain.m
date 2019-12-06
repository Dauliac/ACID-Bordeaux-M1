function [Train,Test] = extractTestAndTrain(VT, sizeTrain)

    sizeVT = size(VT,1)
    
    Indices      = randperm(sizeVT);
    TrainIndices = Indices(1:sizeTrain);
    TestIndices  = Indices(sizeTrain+1:sizeVT);
        
    Train    = VT(TrainIndices,:);
    Test     = VT(TestIndices,:);
end


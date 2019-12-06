VT = load('VTSaumonBar3.mat');
disp(VT),
VTSaumon = VT.VTSaumon;
VTBar = VT.VTBar;

figure('Name', 'Normal distribution');
hold on;
% Sur la premiere dimension:
% Note remplacer X dans VTSaumon(:,X) pour les autres dimensions
% [Smu,Ssigma]=normfit(VTSaumon(:,1));
% [Bmu,Bsigma]=normfit(VTBar(:,1));
% 
% 
% sy = normpdf(VTSaumon(:,1),Smu, Ssigma);
% by = normpdf(VTBar(:,1),Bmu, Bsigma);
% 
% %fprintf('mu: %s\nsigma: %s\n',Smu, Ssigma)
% plot(VTSaumon(:,1),sy,'.');
% plot(VTBar(:,1),by,'.');

[muVector,sigmaVector]=normfit(VTSaumon());
y = normpdf(VTSaumon,muVector,sigmaVector);
fprintf('mu: %s\n',muVector)
plot(VTSaumon,y,'.');
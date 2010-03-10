function [linGrid,gridSize,xx,yy,zz] = prtPlotUtilGenerateGrid(plotMins, plotMaxs, PlotOptions)
% [linGrid,gridSize,xx,yy,zz] = prtPlotUtilGenerateGrid(plotMins, plotMaxs, PlotOptions)

xx = [];
yy = [];
zz = [];

nDims = length(plotMins);

switch nDims
    case 1
        xx = linspace(plotMins(1),plotMaxs(1),PlotOptions.nSamplesPerDim(nDims));
        linGrid = xx(:);
        gridSize = size(xx);
        yy = ones(size(xx));
    case 2
        [xx,yy] = meshgrid(linspace(plotMins(1),plotMaxs(1),PlotOptions.nSamplesPerDim(nDims)),...
            linspace(plotMins(2),plotMaxs(2),PlotOptions.nSamplesPerDim(nDims)));
        linGrid = [xx(:),yy(:)];
        gridSize = size(xx);
    case 3
        [xx,yy,zz] = meshgrid(linspace(plotMins(1),plotMaxs(1),PlotOptions.nSamplesPerDim(nDims)),...
            linspace(plotMins(2),plotMaxs(2),PlotOptions.nSamplesPerDim(nDims)),...
            linspace(plotMins(3),plotMaxs(3),PlotOptions.nSamplesPerDim(nDims)));
        gridSize = size(xx);
        linGrid = [xx(:), yy(:), zz(:)];
end

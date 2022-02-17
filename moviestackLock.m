function [] = moviestack(stacks,cycles,direction,map)


%MOVIESTACK and MOVIESTACKG

%DESCRIPTION:
    %these functions are for 2D visualizations of 3D volumes.  They will
    %scroll through orthogonal slices of an input 3D volume.
    
%NOTATION:
    %moviestack(stack,cycles,direction,map)
    
%INPUTS:
    %stack - 3D volume to be visualized
    %cycles - number of cycles through the volume.  Default is 10.
    %direction - specifies the direction which to scroll through the
        %volume.  Set to either 1, 2, or 3.  1 will scroll through the z
        %direction, 2 will scroll through the x direction and 3 will scroll
        %through the y direction.  Default is 1.
    %map - a string input specifying the colormap.  Some of the best are
    %'gray', 'jet', 'hot', and 'bone'.  Default is 'gray'.
    
    
%Written by: Toby Sanders @ Pacific Northwest National Laboratory
%Computational & Applied Mathematics Department, Univ. of South Carolina
%7/11/2014

%last update: 02/26/2016

% if nargin<2, maxP = 1; end
if ~exist('direction','var')
    direction=1;
end
if ~exist('cycles','var')
    cycles=10;
end
if ~exist('map','var')
    map = 'gray';
elseif ~ischar(map)
    map = 'gray';
elseif ~sum(strcmp(map,{'jet','gray','hot','bone','cool','hsv','spring',...
        'summer','autumn','winter','copper','pink','lines','parula'}))
    map = 'gray';
end

if ~isa(stacks,'cell')
    stacks = {stacks};
end


figure(randi(100));tiledlayout(1,numel(stacks),'tilespacing','none');
tt = cell(numel(stacks),1);
tt2 = [];
for i = 1:numel(stacks)
    tt{i} = nexttile;
    tt2(i) = tt{i};
    imagesc(stacks{i}(:,:,1));
    colormap(map);colorbar;
end
linkaxes(tt2);

for i = 1:cycles
    if mod(i,2)==1
        for j = 1:size(stacks{1},3)
            for k = 1:numel(stacks)
                SetAxesCData(tt{k},stacks{k}(:,:,j));
                set(tt{k}.Title,'String',num2str(j));
%                 figure(k);imagesc(stacks{k}(:,:,j));
%                 colormap(map);colorbar;
%                 title(j);
            end
            pause;
        end
    else
        for j = size(stacks{1},3):-1:1
            for k = 1:numel(stacks)
                SetAxesCData(tt{k},stacks{k}(:,:,j));
                set(tt{k}.Title,'String',num2str(j));
            end
            pause;
        end
    end
end


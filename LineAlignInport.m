%% Function align line and its imediate source block_

function SrcBlockHandle = LineAlignInport(MotherBlock,dx,dy)

SrcBlockHandle = [];


% get ports from selected subsystem (motherBlock)
PortHandles = get_param(MotherBlock,'PortConnectivity');
LineHandles = get_param(MotherBlock,'LineHandles');

[PortPositions, Inp_idx, ~] =  CountPorts(PortHandles,'Inport');


    % set the lines straight and aligned to the block inports
    for i=1:length(LineHandles.Inport)
         % Align Inport connected to this line, if condition is incase one line is diverging in to two sources
        if numel(get_param(LineHandles.Inport(1,i),'SrcBlockHandle')) == 1
            SrcBlockHandle(i) = get_param(LineHandles.Inport(1,i),'SrcBlockHandle');
        else
            SrcBlockHandleTmp = get_param(LineHandles.Inport(1,i),'SrcBlockHandle'); 
            SrcBlockHandle(i) = SrcBlockHandleTmp(1);
        end
        SrcBlockPos = get_param(SrcBlockHandle(i),'Position');
        SrcBlockPortHandles = get_param(SrcBlockHandle(i),'PortConnectivity');
        [~, SrcInp_idx, ~] =  CountPorts(SrcBlockPortHandles,'Inport');
        SrcInp_idx = SrcInp_idx;
        SrcBlockSize = max(dy*length(SrcInp_idx), 10);
        set_param(SrcBlockHandle(i),'Position',[PortPositions(Inp_idx(i),1)-dx   PortPositions(Inp_idx(i),2)-SrcBlockSize/2   PortPositions(Inp_idx(i),1)- dx + abs(SrcBlockPos(1,1)-SrcBlockPos(1,3))   PortPositions(Inp_idx(i),2)+SrcBlockSize/2]);
           
        
        % Aling all points of the line to straighten it
        LinePoints = get_param(LineHandles.Inport(1,i),'points');
        Num_Points = size(LinePoints,1); % check how many points a line have
        for l = 1:Num_Points
            %LinePoints(l,2)= PortPositions(i,2); % align all points of line to port y position
            set_param(LineHandles.Inport(1,i),'points',[0 0; 0 0]); % magic matrix for straightning the line
        end

    end

    
end
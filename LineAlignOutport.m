% set the lines straight and aligned to block outports
function DstBlockHandle = LineAlignOutport(MotherBlock,dx,dy)

DstBlockHandle = [];

% get ports from selected subsystem
PortHandles = get_param(MotherBlock,'PortConnectivity');
LineHandles = get_param(MotherBlock,'LineHandles');

% Identify Postion and Type of each port
[PortPositions,~, Outp_idx] =  CountPorts(PortHandles,'Outport');
   
    
% Align ports and lines to Motherblock   
    for i=1:length(LineHandles.Outport)
            % Align Outport connected to this line, line feeding two blocks has two dsblockhandles which creates error if not handled
            if numel(get_param(LineHandles.Outport(1,i),'DstBlockHandle')) == 1
                 DstBlockHandle(i) = get_param(LineHandles.Outport(1,i),'DstBlockHandle');
            else
                 DstBlockHandleTmp = get_param(LineHandles.Outport(1,i),'DstBlockHandle');
                 DstBlockHandle(i) = DstBlockHandleTmp(1); % take the first only for now
            end
            DstBlockPos = get_param(DstBlockHandle(i),'Position');
            DstBlockPortHandles = get_param(DstBlockHandle(i),'PortConnectivity');
            [~,~,  DstOutp_idx] =  CountPorts(DstBlockPortHandles,'Outport');
            DstBlockSize = max(dy*length(DstOutp_idx),10);
            set_param(DstBlockHandle(i),'Position',[PortPositions(Outp_idx(i),1)+dx PortPositions(Outp_idx(i),2)-DstBlockSize/2 PortPositions(Outp_idx(i),1)+dx+abs(DstBlockPos(1,1)-DstBlockPos(1,3)) PortPositions(Outp_idx(i),2)+DstBlockSize/2]);
            
            % align all points of the line to be straight
            LinePoints = get_param(LineHandles.Outport(1,i),'points');
            Num_Points = size(LinePoints,2); % check how many points a line have
            for l = 1:Num_Points
                LinePoints(l,2)= PortPositions(i,2); % align all points of line to port y position
                set_param(LineHandles.Outport(1,i),'points',[0 0; 0 0]); % magic matrix for straightning the line
            end
    end
end
% TEst TEst
%% Simulation port aling main function

% Resources
%get_param(LineHandle.Inport(1,1),'objectparameters') %lists possible parameters


%% Start of program

dx = 100;    % horizontal separation between main subsystem and next connected port
dy = 20;

% matrix to contain all blocks with in the system, iteratively updated
SrcBlockContainer = [];
DstBlockContainer = [];

MotherBlockHandle = get_param(gcb,'Handle');

SrcBlockContainer = [SrcBlockContainer MotherBlockHandle];
DstBlockContainer = [DstBlockContainer MotherBlockHandle];



%INPORTS
while ~isempty(SrcBlockContainer) % for each block attached to input of motherblock
    
    SrcBlockContainer = [SrcBlockContainer LineAlignInport(SrcBlockContainer(1),dx,dy)];
        
    SrcBlockContainer = SrcBlockContainer(2:end); % This block already aligned so remove it from this container
    
    
end
         
%OUTPORTS
while ~isempty(DstBlockContainer) % for each block attached to input of motherblock
    
    DstBlockContainer = [DstBlockContainer LineAlignOutport(DstBlockContainer(1),dx,dy)];
    
    DstBlockContainer = DstBlockContainer(2:end);
    
end   




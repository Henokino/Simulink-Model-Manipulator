%% fucntion CountPorts
%experimenting with Git, commit(=merge) make direct changes to master branch (trunk)

function [PortPositions, Inp_idx, Outp_idx] = CountPorts(PortHandles,TypeOfPort)
 
Outp_idx = [];
Inp_idx = [];
for i=1:length(PortHandles)
        PortPositions(i,:) = PortHandles(i,1).Position;
        if strcmp(TypeOfPort,'Outport')
            if isempty(PortHandles(i,1).SrcPort)
                Outp_idx = [Outp_idx i];
            end
        elseif strcmp(TypeOfPort,'Inport')     
            if isempty(PortHandles(i,1).DstPort)
                Inp_idx = [Inp_idx i];
            end  
        end
end

end
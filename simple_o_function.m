function [y, newX, cantV, distanceT] = simple_o_function( x )
    global CantP CantV CV D DT MDist Rule
    pVisited=zeros(1,CantP);
    newX = [];
    inicio = 1;
    cantV=0;
    demandT=0;
    distanceT=0;
    distances = [];
    for i=1:CantV
        vehicle=x(inicio:(inicio+CantP-1));
        vehicle=round(vehicle);
        inicio=inicio+CantP;
        demand=0;
        distance = 0;
        if vehicle(1)>0
            vehicle(1) = 1;
            nVisited=[];
            for j=2:CantP
                try
                    if vehicle(j)> 0
                        if pVisited(vehicle(j))==0 && demand+D(vehicle(j))<=CV
                            demand=demand+D(vehicle(j));
                            pVisited(vehicle(j))=1;
                            nVisited=[nVisited vehicle(j)];
                        else
                            vehicle(j) = 0;
                        end                        
                    end
                catch err                    
                    err
                end
            end  
            for k=1:length(nVisited);
                if k==1
                    distance = distance + MDist(1,nVisited(k));                    
                else
                    distance = distance + MDist(nVisited(k-1),nVisited(k));                    
                end                
            end            
            if isempty(nVisited)==0
                cantV=cantV+1;
                distances=[distances distance];
            end            
        end
        newX = [newX vehicle];        
        distanceT=distanceT+distance;
        demandT=demandT+demand;       
    end
    y = Inf;
    feas = (demandT==DT);
    if(distanceT > 0 && feas)
        y = (cantV*Rule) + distanceT;
    end    
end
function [Dist, totalD] = dist( Puntos )
    [CantP,~]=size(Puntos);
    Dist=zeros(CantP,CantP);
    totalD=0;
    for i=1:CantP
        p1=Puntos(i,:);
        for j=i+1:CantP
            p2=Puntos(j,:);
            d=sqrt(((p2(1)-p1(1))^2)+((p2(2)-p1(2))^2));
            Dist(i,j)=d;
            totalD=totalD+d;
            Dist(j,i)=d;
        end
    end
end


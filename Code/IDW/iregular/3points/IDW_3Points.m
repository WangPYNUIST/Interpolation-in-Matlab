function z=IDW_3Points(x,y,Control_Points,method)
method=method-1;
if method==0;
    msgbox('Please select a weight formula','unselected field');
    z='Not defined';
else
dt=DelaunayTri(Control_Points(:,2),Control_Points(:,3));
Table(:,2:4)=dt.Triangulation;
[row col]=size(dt.Triangulation);
Table(:,1)=1:row;
DataStructure=DataStructure_Fnc(Table);
Triangle=Walking_Fnc(x,y,DataStructure,Control_Points);
if Triangle==0
    msgbox('Please Enter coordinates in the range','Out of range');
    z='Not computed'
else
Ed1=Table(Triangle,2);Ed2=Table(Triangle,3);Ed3=Table(Triangle,4);
points=[Control_Points(Ed1,2),Control_Points(Ed1,3);
        Control_Points(Ed2,2),Control_Points(Ed2,3);
        Control_Points(Ed3,2),Control_Points(Ed3,3)];
Z=[Control_Points(Ed1,4),Control_Points(Ed2,4),Control_Points(Ed3,4)];
Dist=Distance(x,y,points);
if Dist(1)==0
    z=Z(1);
elseif Dist(2)==0
    z=Z(2);
elseif Dist(3)==0
    z=Z(3);
else
switch method 
    case 1
        Weight=Dist.*0+1;
    case 2
        Weight=1./Dist;
    case 3
        Weight=1./Dist.^2;
    case 4
        Weight=1./Dist.^3;
    case 5
        Weight=1./(1+Dist);
    case 6
        Weight=1./(1+Dist.^2);
    case 7
        Weight=exp(-Dist);
    case 8
        Weight=exp(-Dist.^2)
end
z=(Weight*Z')/sum(Weight);
end
end
end
function [z,RMSE_control,max_control_error,min_control_error]=SecondExactFit_main_FNC(x,y,Control_Points)
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
linear=-1;
for ii=1:3
    temp1=DataStructure(Triangle,ii+1);
    temp2=DataStructure(Triangle,ii+4);
    if temp2==-1;
        linear=1;
        break;
    end
    temp3=find(DataStructure(temp2,5:7)==Triangle);
    if temp3==1
        temp4(ii)=DataStructure(temp2,temp3+1);
    elseif temp3==2
        temp4(ii)=DataStructure(temp2,temp3+1);
    elseif temp3==3
        temp4(ii)=DataStructure(temp2,temp3+1);
    end
end
if linear==-1
Ed4=temp4(1);Ed5=temp4(2);Ed6=temp4(3);
A=[1,Control_Points(Ed1,2),Control_Points(Ed1,3),Control_Points(Ed1,2)^2,Control_Points(Ed1,2)*Control_Points(Ed1,3),Control_Points(Ed1,3)^2;...
   1,Control_Points(Ed2,2),Control_Points(Ed2,3),Control_Points(Ed2,2)^2,Control_Points(Ed2,2)*Control_Points(Ed2,3),Control_Points(Ed2,3)^2;...
   1,Control_Points(Ed3,2),Control_Points(Ed3,3),Control_Points(Ed3,2)^2,Control_Points(Ed3,2)*Control_Points(Ed3,3),Control_Points(Ed3,3)^2;...
   1,Control_Points(Ed4,2),Control_Points(Ed4,3),Control_Points(Ed4,2)^2,Control_Points(Ed4,2)*Control_Points(Ed4,3),Control_Points(Ed4,3)^2;...
   1,Control_Points(Ed5,2),Control_Points(Ed5,3),Control_Points(Ed5,2)^2,Control_Points(Ed5,2)*Control_Points(Ed5,3),Control_Points(Ed5,3)^2;...
   1,Control_Points(Ed6,2),Control_Points(Ed6,3),Control_Points(Ed6,2)^2,Control_Points(Ed6,2)*Control_Points(Ed6,3),Control_Points(Ed6,3)^2];
L=[Control_Points(Ed1,4),Control_Points(Ed2,4),Control_Points(Ed3,4),Control_Points(Ed4,4),Control_Points(Ed5,4),Control_Points(Ed6,4)]';
Parameters=inv(A)*L;
z=[1 x y x^2 x*y y^2]*Parameters;
else
    [z,RMSE_control,max_control_error,min_control_error]=Linear_main_FNC(x,y,Control_Points)
end
end
RMSE_control=0;max_control_error=0;min_control_error=0;
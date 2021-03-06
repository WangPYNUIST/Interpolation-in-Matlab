function [z,RMSE_control,max_control_error,min_control_error]=Linear_main_FNC(x,y,Control_Points)
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
A=[1,Control_Points(Ed1,2),Control_Points(Ed1,3);...
   1,Control_Points(Ed2,2),Control_Points(Ed2,3);...
   1,Control_Points(Ed3,2),Control_Points(Ed3,3)];
L=[Control_Points(Ed1,4),Control_Points(Ed2,4),Control_Points(Ed3,4)]';
Parameters=inv(A)*L;
z=[1 x y]*Parameters;
end
RMSE_control=0;max_control_error=0;min_control_error=0;


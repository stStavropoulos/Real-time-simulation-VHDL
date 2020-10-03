library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.readdatapart1.all;

entity Partition is

generic(width: natural := 34;epec : natural := 70;fl : integer := 22);

Port (
clk : in std_logic;
Time_step : in integer range 2 to 5;
connection_factor : in integer range -1 to 1;
Vp,u_past,u,IL  : in std_logic_vector(width downto 0);
V_past :in bk;
V:out bk
      );     
end Partition;



architecture Behavioral of Partition is
signal infos: matrix := readmatrix("C:/Users/StevenStav/Desktop/Partition_final/Partition_final.srcs/sim_1/imports/Final_Project/Final_Project.sim/sim_1/behav/xsim/A1.txt");
signal c_numbers:single :=readmatrix3("C:/Users/StevenStav/Desktop/Partition_final/Partition_final.srcs/sim_1/imports/Final_Project/Final_Project.srcs/sim_1/imports/Files_unpartitioned/CT_numbers1.txt");
signal RL1,RL2,Gs,R,Geff: signed(width downto 0);
signal A: A0;
signal V_temp1,V_temp2,V_temp3,b_temp1,b_temp2,b_temp3,u_temp,cf_temp1,cf_temp2,cf_temp3,il_past:signed (epec-1 downto 0);
signal temp_i1,temp_i2,temp1,temp3 :signed(epec-1 downto 0);
signal temp2,temp4 :signed(epec-1 downto 0);

begin
RL1<=signed(c_numbers(1));RL2<=signed(c_numbers(1));Gs<=signed(c_numbers(2));R<=signed(c_numbers(3));Geff<=signed(c_numbers(4));
A(1,1)<= signed(infos(1));A(1,2)<= signed(infos(4));A(1,3)<= signed(infos(7));
A(2,1)<= signed(infos(2));A(2,2)<= signed(infos(5));A(2,3)<= signed(infos(8));
A(3,1)<= signed(infos(3));A(3,2)<= signed(infos(6));A(3,3)<= signed(infos(9));

il_past<= resize(signed(IL),70);
temp_i1<=Geff*(signed(V_past(2)) - signed(V_past(3)))+il_past(width downto 0) ;


u_temp<=resize(connection_factor*signed(u_past),70);
b_temp1<=resize(Time_step*signed(Vp)*Gs,70);
b_temp2<=resize((-1)*temp_i1,70);
b_temp3<=resize(temp_i1-u_temp(34 downto 0),70);

cf_temp1<=resize(connection_factor*signed(A(1,1))*signed(u),70);
cf_temp2<=resize(connection_factor*signed(A(2,2))*signed(u),70);
cf_temp3<=resize(connection_factor*signed(A(3,3))*signed(u),70);

V_temp1<=A(1,1)*signed(b_temp1(fl-1+width downto fl-1))+A(1,2)*signed(b_temp2(fl+width downto fl))+A(1,3)*signed(b_temp3(width downto 0));
V_temp2<=A(2,1)*signed(b_temp1(fl-1+width downto fl-1))+A(2,2)*signed(b_temp2(fl+width downto fl))+A(2,3)*signed(b_temp3(width downto 0));
V_temp3<=A(3,1)*signed(b_temp1(fl-1+width downto fl-1))+A(3,2)*signed(b_temp2(fl+width downto fl))+A(3,3)*signed(b_temp3(width downto 0));
 
--temp3<=(V_temp2(fl+1+width downto fl+1)-cf_temp2(fl-1+width downto fl-1)) -(V_temp3(fl+1+width downto fl+1)-cf_temp3(fl+width downto fl));
--temp4<=Geff*temp3;
--temp_i2<=temp4(width+fl+2 downto fl+2) + temp_i1;   
      
temp_i2<=Geff*((V_temp2(fl+1+width downto fl+1)-cf_temp2(fl-1+width downto fl-1)) -(V_temp3(fl+1+width downto fl+1)-cf_temp3(fl+width downto fl))) + temp_i1(width-1+fl downto fl-1);


V(1)<=std_logic_vector(V_temp1(fl+width downto fl)-cf_temp1(fl-1+width downto fl-1));V(2)<=std_logic_vector(V_temp2(fl+width downto fl)-cf_temp2(fl-1+width downto fl-1));V(3)<=std_logic_vector(V_temp3(fl+width downto fl)-cf_temp3(fl-1+width downto fl-1));

            
end Behavioral;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Readdata.all;

entity Unpartitioned is

generic(width: natural := 34; exten : natural := 70;fl : integer := 22);

Port (

step : in integer range 1 to 5;
IL1,IL2  : in std_logic_vector(width downto 0);
V_in:in b1;
V_out:out b1

      );
          
end Unpartitioned;

architecture behave of Unpartitioned is

signal infos: matrix := readmatrix("CT_matrix.txt");
signal c_numbers: single :=readmatrix3("CT_numbers.txt");
signal Rl1,RL2,Gs,R,Geff,Vstable1,Vstable2,Vp1,Vp2: signed(width downto 0);
signal A: A2 ;
signal temp_i1,temp_i2,temp_i3,temp_i4 :signed (width downto 0) := (others => '0');
signal V_temp1,V_temp2,V_temp3,V_temp4,V_temp5,b_temp1,b_temp2,b_temp3,b_temp4,b_temp5:signed (exten-1 downto 0) := (others => '0');
signal temp1,temp3,temp5,temp7 :signed(width downto 0);
signal temp2,temp4,temp6,temp8 :signed(exten-1 downto 0);

begin

-- initialization

RL1<=signed(c_numbers(1));RL2<=signed(c_numbers(1));
Gs<=signed(c_numbers(2));R<=signed(c_numbers(3));Geff<=signed(c_numbers(4));
Vstable1<=signed(c_numbers(5));Vstable2<=signed(c_numbers(6));
A(1,1)<= signed(infos(1));A(1,2)<= signed(infos(2));A(1,3)<= signed(infos(3));A(1,4)<= signed(infos(4));A(1,5)<= signed(infos(5));
A(2,1)<= signed(infos(6));A(2,2)<= signed(infos(7));A(2,3)<= signed(infos(8));A(2,4)<= signed(infos(9));A(2,5)<= signed(infos(10));
A(3,1)<= signed(infos(11));A(3,2)<= signed(infos(12));A(3,3)<= signed(infos(13));A(3,4)<= signed(infos(14));A(3,5)<= signed(infos(15));
A(4,1)<= signed(infos(16));A(4,2)<= signed(infos(17));A(4,3)<= signed(infos(18));A(4,4)<= signed(infos(19));A(4,5)<= signed(infos(20));
A(5,1)<= signed(infos(21));A(5,2)<= signed(infos(22));A(5,3)<= signed(infos(23));A(5,4)<= signed(infos(24));A(5,5)<= signed(infos(25)); 
            
-- implementation
     
temp1<= (signed(V_in(3)) - signed(V_in(5)));
temp2<= Geff*temp1;     
temp_i1<= temp2(width+fl+2 downto fl+2) + signed(IL1);

temp3<=(signed(V_in(4)) - signed(V_in(5)));
temp4<=Geff*temp3;
temp_i2<=temp4(width+fl+2 downto fl+2) + signed(IL2);


Vp1<=resize(signed(step*Vstable1),35);
Vp2<=resize(signed(step*Vstable2),35);


b_temp1<=signed(Vp1)*Gs;
b_temp2<=signed(Vp2)*Gs;
b_temp3<=resize((-1)*temp_i1,70);
b_temp4<=resize((-1)*temp_i2,70);
b_temp5<=resize(temp_i1 + temp_i2,70);           


V_temp1<=A(1,1)*signed(b_temp1(fl-1+width downto fl-1))+A(1,2)*signed(b_temp2(fl-1+width downto fl-1))+A(1,3)*signed(b_temp3(fl-1+width downto fl-1))+A(1,4)*signed(b_temp4(fl-1+width downto fl-1))+A(1,5)*signed(b_temp5(fl-1+width downto fl-1));
V_temp2<=A(2,1)*signed(b_temp1(fl-1+width downto fl-1))+A(2,2)*signed(b_temp2(fl-1+width downto fl-1))+A(2,3)*signed(b_temp3(fl-1+width downto fl-1))+A(2,4)*signed(b_temp4(fl-1+width downto fl-1))+A(2,5)*signed(b_temp5(fl-1+width downto fl-1));
V_temp3<=A(3,1)*signed(b_temp1(fl-1+width downto fl-1))+A(3,2)*signed(b_temp2(fl-1+width downto fl-1))+A(3,3)*signed(b_temp3(fl-1+width downto fl-1))+A(3,4)*signed(b_temp4(fl-1+width downto fl-1))+A(3,5)*signed(b_temp5(fl-1+width downto fl-1));
V_temp4<=A(4,1)*signed(b_temp1(fl-1+width downto fl-1))+A(4,2)*signed(b_temp2(fl-1+width downto fl-1))+A(4,3)*signed(b_temp3(fl-1+width downto fl-1))+A(4,4)*signed(b_temp4(fl-1+width downto fl-1))+A(4,5)*signed(b_temp5(fl-1+width downto fl-1));
V_temp5<=A(5,1)*signed(b_temp1(fl-1+width downto fl-1))+A(5,2)*signed(b_temp2(fl-1+width downto fl-1))+A(5,3)*signed(b_temp3(fl-1+width downto fl-1))+A(5,4)*signed(b_temp4(fl-1+width downto fl-1))+A(5,5)*signed(b_temp5(fl-1+width downto fl-1));


temp5<=(V_temp3(fl+width downto fl) - V_temp5(fl+width downto fl));
temp6<=Geff*temp5;
temp_i3<=temp6(width+fl+2 downto fl+2) + temp_i1;


temp7<=(V_temp4(fl+width downto fl) - V_temp5(fl+width downto fl));
temp8<=Geff*temp7 ;
temp_i4<=temp8(width+fl+2 downto fl+2)+ temp_i2;
 
         
-- outputs

V_out(1)<=std_logic_vector(V_temp1(fl+1+width downto fl+1));
V_out(2)<=std_logic_vector(V_temp2(fl+1+width downto fl+1));
V_out(3)<=std_logic_vector(V_temp3(fl+1+width downto fl+1));
V_out(4)<=std_logic_vector(V_temp4(fl+1+width downto fl+1));
V_out(5)<=std_logic_vector(V_temp5(fl+1+width downto fl+1));

             

end behave;
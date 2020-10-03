library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

Package Readdata is

type b1 is array (1 to 5) of std_logic_vector(34 downto 0);
type A2 is array (1 to 5,1 to 5) of signed(34 downto 0);
type b2 is array (1 to 3) of std_logic_vector(34 downto 0);

-- the dimensions of the matrices that will be used
type matrix is array (1 to 25) of std_logic_vector(34 downto 0);
type single is array(1 to 6) of std_logic_vector(34 downto 0);
type values is array(1 to 28) of std_logic_vector(34 downto 0);

impure function readmatrix(constant MatFilename: in string) return matrix; 
impure function readmatrix3 (constant MatFilename : in string) return single ;
impure function readmatrix4 (constant MatFilename : in string) return values ;

end Readdata;

Package body Readdata is

impure function readmatrix (constant MatFilename : in string) return matrix is
FILE MatFile : text is in MatFileName;
variable MatFileLine : line;
variable Mat : matrix;

begin
for i in 1 to 25 loop
readline (MatFile, MatFileLine);
read (MatFileLine, Mat(i));
end loop;
return Mat;
end function; 


impure function readmatrix3 (constant MatFilename : in string) return single is
FILE MatFile : text is in MatFileName;
variable MatFileLine : line;
variable Mat_p : single;
begin
for i in 1 to 6 loop
readline (MatFile, MatFileLine);
read (MatFileLine, Mat_p(i));
end loop;
return Mat_p;
end function; 


impure function readmatrix4 (constant MatFilename : in string) return values is
FILE MatFile : text is in MatFileName;
variable MatFileLine : line;
variable Mat_p : values;
begin
for i in 1 to 28 loop
readline (MatFile, MatFileLine);
read (MatFileLine, Mat_p(i));
end loop;
return Mat_p;
end function; 


end Readdata;
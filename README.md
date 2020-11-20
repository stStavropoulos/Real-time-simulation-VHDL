# Real-time-simulation-VHDL
Here is the second part of the Smart grid repository created in Vivado and it has as a purpose the Real-time simulation of a small-scale grid, utilizing files from the Matlab environment.

Power  system  partitioning  is  mainly  used  to  split  the  network in subnetworks, which can be independently calculated and  served  by  different  threads  in  a  multi-core  architecture. Each thread is assigned with the calculation of the output of one subnetwork resulting in a parallel architecture and a significant decrease to the computation time. The optimal number of partitions and partition points is an ongoing research topic. Poor choice of the above can lead to sub-optimal simulation performance. There  are  several  partitioning  techniques,  which  can  be employed to partition a power grid. In this project, the node tearing partitioning technique is used. 

# Node Tearing Method:
![alt text](https://ibb.co/wgvGzF7)
![alt text](https://ibb.co/hLKGk6B)

# Test microgrid partitioned into 2 segments and implemented onto the FPGA:
![alt text](https://ibb.co/Vxcq20X)

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2023 10:08:23 PM
// Design Name: 
// Module Name: traffic_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_tb;
parameter ENDTIME  = 40000;

	reg clk;
	reg rst_n;
	reg sensor;
	wire [2:0] light_farm;
	wire [2:0] light_highway;

//DUT Instantiation
	traffic_light test(light_highway, light_farm, sensor, clk, rst_n);

//Initial Conditions

	initial
		 begin
		 clk = 1'b0;
		 rst_n = 1'b0;
		 sensor = 1'b0;

		 end
	initial
		  begin
		   $dumpfile("tlc_out.vcd");
		   $dumpvars(0, iiitb_tlc_tb);
	  	  end
//Generating Test Vectors

	always #1 clk = !clk;
	initial
		begin
			rst_n = 0;
			sensor = 0;
			#60
			sensor = 1;
			# 140
			rst_n = 1;
			#120
			sensor = 0;
			#120
			sensor = 1;
			#120 sensor = 0;
			#120 sensor = 1;
			#120 sensor = 0;
			#120 sensor = 1;
			#1000
			sensor = 0;
		end
//Debug output

	initial
		begin
			$display("----------------------------------------------");
			$display("------------------     -----------------------");
	 		$display("----------- SIMULATION RESULT ----------------");
	  		$display("--------------             -------------------");
			$display("----------------         ---------------------");
			$display("----------------------------------------------");
			$monitor("TIME = %d, reset = %b, sensor = %b, light of highway = %h, light of farm road = %h",$time,rst_n ,sensor,light_highway,light_farm );
		end

	initial
		begin
			 #ENDTIME
			 $display("-------------- THE SIMUALTION END ------------");
			 $finish;
	 	end
endmodule

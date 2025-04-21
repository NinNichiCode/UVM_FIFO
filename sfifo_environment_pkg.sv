`include "sfifo_agent_pkg.sv"

package sfifo_environment_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	import sfifo_agent_pkg::*;
	`include "sfifo_scoreboard.svh"
	`include "sfifo_coverage.svh"
	`include "sfifo_environment.svh"
endpackage
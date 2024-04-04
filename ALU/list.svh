`include "uvm_pkg.sv"
import uvm_pkg::*;

typedef class alu_tx;
typedef class alu_common;
typedef class alu_sqr;
typedef class alu_drv;
typedef class alu_mon;
typedef class alu_cov;
typedef class alu_agent;
typedef class alu_sbd;
typedef class alu_env;

`include "alu_design.v"
`include "alu_common.sv"
`include "alu_intfc.sv"
`include "alu_tx.sv"
`include "alu_sqr.sv"
`include "seq_lib.sv"
`include "alu_drv.sv"
`include "alu_mon.sv"
`include "alu_cov.sv"
`include "alu_agent.sv"
`include "alu_sbd.sv"
`include "alu_env.sv"
`include "test_lib.sv"
`include "top.sv"

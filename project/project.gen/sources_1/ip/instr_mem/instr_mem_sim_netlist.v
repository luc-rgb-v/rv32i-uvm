// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Mon Nov 17 08:44:43 2025
// Host        : DESKTOP-JFVD931 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Github/repositories/rv32i-uvm/project/project.gen/sources_1/ip/instr_mem/instr_mem_sim_netlist.v
// Design      : instr_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "instr_mem,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module instr_mem
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [9:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     1.40565 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "instr_mem.mem" *) 
  (* C_INIT_FILE_NAME = "instr_mem.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1023" *) 
  (* C_READ_DEPTH_B = "1023" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1023" *) 
  (* C_WRITE_DEPTH_B = "1023" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  instr_mem_blk_mem_gen_v8_4_11 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
gydSV72FvW4hnoyUt6yZFJHfJqjRQWPUfYIuDKP0fpjrPOkLRbJGBr4Z9msYTvoIHRlYtXJ2YMY0
d1TIQb+FK4gKsTRru9wr397OxuFBsTRf4e+ZjpYZEdsnqYWcgMSzhN4yhPvO06GyZO15y/LKBxa8
3OKwxVlOLYXhv+sxdXg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
WHB6Zbfa5Qi47krP9T4L8UnPOlr881dWx7UcYaZfNGIQQM0gadcoXbhucIpRaUuyOKxv6yhKveRN
h0l+N9+KX6rbZ6+TRhP9JAMuPhlpI7T42QtRv5zx9+m3ct5S0NMszbFaK8zeTAYra5BGP7BHmtkr
MpKfLK5sFyaTE/A7ACtAace9MwFTHDZdl9uUs4aY6KJlm6GaypKduiqkNugukJp5vlFPX/ZapJqG
KMtMhI6grhcuYb1FJrwRZ4jW7hs9HxddSdGLzsZ0HsBcO/qaCPTst+ZA0YIQfd5ULlFmPqq39FfO
p1P+2hEH2n+LycbMj5cn4Dxfqv2R8eucM78R3w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
SmAzQA1VEuJXtJi5vXa2Jg7YvRqAJs6PX9HTZ1YqrJw4VfonBW3726gJ81BjlizpMkcf/Uk5sFIK
aPedVhEs4xCIZylz7gXYDshtytOA/pXUID2qV9nXr8qfI+FydSADUF3ScYDZmlkclFqlZrGq6DQ7
da3lJAzt2h/iR+cczrA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
iAph5JWb/chMQpLPX1UoLjQDxN5l2I8McM/k2xN5wRht7HXoE6F5yV8luDjn3zkI6vnfUYo7BaI1
mogRRx+R3XcwxvhHr+lngh4+/YLVex1TFncl+kiUMAsu3M/FjFSiqGMVMdKTNLDqr35DuZJVyuiF
lTwXob/KkbQDJiJjBEoxbt+968rKRKRyJGcqIjm4mqRBdqMcgo3HOJFG74SFsWAQrxvXfBhdLSG3
OfoLfls9XDojBjp7G83k0h82g1eeWgBfydm/OcX9o48Pst93NvI4ua8WShZL8MCvRWYqWZrrjrWi
cfUjXAF5SDACjq1/OU6arz/Idz6/a7AP/jmexw==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BY49GZBxBT/gjZDPyaSWlti/sctckoR7jK6NuWdhnF9tiyNfVU7BqjjwxSnyMi0Uucv1BKHXC18h
8hQbFWnNtrq71ilURotXux7sssHlVJ2i1CsJWU18DOcBWxm2ai89uwvxDJh3TJkBJixB5KPvsDhL
lWOjTvZWPoR+Ixy+Tzo+U5Vx7z7SOakRwTrn3u7+c3vmCEBphE+HKeJExhBAoOEd0SXK5iwXaByW
D7Wb7zq6NNUmnCyaJ2BG9kGxLVsf+md7SlocuaFsYyaRZhwPyTucxIlz1tLYwcytKzx0ovoax3no
nYgzlzP/F0/PDWk9BqXgr/tuclc4EZYX0cf4ng==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qGnCvL35qO7cbUEKCL50yDv1UvezcqBz601zctKop1954QlcjemzZWZHg1zJ00nJaToNdH2S8AKX
n8hNJvbQ+x5HEGL5DoSU9m5qjXd8xxocnZ0yzuZX/dGCT8kDn3gWJR2Gz13pT+w2LQUno1fX+MsC
ehgwvjBBT6GeYjdxHi+aybQUP9AblSxX/z3vh857SGCPohEWvghOgORCHAe45YD+ZWnL62FLxMM2
c+Ozq/Au/Q4q1Yzlzcfv8Mnsvg7OqOeEamQHbuYOfdkJUuYqOwsskEWW348u7FXtsf8m7P3pZyyz
IWyTDAW4igGguMPLHfbtK/twZx8ScJQmOKzglg==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hz+6K8+wh5/fukU4ZWNDXGsq6hreSVCSPP67nA6kUz9Vpjy4TtTnOrrl1BWY0ivEC7Ldyw8VI60A
VO/WPlt409LdAZdMZGsEZ1JuTZ0m9LPcgu9CPCyoMECctmd8LHE+otY6etTmYABB9syY61rk2hrv
RgbcyT/HCK9TzWxSm+XMqvx2nvagCLkMDPh/JZv51fj2zcKaBPnxsz8rnDipaeo0fEyVRC3Y1F/V
U3RmXojBjIumPHSJkQ537dENJEIA0Ra65u8EM/+ItUn1bcryLcIbKy1xGadrHmHdHRUoRcAodO2C
B48bNVeL0VnGg8P9ACIB04lMNzn5p6A1tPOb4Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
YDpb+UeT0rJ543Q8wCo2xSS3gpVAT+JoStgBlV5IMjJoUOWkiOPn691FGChmDi3BTq5NxC73KHHR
1galACCjeTGq6cv+0Zc2Ocm1oobdrnSPHp7TMDr5Zle8FX6WywJCiGdoWBODggZSlbOASIK/PVfY
cZM2z60M6RSvzsi3TnYHiKYHpju8THVoSgRd6r31GcbiSy9TjjARERXan0OVc79jGuAg90mmDEEq
91eqmn6NZ9yLI2fgBjFUZbtFCpmJ8WGxOL1h39niWnRK3ZXnk8jcpnZUlxLbYTPO0Z3vVr1zrvcn
RVQloU0OLqg7M95zSs7NtX5Vzvb6jGbMehWV+WMMyxWmxL2XOwsAwPSeX2dI2r77pioY7X6VzH7f
/JxMAnq9udra3WGPsUkD1G0CvPkCC3zdxjpVaflY37ztX9UONhKtzMQa8lJc1IL8GhXRY3R9Lg2c
HIeXSGkpNNuFDqKT6Khe/6Casq+SjFJq+IH9IUtz6RUZTkbFb0Xhgm2P

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q+63zFEYw/LeMgxa7g8g79GGvSyIKDKD8RvvC4DHDQuGObf6n9OGZX4e17v/E/+EDEwUhsWQHFDI
Lp/aH+6fNRmhu9BEWVjxq2WRrQSl4eQjfIaSOXu2dlYh3JjRJwiUp4LteVh8RFAf5t5sRQO4dRIK
x+h28yliSgibaWEAv5FaJQ1EFbNwmgedAaSYjgf2A3afBUcBh5Uy9VHbW/zRzdhhJdsVNBjZYcFy
CVLOcf1toCRp8J4U5FlnFMOzFegUbdXFQhq2VmIhPRxWjrfTk6iR4BcMEN9UMij/5IHRAeBdksyD
CqEKsyFxosbI5KVMRZ1Ln75Zipn0JdsGekHkxg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DPUa5DLPYRWvbPnX0U412yoWvvvHyuq43DrYmDJGTK0cR5U4U6th8icYgizC1/hUAEzt19kM/hVa
zZh7bXSWACYLpcfhPY8dRTVGDZVjpbkraw0ceBryLP7jc6Jt5JdNw88tZtZpprCB7nQ25lUL82Hf
WTwL1ZqgGIvtfHhxO0JF5L5ES5giedwQ6u5ffXG3UB6ELcpQD1NvpW5lAz4mfXyvVDCAPZN581TF
tlAy79iKbPKlJ2zFn1BS2cuRIHHe2JRxwPo+0n5VD5CXVgg+lCYxTnCxI8CdyFaTumbs4IfAKwVI
wSN/btbwDUhW9hAHWHIRo+BpdJ4qeGcTDPKtsA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mf5hcf6JE6yLm0jNCQnHMVmogjLlPz6re0FwG67yvOJ3FuEorru0emIeAKEwgOoxjUYNWvcM7QAH
/UEeB2EIdjLl6glPAUda0HjtaCU2rdncVdM8k6DSMBggc4yo18Qx5F+1TD/RoBgoo0jNkMdDy6wJ
JHjqlN+R01z3yYIMQ9f2z6ZaYncbBYEp4+YAb7g1D7CSMxP5cFRpQznRpYp0JwqJfT9CHzlKgdab
8B288NxeLM66iYodiTS+GSRGLGtDWXpz9yeiuiPe6kJxae2GJyHIMSfluO/0Slc3m24DQNdbojf8
jdc0G2UnrDe5mCUTfYiDmpOWTUJOdYo0FK0N2g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19296)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

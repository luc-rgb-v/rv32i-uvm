// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Mon Nov 17 09:26:12 2025
// Host        : DESKTOP-JFVD931 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Github/repositories/rv32i-uvm/project/project.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [9:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
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
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
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
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.95215 mW" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
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
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_11 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
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
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27952)
`pragma protect data_block
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
HrmtTUB+8qnwn2OqEcKlemNxUeG1Hg==
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

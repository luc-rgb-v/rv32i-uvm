// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Mon Nov 17 09:26:11 2025
// Host        : DESKTOP-JFVD931 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_11 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27968)
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

// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Mon Nov 17 09:10:43 2025
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
  (* C_USE_DEFAULT_DATA = "0" *) 
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

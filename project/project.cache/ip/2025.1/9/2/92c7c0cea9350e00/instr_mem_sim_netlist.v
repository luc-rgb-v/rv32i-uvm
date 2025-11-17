// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Mon Nov 17 08:44:42 2025
// Host        : DESKTOP-JFVD931 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ instr_mem_sim_netlist.v
// Design      : instr_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "instr_mem,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_11 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19344)
`pragma protect data_block
13fa7tlZWzzXmGZI8QclPuq1qdL3CJO2gCBrK2gIe7zTfiuLjRSxE9Mo836vW4P9ChZR+uY1oSVg
qinz2it5r8a7rAm/+18Kld8sSLQBIxcyefgmmB5jHiA/Ar8J8Q+Qp++8KS2aeYbnUhG+9Bb4O374
iFIeJ0b5Beoj1G0ZEWDbUDNfRqErlR69hbBW5ekrIeu5hMV5MtuVnr2KcJEmcOmVZ7bq/VBEuLAa
hXZzbt5DGtxBxam+zHFtSUU+nyGYLVEZWg+0Cn6GA8YKVh+NTs0PrBbMK2o45hvZGDJPU6xMkAqE
ZJfP4FAHaBRafxdCOs/L+Hyt8PgmMpQVrb7kiuyUt8VPIkEeXBbY4f5b1LAz9vg0zWfbBubWACqe
lB9uISpz6yVjOrjVJarTnce67XZxbWCquVYchrNfU2qFdAWzM57lFBglqEolD9lryGlViVVnxP8/
UX/rbUzfcW71Bn4GED3yz2cD4oO9+iFZkwJPRypPgjrsO2pPLOlIzZlFKObdfhUGPtG+fpSKbcHT
vJJ0JETwti2ku2mpI+fmDyu8Zp1w3IGGmzhLPDvP4BJwbieZrEkcwx5KFFm7m4ejMy+CLDZzkYrL
linqG1kVR21ieiVbBwHYlYyWDbrQFJclGYfB2NkqBS8c5s24mz5nWbeASfp9rfi0tdbhFH7msMl0
eq1myRMX1SU9aoS9bw3naHZ6os8rF2ytqOHrv2hn+wh9knOj2QNjA1pzPDxsYITAyIfMWZY8hh4G
/SeH+HOpphYqN/5ZuxJPfwDCXUQWmgn5mxQyEUi6J2UAy5+VJOS3kVG4vvu/3wjHHZ3Pafd/tDhj
7OlaSEGuKCNLFO7qdRZbGp9yvwlWKe37Y/SAbWU0eww3HtP2SjsGas03sFJ8OW6n8mYNHlPXBeou
wV9IuFTPlYGWXVO5ccpdJxTdxlIfwYh6FE8P7ryeS4IO2RcrvX2r/oCloPRRzCsP9hszKnMqYIh1
CYJ0c18Rptr5t6atvXAJnOl0TUvwuv/4oHDqhHOSiMJtN9UDxmSmvKOH5uZLxg54orjTkaWwHliz
fSf28AXB4Dzy7S0VBU2+7Khp4ySWz4l7IcGBbIzaLOTO3yilOElUGS1dhIPIObqmws8w+7JLVMcv
HaUnh+oJaIHuSm8xjCExuUl02qaixaAmNyX333Dr+D3cZEytH2iAZAf4jZEKy+wm97oE4KnGNeat
xaDwPHkLZ2LLAhRb+/tVZVV9Yl+IXlFwZeDwPZWgFcJbkTb1Lp+bpyPgtC4B1zQTsW9qXmEuq9Wk
SmdiKaVcgxDX1Rly3vG67l00xJnjOIcuYmfwX9+rillZIXV+Q2Gn6UECtqX5Sw4VXdoZOZpHRRlQ
V8lys4IccYh2DrHQU58H8h8JeZX/mEKPS5Rkk3i/YPL9vvzRXdeiWHgSNyvbQxyN8TtPoKI8dqU0
Z36woM5o1v5KBFPAt27FhZ01M48bnF1WH0nM0ejkiPPIuCYs2PVbUI0sg+wI483XYim7DT/LNPoc
ObKb0lzQWhWzKajyS2N3c5BZo09poO6OCV5t/6U4R08+80MG/twZGR7klSUwIQYuUq13WOG+68Z+
cx0mPHrQrvywkcFYO4XR6VTV7cSPcpQ8Hy/mkG2pjyfHYAUE9gzmsZ9EWzwbCrT976Bp6RlcvA5v
3aBHS9kjMtkuQJQ1SCylJHumdAIYmubnxP9KHhLJFvzs4GQGNs7ZSpaWAWMdEuIjNl3No9fUTu8e
/oGnZXVhm/JZhBNjLnUydXRa8PBns0AjUDab7+6NgoaO4iMhoXJOdrRDTIwRFEzQ+N56BiSzPVCN
xZEhfjRgUlfxPb9Ci2YQBtOYhvKOwK3XYShcG/VHQQsIzjZ5H5xkll67uHuchXgX481uSE2AKxRZ
PMGBylGLywiCX7CBiIQ1p8ATzNndY2N4pa5AqSW2XoKbjHC8agugKDD9Axu9thYMHUVAFR8IWupg
50l5sgnrkx6Kt/N2BtTMQjKEqGHVag9UuuqD1bhGLK/4HwN0+z4g0xeno9e98SezBa/9tPpuT3LA
LgtMC50n1OvPKPXYg5vQRRAtjdxs/pIG0Es/b+nPU4XBFJ04eDDAcTU11mGHmCfAL9oPFGKke2Ce
lV+G+XFN+kqUPqtbdtUp8m1eXwUcgRj0pQe89Kj70MW5sUPAxNImCntTE0MJobXZ5dpalsZdYtLV
0ObtHS/E93RB/viBpttUmgPF95dAw/gGoAl89VLX7vwOJT0KhXWA3Ggws4a4QvM677uwQ71Na5xq
a1gEeyg6UDIAKxjAh6i7YIdKdEBrCq9eCSqhhO8z78RotS3AsP5EeMXlLiwp1ptCL/e7HdZ0jSMm
Yct0h8tDZ7OVZxnCdaaBepclg6QVL4+Goz6bN0WvCMmDLiJuxrBUQylhBmvNPOzFd6ZDf+1BSUUZ
vAEOo/s+XjKIIa/HsCumYrHuc1TXyJTYPpcAmfARMCu9KEQ9KQyb2c3nYj3eSnxvp3J+R9A4hzmQ
PvGmwqxKisODohpJqK07aRDXRpMiOY4IEUKbxEbZcnggbN8NurlXtfGRskewr60thbJRD9RbPPQG
wt5CpxtjsNj9d/FQRbSX+h2canzBx2/npw7UL62lvlLh5tS5LupZghdEw1coAWkVJAf6jV2m1reR
nAV4Wfmt5EFB1aSc+BjVoQihAFspQt/RtXwcJrBNLX4EIp/fvSRuIBBgtADc9oMWzZlxMtSCd6sG
CahXdS7QM5cLTHqjcModkHcyxkIaUwdm8cgUuLpUEXLkZDlIJlIHq0GiqcuaRP0jwlH5SRN/rhnq
xXj+mFM11+WKm5gRbUuRuRbA1x2cUHOeeGNCVXeR7PKse1eCwE6uCLEc4LpNMs4hmrz35vyOtswo
B+gtDuaj4rU24q8QknhL0J+IdWb+z8A5628sx/lzKXXRrW887u+uF5Y9RMuqj8bcABYRRZ/VvdxZ
8oDNdCbnGQWMXB+cGhrwJIJOc69NkGnOlY9kw/ndeoPTFTjqSN7/9tUuBuuSnOaOj0BOhOvxxTX5
5ZCINGfUMLcWH+CYt0CAx5Jm38ITKbZqADQY/KMlkQOZ5km83HiQgM66GyhX8iIpID4pPjzPLdAq
M0RCC52ljQX4KxYqFxzs/xOY0mZUAMXz4chr3APFEuAnBOhgqx5TLu043MLVQyuB1ZWQf94TI7Nt
nmqo1TPqaxED3cI0amvASy6NMriqdH0t1a6EG0KAlBzg8uUyCUGuLaWNcqM8qZnME6F9NTlQVMWp
ts8yW4Zj94RzvR37vsW49QcebVOS7YqCZ90zPBVHmH5fjSsB/CQDR+hPveSivTflrMvP3he+v1dT
TYj+cDtHgRoqgm1uuFCrg2Bok0fdWRqR7BESapeIlP23c1rK2NhACz50KkcN3zA99sfJa9W2rj9C
WimnTdYZa9a9lCFEKu/mWs3nZw1hdeLJj08t6s3+11hJGBCpavKGKoUvl3/aQbYzkTOMp1WUevkc
lS3PvS2kRlBjinO3aTudb41d4nO1g4dXrm4pNHRg4C33atPjOJPmsTTMXAScVc0pFQLk7wASqbwl
aIyo5ZFViN3Exw0CtQQePjNye3c6cxi73af61UPUe1rDmqucSrSPwMplfxz2m5IYmBlQGg5zsLn8
dQexKzY0Vdx4R4lKrdlE3djCWEcZlHYPOvpvz7tyVj8WAO7mCdYWUeLwBvsMef89fcVi3ubie5S3
qlLxAfKFRNSHOpqr+WqAeTXu6VZ1Ip1GG2hPsuz2p1x3zLSqDZ4Z4aboNN7nMCCoQbO0F2FtYkOx
q1vJ+fCFNhfpDO0JwVrrXuC+FFHNfr5PgpyYojlwSqbHFRlKYzbWdSYZrNGIL+9BWWp3x398F/oC
ZoLzaLnEC3rFamWCHTRZkbDj5kpsu4Oh/LE1vS0go8E/o5qC2xQHpV+3/liWxVtoL85v5XOCr/WR
c7x9sOU2TwpjPCoF+S7l6SeeOibJIgKD1Mcl4cZAPJZd12OktDnr+HyeXVjyMKSCOcSBxB4rbk2C
q2IF/QkRj6oHB/CFG68upWePRdvKmtJVUy2ywXpi8xQGbRnq++HNzapdeMJ0ODjxpLlmenZLLUMZ
ldnk9eqLn1NdRfSWiESkdH2kuS4pKfuegxou3qCieUS4ptJNuaCSPiosh8CHuHQAXAiw8cP7emg+
xrogTCqE5owixOlPIIR1zzH2Dz/ea/v7cx0NYoWnuXCOtuFRUdxorye0bTCGBHENNH2+AoVc/1oO
3dmF95iq6CcbCqeIaxgzH07O5HAeOY5RXhNbt53kZKdMyoevK113PVI4YmyCUMnly/fuwrmzpTsQ
mTOHIhrykuJWTWMibdnNf8MdNLDP6wzyYsCqwkxVc7V9Le3sG0U/1YNw+9WGxb3SFT8egRi0oXhz
xGzA2NDF6GBHgdXof5lNspNlNAhCb+c2n2n6xm5bUYNo/6TdB6Zc+y8ao3LZ+ObyAhjPdXLevx/Y
XpQy0hjDYServ01QDHTWBcdow3yqJZPp2f9ybAoabcOSjW99CIXyhI8pfYeEtQHMvfGRMfHy/SNu
LayDsdgf6cnfW8R0Vb4IJ8Jmoz5eQRBNX28icPbrDISbJkM1jwPDUSO3t2wLUEZMPgMgG141/dOk
Us0rSy/I/v0fwyOt5rArvWFWdAS5A0xcjCNMTezNzldGSDLlOZPIekL2x6cny/cV6nsW9fZXO588
iPUSAuH7Fj/eMv/81P3I8n66iYVKrtmCNwzPgqw0n+etrqhtCHawiTUpkvdZDUDj/XqeRvl4ODlb
qCwVpPpCcMIMuKvrKBOM7O2RHDG4T1fbg8+gouV4MswsSxbJFLaFQxV62EozHy0nK1LDsRirJ6el
xwDM2pXf+oaJygghJPvQcRUO6jMnP+BZW2Pr5U+XAUDF8p59T88iLq2nCbMGfxGZlanzpgwkKknG
ojdWwx2KGHOmCGcSh8GcMwVpnJlstMCPD3pD8SX2wsCua9uzeWtzex6zCzoVXhtxHwm6u/erf9u6
wFVCx23erSLH4K2TVm4WHWNGen6DwDkrXhzIdWmg9/BkQgT0CnbPMAiaLKrdMbcAE+/YrsRruEwa
QfBjFCZOhzzsdjvLrPNnITtdfHvJLc05csWvDdGniXpI64/fRuRPuOf5o8bpFe6iQH3usWoY2QPw
RaiKZi3xFHWiblH5P9PQVr2Ij1v5bp0GtGozX6K6DB+1aRKSI4/Y4m9IMzW3ax9FgdnHRsZquwFi
rFTD/3bGs/9Fywbe2ft+31M1ymwSrj22BCyavBZnG9N1CH4MRBasMdndlU/STCCq0IVtGyT2b2Ou
jYG5XKn4U+3xAJYbZFqNqMwJqPtnJDqVbcCmi+16Ek5iYtIubF5KoNrUWBSOoovsjI/YdkGUZmSb
5SGLuQYUXRZFHNpL/AqmUxf3cn/xUsQmvFhjvDCNdVjuiTuyodMH/sp4L562axm8hvcGbtdj0nv5
wBJxd563kv9yomyPrshtsyaXVogQ1A3pB8Mkn/vjbJrZ8TUKNCL72Kdi6jfCgoHFtPhKhO4eQ904
hFC/OxjJEw0bKgEfmyZ5ktmd7/dDq/D1aa72OfEg05yQcRaDnNdvvAvfvZZ0zqgLvPHpaDsjThRT
2fR79YGsEW+Zrj29YbQJEAzaVSudNUmtR9l6T/3z8zVu2+Qhdz8GdOAiW6e1qpd+fpCDTovLWtcV
MEEcKqbPE2PAKft07riKmv8cTdy+dcabVLXwCFxepmpwq2cXUUwN+4bGraFjYut/G6629yjjnRZm
/JywSiXnhxoQXYRPItb5Mqmty9Pgat3cH7DB4v8LrnUtakP/L9wRStymdNWlctUqz+mLwv0PX6wx
yLh4vGkUD4CdrCkgB5iTsHFPtbd170KV/5Srk42bj33zdP9FPwb35DQ86X+8UE/CWSSA1tVA9++3
ukaKVkmlkLFPd6W1sUCZxHBRmznEKdvhDzc21LJO0sAumhTujWirfOMOB5fTK4hR0E+VOog4PD7y
NEFA9fBu9m68X3RkW1XVtO899uWSaC30BKqxO0HzVLHubv2NjUeP1zmJEUug93jehtCtZJcaSUpF
wXw+u3NNwPIaJj3K9Zt5iqrnrTiqexjiLFOsOOjZXbNl/kTu7RpuIBt41lYWsSx47GNkF1XtF1Ik
BDB6HH/BAbmlIVMmPFlNh9Gp1Qj3u81gCEYOdepMB6WXmZ3wPyEmW9ylX7IFgnmEM4SMJnrXOj3v
LDXZvP+HIem1JOM9sGqGO5Qx69zgcQvUNUuo2ggn2w4GeCy0DaeIssdN1goqevLToqCF1QLMcEfJ
jibejECYGFj8Ea0nbmjlXPLgp0FFqyWYo9hE256QwnykE9iht/D9nJvStsfoKO16Xuq8QZwKjjfy
T4NQEaa+YuqrnVXuJNy59q9s8qauFXzyHdY6e8BSPeetuK6tdg81b1x9kD2kSJnCbAbuxQAES+aY
NAsox0nTDaNLcLP8CaR1dbVsa7eu3xbl6FIMOJ7vpg7MzMR+j6B0hSPnUfGZRcGn6ta7TmEC+dF9
q6tEICbMsnYrfarT5Z6kcptxa0WfvJb7t1Rzj4cfaQfODd45fxfn8FbQiA0Yff7suEZd2Hfh6Ki1
kD7p+6QE+0BBx6c3JLfVhEGgg55OpT9Ogk7/kW3RP3ERfWldK3esxR/KEyAffcQK35IxHJQA1RnY
aLWTmCaVf21Lm4h4FpcooOyMTkgHRxgevV08TWGoRajAtgaj7bMHMkLKha5dBHv2E+L0653wYd7i
pknsEERskby8RSsStBx5NcCOvhk4UuCpQvU7TXrEDwsN0CEGemrL7jqAFbK6yBEFjrRpVQATVU+x
S5B6NehtSpT3+QxdbgvV2hjZbwTx5P8LP2HL8XsvhWFlA9cYrBeCpf+P+3OEh5Cok0vJKHMTbfGH
SzVxOT85Lq2i33nMOjauTaco+5ouTCHVUgPGEXYlStTXnq84tobr/VAF07+VJtr3S0f20GnGLo3o
srl/1Q8qkRD0ZnGII23L1nidlpzvQezuPhDlvLzU+EdlWZ3hsxYlxQLae9kS1sndBRyKmBm4TJ+I
cTxlRU/TroQEJff5n2M7EsiLZ6Spkb7Wc4sJz6Qh3lRAJsnQc30VzI4HkbsldtPAgGLPi8TXxRXQ
eO4wqFrSfzGBqzz6SRgG3FfycfaajHRQg4+DQ6s1iTETCcKBcJMQABECSkKMRTC5xpCGfgTDjU9b
46LrH9z14odkkWgnsnMKHiNL/Ww1zluJVg+ybEtswEnbk8e49+0CHZrVwOPy77WD76r2AMtxCKMl
LcxfdcjjTHbFgD8oH8BHJO/9rtMyrFNZzxYxaw8hRxj5wbLeTX7McXERDxc5daYZMUJWsNEwD5ks
JFFpu8nprSFKtyTZ4QIOwGdpnU7h2f1Q4PHpa9BrgwJQey9w7ANJ5s9eCO/djp7+ZXxOs1TrJcaN
ToLth23s4kv1QG3iZXPjrKu8sAGMpgKeNyCe1k680dE+mU3I9NUZziq4K/9lm4qg6muQ+zud43c7
xQGUeD+pqkuXLKA0NQTKd7OwmbFJMa3bgCkKRudPhLR+o6dB51P+4niW4f1Gc/9YtGcC++n4bxcw
3lWGyYK5dcuFdDOcNjig+/z1eO+Qj0z/yKxUGxYTUZ6wPyDx+y9q+ga7sqMZKXLrtHz7qnizetEN
amsdCu8mYSHTyB+kzGgvx5rIVexdnezTq569/fNNEhO8eIP+9WaYy3Cm7QPe3HYsyrgbhpmasf9H
RtaeLcvTvJtfzOXLH4Zsg9FPNMKGMqRK1GJ52dvCPt1GgsiOj6FxDtsswwG9OKje7MH6niUyTPwM
Es9N7tgnf8PUgpPZZt29hOYrcbZTJ6sZYZY/wEMT7Ff76QQgKUue43KvZvIRgu9RvHnr95iHTpZ8
Q+07ZyzcNF4tSD7Br2XglLO1kBh1fvQenRiajW+YoZwzM0MaNWJSU/DfJo/qlftwYc1ph1rpKRtY
Oj27raoINCWQMjqcnGXpv0y0GPqVDUHiPcm8/hy9zeMTDTlGIQXGSaY30CiVl9FTUkEoSp19PZrr
GV6CpLU3Umg3Uuk+oBxCTXapmAKbcIGPcQYE/sqtWkM68Nd0NmxlOT9OvcGaLLbn96dKlg8rwegm
YH1hxxQjEMMIC9mbO1k8TiITPz+3JSTAYCoT8x0pmWE/ow3tG06W/itCifPXwfh7/xSndai5h023
IGmEWvQjxkp51ZioAEW7QvYUgEzDEqgP3O6yazbfRvGHPfgLsBlPCAbWD5+3gSX88JrjOeUapXs9
hfF9xQ6VmgfYaB7FFmVz/Dyh6Sio7Qqmgifo2owpr6ax/Y7B21fOSq3wBAZSreHYT0kLRqk/KEn3
lIiMpnv8mxuH2qLHh0aWbIIY+HiTetYiMrpYVUIu6BfE9M4FN88clLW/0hoyL6wik5zDDk7SI5ie
txSkPSTviuoGjokJiuTBvgia4VGXG5202IYuOYtl4PNC6kiaysUZWB1OeSetj8EzSd1tvqQMx8Mk
MAqdbNUefPu1upxjwMXV4zGbvIYrTWvOjV7uYdpNpwDhVSODPZsZsEhJ0AXPEHJ0RNNIx7zs2YxR
R60EJAr17Y/Pn8OEMlUW8J/8tZ7OC6tFZlwHuDmn5OS1lwoA6mbOUBPkpy1ryiPXSz4jTESa5fIy
pPQ73i6kkTEolYWGjDZad21vni7wrArivci7OMX07CTWVPG9UPC38/tRP4eyAN8FNVO6DxfnB3kS
sdqr3cjfMgKSXAnBR9suV/rXKKtM3Bvz/4CbwDdzuVJVrXTAJD7fQL9JmhhY8WNHDgEASN3q2blL
GJZQuFUV4KaTHAD0+E7o8Px26BYCzmmHJHM7UWHQRzgl/ugsLTh5eHiTcIazFm3Q5U6yVwA2qtIL
EWFIdHI0nBXaXWLfB0chfhiw6Fo6yynn9SDQmvf2AF+Di6krF0d1u76hj/cXkFs57idBVw63MHbZ
d+hnI6yNEzrVZAFoy4d23mQrnnZO3/gOZRppTafwtHVIlD/NB2JRTiiq/4i4xHi3Gg7cITYfu1va
XxqsK3IeuRq7crC5exr2srjSZ9PBITBtLy3uO/lG5kg/Pa37i+0nNDcjjDx2uHHJsfI0Dy4rATQe
guyQ/ldJuF5Y0rgzL9ULbQZ8lwYgqupMO6p+T+5GMgdpsdQVfYkxKroHwF600hrZTczf9iI41eei
vEokm3ZjcH9seTJeKHrkE9VRCFaeVCcSH7oVpQjs57saKC7MsztzI+nQ2xb9qouIkWcUNS1TNtZy
UqxMaPdTX0+F8WqyUtXZOq8mUe8HPoBHf9SC+KWjijsnUAHmAB9MaUKRTt8ADhUVXKWWRkB3qs/D
ZoOhmtzm4+oFw068QQmAlwnmwZRRtkJ8ouoBpmB7V/BLr7r1tRvGwwFXraJP2ZTC3TrwAA/uWVGF
gM/mHu8ha1q2clSogVt9/+n2/8YrWHlCTUgzCZDeZXxCTAZTfOC0zCVX6+AJcVxY7X+bkX0ly+Q5
L6mHxLirxUUSl/9ZZqnv488nVolUrNjG87As+QYrxv1sbdXBzJOx1CvlWlFttjZgSc5EKcvbmXwb
h3WyjE3OkO4+YB3lUFC+Kqhlw7z2y0fI7YB/KhnzM84yxIY2vEFsn+0qpTLnWmIy4SIkv+nwIKB9
3uuSzcX994d6OfA3Ztljrf2VGB2+71rb/oS+/FMvyt0NgAuSfoWJoamy3h3aUyIXSI1WF1DEA6Q6
T46tArPxXnPFJDjBjvpJRcX24X0heyVYrfQr0CnY5+AiNxBaVPvCKJxauE/ZSFm6u1bIihDC/RNB
6Ust1AXR5nYTFRAy9/MTHtovLwcL/4tKFkWqO6O15YTQYq9NbAQDcY+fGcY8YfxihP6v5p/jp76d
/Ssvpn9VB5RrrN0KJBFE3oyrqXPcFjxTcWEBTQFHmElS7SVjNEbX5Rl+jh7O+mET3PsmJxo/MHMn
Rnis0+52oKoMysjvDUapXcz1n2pUv+ESvb7sLyZsF02WhihWJ+pTraphf2yolRAnIP9w1d1QyRz4
FN7ai2aZacS2rxyVcWnnx8xvbSgMyZqA5FsgIwLdlLiUW6CbIFROfBPJ23a6nM7PpWxI0elWKWJ7
qB6DEzJzjUparE4tyJ7kGK84qX5PhgM3eW9xaBfJtyy7RIAOZQx/YQPf3VL/kDXQYzTlvnB2CtQn
TfPlL8qBQEYgH+byqVJhwhjX6MWZy16m0+4Y4ZC+UU0Aunw8nlmIWOdbvPZsj/m97ld59QFOTy+k
YmiFV7tlXp29m34sSYGMaM8fe990RUYbFe++f0vGH6GbTRxS2bSs1ECKxnQrIjQtKAuApSjdXQ1u
d4owBOsowp1ptxUWqBW9GM7iclLs2cslt1/+SjsHK0iUuFglDmqLj4lncguq9LSvPMrD17qj3FQ5
1ZMgSIBNDShR6Ohk9Wa23aFSxMAY46VnMLqwj4ov/mOkQ326O/dSNzycxNsF/QZMtb80l1osna+0
cUs3idO/e4I5OXy/ncVwdoQcZN9Xx39LJRQ5hbI45wfysfpIjbZFf4cyZn71QSAhOBLDEvDliuZ1
ItbEqaJnxH1X0SShatazOOfJ9MWE08C8jE0SRxyCkk/tMdJVbZTsR6vx4gufAiFcdi9JjMF/Lksk
aigqjeBy9PUzxMMznH+pJDtlcxg2QOqATbwikFe2sZJ0QzBBBhTd4GrXxY7/W3DpKpcLJPoQ/rPv
dpolAB+rZWFr++H52uCHb9NNSj63PclDcqh+gpBpzQCfd1I0/frQxYDs1SLQYqZlK5N3/iMygjhM
DCPQTsKrRpYru+JQgBEDEuogugLh3Wz+zQEbZzv29NIhZT0o7rQXw+8thiI9H6mUTTJatn3/SoSl
9Ntf1gwL/6N4vXt7F0PebC1bK9UvK42rILvStlqEwgUbKR4MwAaKDLh3yC/eYOBbGtNDBrcpuRnZ
TfihoW8QQpbWY3+u3FbhCUZswyf7hs4mXXw5Jp5vuI0ktcE7JUbt3A7ASXSCsuXjGb1oR/WaCtfQ
S72x1LE7VPg5+IHXD9TBcPRu3Q8ZjgspdUJYUOIXR23bkMi/hmvDKe3gUMw9sxK+TU8rrQpx3mNf
8xHqPPwlzQ1Tdmxswx0zIktEiTv8QB5PXM/ED+t9qCpAhGeJJZpUfSgtAb8S7e9sBWrMydnaA1VT
1M2BQAzkWMbKyhRBsahvbIKawDZG3VA2T1vKWsqa/tYLRFDOCbVOyWs9ONU5fqE5HpjAsR7Qi7sR
NuPcBkC7zj7UGlmm+YnzsMbV4ieptaI8sWfLeIXx0Zkwwnp7Darc8AI8DMZa2g1cBl5eQyw8Phzr
eqRsFYCv2vq+FjcTNVGdaHagP6zicfdPBz3pJD+zmhQ5dl1nXx7Z2P8hMX/dVoEHuh8MRv43432I
pCzqxuxMc/pes/62Z0direuQnVn8WyL1rGU/fZpd8PnnkGIKuIZkv3z46bkHg1ffdhmd0w4Wm2LY
rIRBNolvhBA+m9X4/IaEsgzJoAG/KO979995T77GfoNYYD2YjM7N0RXjDEF210FlK/ZZiIKUAZ55
Kp67hvRTRQv3X2m60cjAx1+WQd/qEx7HA+ooHr6sBasFcgQT6RjxhyA0MvIh/JXlE4G4B2B6b9QS
WT6NpDaYznw0SEZzMNtv55YpjMwr8/65mkcS03PmAsNpjbdwlCMQyk3h8+45YUJqJ3Gyqet1m4Np
/TekWJ2y+yM56rkApPvHCyAepV5ASAfZOtT0qMuzk1HmYGAGSC3DHeifADN03sL4nPxiCLU5Ste9
oZP60Tf1v+uQZhspZZ3/Spfu0P2/o5Yaqgq8MgivelTndgMQJuPHVEVyrRyz837scmfbJbkyZBf+
3IDTpaU6Jy61UmitE2hloyj+gUWo+Db+R4AboWfyGmgXsXixcHQB4Fe/N0SqLMhgfgiNw2sVDJ/s
Zx0RPtDUON4SQiwYR5yDqLwNV/ezjEVlVp3bk3Exr875H5Mrw852Sz1yBKRW+IBw2doTdHfbr/DY
yWPMGAXrupMh5k+PYQjmv3x12NzEj3hgl2s3MMDBVxI+VIAqCObpkCtZgCJCqWBUo7JBgyittX4c
eHNjMEQhytj8OQ2v51jELASeHiydldnPbL0FrOSmfIc/b2W8dYrARxFCAfFheANI6UAtqCpveMM2
ltAflAR87LlDJ5GyAm2RuTGxNOn5Uw67xWRSp2PpkkWOgdvKZu9R0eTeQ/Xb1sqB+o1Pm7GfqcY2
eG6zITNIYcw70HyZG2aO1809nbU+20lFTbKwVxY3eM+NgE3IXLRfNzoDxCdLivrhEXzDnwWllo7W
GA6Y9Zei0D5xzmR9S/wC66VIu3hsqGh4wgN8LfHGPC1Q/Dlg1WJz3A6B4gsraFg8+0qNUJmEvFkY
5XaIFDhCGmSN0w0OjHC5gTUkBvhJeL6dixdOqMJeAGi+mFgGylLEyUTk0R8fWehhLd+et14uWM3q
+8FkpHeX/qjt88pxvGosXO0EFujinlRcLZwktOOIW9NKoO+Rrw/oDq1uRVFbHMQlfTMEJzesQcFB
+996+eeCz06/dCF94I8LUMeqI8XD3vq8+uUIBGffUAloNsGL8VwYjSz59xdxtDBpMFImUYoU6whL
xQCAzWqV9GfQ6Y0Q7w501iuVTMb57wD65549uTcSayTixGMX81Cr+PaHp7YWVf4IGTH9+UU5hX/+
ANDRM4wcBbwYqSV6B3fsRg0u9rwAJBEcEpA5v0ymTmUpnnLmGf3GF86lfDHwgV1NFj0lPjFfXCqk
GFcbpTgQ6Jqqz6JnhYSh+miNcE9RZdGcsvay1+zgbiD3Cf/9B7PSf26orCTeDIaM5v0asgWgrSe+
HJzFEEug84LVObdopsp37Vlck7VZy0VqYKSMdBLAxzQyQ8eiMJOCa+/xTcp0lYBuhpUZ8YfvVONW
X+d8v19TfLm44MGKhHnjHb4kyWvqhqd4QbpbDu0iQ4t0eRuDewTfeATMyPrZfSPGO6FzDuScDpWq
/vVLrVzCKTBJKqjYgS2y4rkPxJVzomQCM4wo3ucv9wugJE+Mefx0ZwJF5CD668PexF0wGTPTTsyz
h4g9i3aImqmd4UZ98onp5fx9FVOzb8CWxB9sC9OtXOxLEGshz00n0pMpr/YKcuBz8WBjeg9iOpqo
Di2IGKk3cj3zKfBssow39PckK6lAKLger0KbD9Fk14r2mmaFW5M6hYwQdXhsuglXLGevigoYI1dw
JIqAPEojZHBCrI56ulrTz4DjmkVSUfcZifbNJgVsVsklt+cssLo6BSjzpAsZIpMa+Jgqmh6bYNR6
k/ZQgpbxCLOvfWc8+TnhRx+wlTThq8v3Nb+PlUJclC50a5E3lhKVqIrOfpeJu0RRe5iO2oVxSqD6
8PHn7/wqXad1aQ/uIKobK2KhA2EpytB26H4L1bxmuCjdXsc+5lMrtFMf6qp1FujA4Zefd1KCp0zr
qasjC6aEYeZ6gSQnm9gkHOvsUzBP+OP6jAHRXtSdXuvVManNf9+VZbT6URCRVuKHHQSK1Ittmiyx
+Qpl6JeASt0USIC5NfsfR5vBGIgGx0yHONnFZQE+e/V3HziaHxBOnDFLMMnea8RpGIOq6uTqX+Uu
l+egl5D1reLIdG2T9o1XAQdslZiGGS/ZzCuD0yx3wBhVxMN4jRylhnATusEgIvEEn+8/eZD75pbf
ycJFyIu8vS2x/cuB29UfhHO/RbGafklIqkD57SSEInhua/vN6qUIgRrfwj0Gq59qJX5cSdtXu0eA
lx6KNK/L1rU1mWkOrTepBcEPp5+YreSM+IoNNOfYrqpWr2I7HbZHXqwy4mO2XzbalTemvu3evwfx
gZ1qatEgb00uTxlMwiYzTitwwL5sG8WjhDWoelQ2UVqgMc8GgQN4i7DJbI/KcwbdbY02KkQjZjLS
xzOFzmS2uvHdKVRNCCWO3J7xdmMYgsrRdxC0/1dM7kL4mifiNduMYGPmKtCoSYrutUoR7Wpmrl+Q
/sH6mSykJiJO8YtyWv07CoxWDcvh/1/Nw/io/qXC08GYpq72lD9BAfryExPLDcDqqm8HfXN4Vm0q
hsE0Wovgw7cJDSPQWbZd3i6X+qBMaOTQGh85K1OPH1U5XzFBiT+tBK5TOxxGI93J4uBlIHB0cfZN
tzMnoKV5Twb0FV3L380UUoIrifPv/v1612hAIkMG4SazOxXInSCEuNqAyV6G1aS+DjH4v0clPlLN
KMDRP17WDMaFWqRvx28IfnK1MWp4f47G8viag/bIOVA63EEESWHeoirMj9WSEXIvkDOl6PtEThXu
c2BD70vuG5BkFbiB4KmmxuzDRQpS02W1Lfb+64YjE/BhF9BXY6sSTRCBAGjHHLh6ek49/LmpEHId
OaI6bqUdr+eFMaK3HKE1zsypOU2eN/h6qBFAkFiaKMYit4yFRynxlV2ng/rtlBgJYrflCJ2Pas2L
h3jSRgHr/SVfPZTtnHXhMke5/GxG8F8ZIYGUkTaxcUEf8PYIoOtLnYCTQOwzCTI/SFqFqQAB5/Jy
tHW8diuJjgpocchQ1ZSKpqhRiDbsvDIaGEneB6of20oeYWHWktlpgNcn0S1mcpmUJyqe7bmV2gPj
fS7DURFkLvzDri8wLjYgUBRhpaJu33lTPheo2x+4gkldQSfDGlj0nTdq/GtyBWRIjlUKj0z1SnbI
0Q1k2c561HqYSoT4TzcBlntSJqwZ3GGehx/36S+0iZwU+t/fcV0qqr5L/Y8IxL0OTxZa+m4zFrWi
ZHbO5uCdhGandDknruY1umpHvV9tLjMyyO5z8zhwCQMzljJ3pJSls7XAqjB/dbXhMjzuFsBtr633
eCxPcOHbO2Yz1+sQG/uIebNfMCT09gikZV8iXlm9tySibYVaLOohu64HFWG0jg/TZ+5GUU+Ci8TL
gWY5271mgFxC0kdO3Hx1w0xnqA1/zIs9WKWWaouGrSV2XN4y4TzPHIDZqBr/eBrnBZE7uDvi8dv2
oaVbnxv/5tEd76/5feeDuzAZ0layq2fnJYNdBVelR1RK1qUesZj7ldO3KL7Ni9uINYl1skmKdTeu
QWR/4CPQMeONg4an3WTvArN6BM4k9DcOC7QwB/+FapMgrmmxCEq6S8GlYLxyb5P8ttOYZz5NTqCP
9Hw6LXaRNJxj0JQpy5Os4b+TkLu3UUG0b0JNnV0yFWDWt55KLJF39HC0VHJ44gzLYeEaG9PIbgR/
Fv1pczNM82daHt1KTJJ3OgmpZH43igoFD+q42d5uqC9KSLWT4anLuQqs6vwEdUc5/KgI0/lp2dsX
7z1k5igWRSHudsiGnBIlQTR4kG5kpMllp7b7yrqt5Opwci7z72NJSsyAtKqEtLxx5465TxTNLQ5+
WURzY7fk2fVXP4s5Fc5beHgp83fcUTU9JrE9id835TwIXX5VeEujI9wtbSkZKES4gnPpEbnV68Cd
I/oFWe3yp403dL/DoDg8RA+LWPbtDnkbsGuH8/DvraMu9IYkJRdWniYiUfQtNVHpDsN85uwfOu57
SmCSF9NSPu3bznFB8V3hUFRsPSGPlq0UVsxUuQT4JyEmbh6D2nieRD72d+mtOYTagNOVB78TFeRd
QcvRhkTH0H+28aASSN6DAaY5UnVnoKdfXaWK5BZbmlQfhOVszgH8+ZeRL6v97lnABkCmk8GRg3ec
334CvdKCjISMwmCMduhvuPS35tm1OwX55+I3VKf6JiQxvT6YgRTyuA0rGH3A9XQMyYIasXo6yO5z
F4WZKM39gmUo96WdseBN97QvP7b9/UuYnQBFWYfmVG4sxSoqKSbftYaW3eIsosNPC1x7e3hK3VOx
sWP7rtQ5Jz//lBfas/hWR/O83xwrrCTgIVpjX+JNKgUuDyXKcU4+oAeeQ+VRVMMJ8bKATswDB/lP
uGpjYS6dcv1jngcJrqmELG0HAXZp8JLE0nFkrD72YBmElpFNbyEqo4DIg4xXyuZaITXK1UmYlRQr
r+j6B4V/321i7KPwkVT0QbA7WIrD4OiZFLSv36EDkmFdhMZh91gyucCnvHczJkh0/B4S6ow6q51H
vzGqqL8mNk9CaLe77vV77gLqKrzTbCPgVq5401x8BbDJ4zVLuoRjXtsu0IJgRZGE8j63TE92gf0i
iYts7esLTBcA/nV72fL9ohRl40kSXf1iOI39OKZzyLo32fn7LvUxanVCXeBdYgJxFGx4S5kLMv5P
IEQpsRyFYnSZLgHbTV5CHEtSd0S2cQJ6bpnSWzO1Qije4824jkXwBQ+dWEe1E1mnj9DAJYFhggzf
touoB8q/uZ0KIgYnDGCaiJtKSliak/hlM9w8E8uinTGkCa7KGY5wslIy0vtea4r2t0a6DkO7Tz12
zzMwHE6H7KSIj+yxBo75CvDblDjFpTK6vK72aq7A2WEpwV8DZBdQVgltD6jl++N03NLN2QjtF0aV
WITpD0NhBYolWZ/RyJquNG83PDYke/JXCKTqPQ7RDqmkh1R619/TXPQhwD6pluc8jOToOHECrub0
EiVUK/Bg/BXe15KLd9qXdoIWtE56HS+bqS3WsvJd1+fHYjOAaf7MErOlvj7HsGwDHQ7kKF+qMODI
Z83yqwyo1zS+HBwR4j+UecuYWrd+lLvWpx+GSWlMj7cOuFWCHNYT/AhXV+aXyfmQ0sSodq7bac2H
a7fn2NQgOgAddySN+TTlYeiEHANodp0fN/z0SER4lD/ef50mEVTwXMx/vVqQtl0+Sm3+CoLHtSOX
UTAS11fYWA1sTkyZyQ5PKwZkVPSN+mk3liU4VT+g8lsnNhg1FPEuBi7w2jpjz0/hA4TJARyfB5nS
EklSbq6+7Tk3EB2J23N9gnCf8HAcHURMlZNgvL5IPkIyASwPUEy/xXus53d2xtzKZtpYgK7yxrCw
q23p/AsdXQFnWvpuTMQGdHNPSKx1XgrBrSsIg/A7rXelbhneEggAMqBts0Vtq53QpboGKFIAojRF
5+ZqJ74oinE/YMHzEYI1GaRCVVfeCtoZUCH8F7+PFzl8A2JMYjXAn5ndAl4DjFqYpU1Mj2oTHefD
GZKkLjv8rUgy/RjOJLg+GTWz5lh+8vN9je+lLWLPvpyI1msuoYSLv4z2KPET8SvA3B28OqPJutMq
F4HEX1VGcoZfX2yC8il7sGkDiV+I54/nmuA8vq7U5rTBkSztm+fy42Nktoxh92WaGBnfSZFbvJTA
7uhFFrWaW7lKt9uC8GWumCCRNl8BPzYGBZjIhjRQwj07yYhV748+qpcR8NkY227NqKQKd5qu54Yq
oo263WMssTDCYmLRXGkFlb0NpWctbddBGmoLsCGkvGCodiTrsF8xXD/hoF3QbvtNVlcNpXX2uUf5
TbpaOrFxWV2M/+wY+5VOVCpbpwO2XOaTIsmutNMn35mzLq94SPnqKQJ9FLZeMVWCkfEIPZFgZ43H
CH/Zt87wl3L54LxB6ZfSDhO8N3koUa2H7x6T9MXmaGv5CnEHfSoA0tAnFJhKyh01RLXbnJDB28xH
iOYiuP36cImre3uSEgt8XOSqFTX0hVXsgIJpd7Lz/GbRCN3acafAjHhfduLsuZNQNZuQP83/Myiz
o2qYc0f0SUWd4S2inDYOo/TTfmx3iSHoYaiF3aXmF740V1QTrSIX7bd5JMzCRS3N+wiVUMnpqZPw
Go0rAzdDqQglfSAm+6afVpb0E+QrdyqQjrVwq0tDvXQxJSAniPob6yiJuGSMav3qXGCW59F7+IiR
2YVnj20D89d39YkAALtmuEJNaqjmoRNOm1+UOUOdY613xPTCIuBL7O83j5Vo3PBCvDgpinzFLm6I
f6Ns4tpw70TD574tmlLEFSj7XWLCS/izAo5C6q+dyY2NDEVVjvM97p4sE9GcPiu4y+Do/W8OXL/0
zCkT52+3YIJklTF25tlxnSbYij8CdjeXY8aSEy/MRLWo4ujAApG2QIWrgm5NCSdEUeCOYtxjJs/V
NThVLiDlyc228xO/9cLpz7slfKCnWac347RKsimAXHV/yJZ8VznmrWIDwaXr3E7lU7AzTBlV4Esa
84uYkmueguQldBQz2d9PKYFWb6od/zeawCld/K81568o/lmdn9KR76usc0nWydk4aajVeUIX8cxf
I3YSt1iZEIt6vCKuMGKWkybFItEmQF+JDC4o0f28DPtIhPB5ivW3acQSgD6wgDJfaato5S9J69qp
hO1z5Mf81w5xpyrqGA23BJK6awWr2fc980qTI3UnikxKiAQo3sIZlMPFi9QVehVNS39MikJeqRIM
IRhXIBkFdZOcKmNsQ8LExzF8zMpY4ErQBxXLyEgDE9wsgBy9qpiouin/c7YT39GXt/Xe5UFvkdf0
LA1I3tznxv7eYLcLIx0tWDz29d6e5av7f9N6liIv3VglUmmDguZGHTwQWMpCfNEHey44DCKS40f9
jZl2vH1W27tBHgd4qXVkUPbFIi+Ed3gy3nHTz/cQh40ja0Sg9WThVAmu00mYoS3t1qgbi4V16QsR
fpY9LLUGDGkjgK1gZ4yR7N7txkP+BIyL4gfNu5Vg8kYC/VwM41UO4NxwZD1ciLUBN2X8WCTPg2wd
RJej4lsknGXv6dkP48imQJO5NiqGT/wyJZO2zQsz14o2pRAHWSHcpiU2BOiCLkSc3k4uqHYb/S6i
hZpiJtxbNieFrqVTd4qGh5r97lC4UEz8wMRpUR9Y3lYj0edWfqsDG57iSUhQwKozThgeGD8r7bsJ
xRviKkxwgm317q5j5PmvSNASktmYgnC+S32rPVFWGfQKotpFEcnoYcrzbVHYOcSuonZVxWLFRe2n
6S9Zk/jLVqAA2HE+B1RxATA818ZelOMXIcvuEUd6WqcKhUxofSfA5vVi02cQV4mdEgysWQ6Su/I/
mKWLyAkLaz6EihENXT1kaxChzCVC450XPELbVgpowExaFK5xq2kqnXpGZydltSV8skFcHgUuPHrd
yQ3XAjA+zjWfJdt2PIz9ztPrkHW86C2fEI9j+ntcYUJVLVQdd9r/ReqQz6PzeDFTuLsKaTeGBOyC
G6Bv7w7QuBq1AgFdq+OF0TSmORkhtj+/CBov/zSC+UdXasP5SPNjcro6rA+QLW+a4R08I7veLqMr
JyagQ9gsVVH8ZQpECCE9KowF6rVKyHkphYB2NY63uGKsNUmx/2gNXtwlyIp0YPrL61GbIlQSMQ+r
t7w94Rlzm9sLx8R0wdWbeT+IaT5egYmP2ESszKPhv93Apv18uXlKTJmbHfZdntcpaGM1e2xx4njZ
Jb1acWnZaGBrMyB0zR8k8K2jA5g7s+5JQDKa3PJrO0BANESHvk5U8r+qI9Ux8Cekpzm1IyCuSGcT
nX3kRBeqEtkov6u/4Bd++E57nsbA8MZ4UVZvagfwj/pZSSqA5tgsHTGT165fwbNJcR4Z50LjN266
zop4oqCJ8yzoaEctOuzEkved04sspbEDVEm8NCZqb7ODKiLq91KAfQu1dpwcsC8Q4fIegNkiXUrj
Q4W3CkHBHV0o5ZnAnkx6dGTtJxERegXUStH7vpgpy79mgg89+o79cIzMWL32Kr4nAkxfGE/epJDu
XFk4QULh5Cgtk0wFapiVDbqA8vsh6FymQUES7rfPlvlTqz8+1lqujQ+vsaNagN2IMh1q2QY4Lks8
GICwKtbtGV8czKsVgmBeOYC8Ijh1C8yWQyzAscymkPYH5/wE/qHsOeqWZQu5XRU1TbxNlXH7r5wD
0EQ8kFQ8f5emlktjWJtO740S5AgrHuL5E4aUiyonFUg2oSIeCRJdujyXtsWkVDyoObWtETOGRkoc
p2IhUxB3vvp31a7iK1bTck5n6oHfF9v/doQePx2Sbl0s/taC0bH3Y9bo38hGvTiOQm9ScDwW94Bz
/zHI9Uw7wFr0o9M5yaJGa0bZTPWMSxq9KvUOt73n+6kGddOpVpnPKqh/+bTCV1B9mbbYl3P6Pqo0
7q4hXtHrLMrdi6gWUR6BU6e/0If1/T1edYJiTXsZS+zN9vxCdKJmNkclleJvz0NFx8XAc2NbuMlW
Mo1IlByO60csmuoWdrjS+EEDCKk0iezebmkX5bzTmgXYoqfai6eKoOQgHkjee7DZib4NvCgGEYV1
8pDM9x9HEds4++/fEZIqCIUyZ34h9Szb+5DjrbSdPUYJW5BwVpUhjSBAA9qqdxkWDz/4ycj8P2pa
QJ5FIRLlCeE3R0aHyogkdBHpeLDcyl/8AzmxX+aDj+38/BCktkwPPRx07KB1KpQHzeFTBzX6vCBz
i5xi5HxQxKl3PE4Xmrd5Q/sYeVnG31Tn5dvjx4+/QAZdG5m+IHIsi1iAowhmg87H/6qQ59CgU1DK
Nu5WdYbO8GRgMSNOZRhNIHALPa85dEB0/4YzajTO9DQ+e9O09p1C1cLItlLZjxGusufFJlxD115O
0EwgpCn3O5PrqFgbH+Hb4wo1kfIgSyWOawkYnfI4BZsiQW54RMKs64u1EF5jEe+sSk/gUktWlGsW
aGKjkNxRrtLXW3bBPGtDmK0wFM8oCak6+N1JODrLAL4ImZSLlqXHUuI7+0WT0K6ipGhQvscb0sSV
KaLQDDMay1jnb6z4pWjYpyFsyu1jeZsdfYgLpPGfVnOs2sfu2d6ThbFuU/fJirmCueuTcGuFpo3Z
cUdr/CKt0CmC+QF9QwRLzqD6jysgXW7cGjwlM+5gLhCE0uhVNaCPpZFBwSOo6//RQrUeJvhiSmtL
hjHq2sC+2GQa2Y0bLYphbl55kAWMfvb73HeXaokywm+BpCLtC6iJ6/zRsWLymmaCfHyQHtnviPLO
dur4xoOil+IgXWxmVzk5o62wb7YtBazAwhoCB0sXATcuPY5niN2h6Yop3N5jMFam+4/mPIsYDKTZ
azbTtwFsKYZT2n5pVcNgKOzCeLc8bmV0nXc0zJNDidUgjGQzYC5tEwTDhgoe4DWry5bXJx3gbXIn
Sm6KJtPFmbUo4xG6Gn8E1XlYLaearwoFzTftwHizkWT4qmV5b5XRgfBmusqrSYtGEs6Joo1Ckmw3
hAOtlYpIAwBHDOlNmkYJmvCZesT7IYAvcNQl/nsPvtqZk5qQmXjMNQgsuix/x8UZh8mlDVynWRdj
envGxnDXdv7/GE2xXJxGx4P6F/SjoQD4PaDmVfZqwjdsjzhF2D/T8vP5pIHnO8QccgAoJrHYwcQJ
5NO3Sl1gtEHhHz9O+YB295HDxfGMb3gd+fSGvoGSBhZVOfYp7chBOaENWkIj1+nGVHO8CSe6l/N0
Xno1JT/8TCpbpm411xUPos/kpd41XwY8sQk3Yz/7rRdaKq8wPGKVj1qLD4Ryb85mI8ZcwwnLYwvv
sMsvVxdVFriMlTCmTGnA+ALZrxLQu0TUJaLQ2aPfV6hwnWLepPVULanKMN2sgKUUExAHM0G7Szu3
plCFfFi8nTTmY2Bcf8+jB6VEB0ORgrQGexC8bQD/JthKPNshoIDR1gyVWK7Nynw4tl5CiiouoV+B
h4e61FVNoVOdj6OfV8KMhDkRQED6L3eRlYHuVCJog28ExkrpfWGVH/fUwM5jVL28sm8r2HDPedkZ
PkiPty/iF93+VeAt/iDOvGqfti8Mc0W50+iq2WaSwPVuo9R2XgtbfageBNET7rATmLDMa9tismjk
Fygd/EdwCIhlrlW4wpELS2h9lSj1Rhe6fJq4DBukNyVQi8EakPE9qjE3Ok2zSwZAIaany2iz78jU
HU1hkoeQlbUnN/K3DIn7GJCD9urmZUQHIQ+ol3cH9aybJhgSa4EgYn3ZM6ktvXq6EMhcrPbbw83I
JuEEkK89/K02Wtp1pjJ/vy7ohmdK+PbY4yYUJn55N8LvjSMLZzrJXpE1JIr6JWiahsk/F/0tbs+d
+S/GFEOwdtP9wJbiamOeT5BWJ8WGVpWQWUezO6ak6IGb5mrPaLpWnNuDuqpsx5fhgov9U/1Hb3nm
ENWkS/Q03f6PLPuJpoBOmbtNEaMFW/SXXFONAkBey3fN2xmorARlr+OHvNy759JtpG2uRPvo+7zX
f9PR0oYlPt5PXLXobkmBbx2VOCvrk/VtsrqqNFxF+MAyjbRIytfO0ZtFKf5KsEAy0fIFER2wA3fH
W5TMKCjU076p3R5YPJdjH6hkvp/ZJdZ5AIxzvC9/2sK+9nMQ2AtBMHRG57zTldnzCobpDoytDhGF
BoJxHsi4ELPpYjf/IgMDgpCQrlNmiQ1xr/ifphI0vJD5FzdBEtIuOpEn1l7EM0U1Whh6VHLEduvs
8tcVqtr5TyafElLsTtJf1A5xAh3icZciq+Lonti9EG9KM5hhx3xgVSpfkcVAaoor4Rvayl4Co+OZ
oOBjvFvQ6t6LIGOjzwBYTnWTD539wdEAMQ8s5Wf7puL1oqJKZpwIer4bREPyeHdxhYUfxncP00KN
rPqVJzu7CO7rWJrBeQ0/9vsghaYY41Jkm6EQuVKXyHf1vCBsZO6HXHe9awjYe/BU+E+f61L/ShB3
sWehppN5qtgl81B+f6qpeCDUVv99ovFuodPJ3ElPUqu/+q0+6ZmRN9mlLg0+w+qYBhejWu4QFJ45
tyhtKA3zs+y86ZUXgTYCS4BnW9ncuid6iSJWbhnU02BdkacOGbiqDQkTtDm5pyF9DqGkM/DsRyoh
kwOO0WAPnKg3PvjFcYQdH9aBXZ0kkFc3vlfNMcpKcHQfOS+WRZ5i5+oMcyZG5UxcS3oacczEqVMT
MIr1eUtFuKnr1xocTzOSG1ofVqkJzXpaB+p6E82iWh4q/K7JPBRrH78UxvrDNmiJKNIFvPYD5/Cz
nSuQpsG+L+d2wyr63DJwP53yHEg81vtD73ucqS5FsbdEN5XDuqgQPVSF0q7p7NDIYbU8FDWS/UqW
4O+HX8Cff8E/CdMQ5QVH54ICIx6EbclCLyg5jGeQVbdqTAQ2W9DqY9wGwSBIINTNHXW0x91ofPN0
JjXBQLzjMCjYCYJZES0nWlMUDTB40wdnIzhRKym6KTEnUolol5OaZEgz6DmYkmGDkMywRBeZEo2N
ptnElMUjBRcUUt665l0LUDTlj5usiuvERb7hdw5Rl06TI0OUkoYeeDahWmrHv4kcR78lZEAnz6o+
qJeP9MEEf1UFyax7qZtnzvsFf1PjW/OGzAhdNFeylwXyG+cLxhXcRjGYadxE5zMFVlC33pQZKxaF
596eVQLVzQ9yS8S/EAGGZXg20AQq+f2eZJrcOR8UBiICPf5Ec8lUiA58gJhtBx646xUGnLz2cexf
o1HSk1rnCBkMENVA6q1lNq44FrLiRPX8daCywNh80AlpbXhVDZp/QeorzEZL0WlMS+s/yya8aY4l
yt/vmS5nUAP7opvVLzHPgC4/1kzqcFYqGpcRp4fTLt7M5sR7SWfCXHeJCmd58lOtrxnA9Qepo3sp
K0t3AT/tceOJNKjoISeYNuDAa8tpHc3Ta0TnRbhcwCumebbktSkbKtdlXAwOoOk9bTangUYPfAtv
MM1+BxXUDJKX2N9Ro1R88plOzOgFnW185YQzjFzydcvhwViHsA7QLqxhDdIZfQ3SQYRHTlWdl0ra
24sahK50MNAY+9ayw24YpAheIIP5IZKmjL9uTVe/0RRMDgy0sFpuRG7um8JFzLT+wby4ScT0EawD
N4rrwRVFO0i3vKR+InZzALGjPftX+MoxDrrocaPK6afyvhGqop15f6R4rn/efYhOoISVPhGNGyqI
OWZmiLOARIPWD4HCO8QY40/t7yuO9WMLHwOi4VLpYL29EoMgaDesxDzzutg2MKwfMbX4Gz2ef1rk
KpyoFv+V0MpMowDqkeroTq+5JUl4iboNHmtJPkhyW2aoJ/IomJKf4COjIw1wztfF/meRh32ijrYl
O+45nVcs8a2Aq5lH1pguCM6egcGQbOK5w1r/qahIFXT88LcVsdSyGZZZzgM6BpqAdVD4HDdjo5lg
OvpOwEJreTbe+LB5hNoeckdTJTqn00mQBz/K3Ynz4KL9dFVW3wXP2AfjO9hK8b9lsD6UPWKHkuZK
KOs8LBCnDkAJl0rGJcYRho0YUWAkOlwnsVHC75us2VB5J4fC0K+JJraGwTugYh/lrko0dy3wvM9m
4gv5ic+sxUbGc539r+z3t/ZZN6qFdlR2zb06wELxG36x/6Snph0+MiPWEcj31OCd4Mtoyyf+Rmwi
4hcNetvKH9ulYg30xrQ7f6OfoIREO5x/xxc+4G9Ip/dVo6QkHV1l/36WIMNaVhpg9mq0lqD2iMeQ
QM+VxRrtQxTCSxsEXilkueC0YPZ0ZJqDDiXyPP+9Q/IzZAKSMtNdRiNgEAxUE6hYS69fGqPApdrU
9cugPd41XCyqocjSTpcH1NWIao3FPUY3qp+xB3k4czb+UCV5Uj5siqzs+OyGaATRroD/QAkxQwAL
ER+OYiU21fhFn43weSpRQV9tlpIA7U1NUZrzqhzNL2V11ExqpxVT28KivVPz6mxXuyJluKDQ5jlQ
OdxO0o1rrZwXIkvwr+XyKjIv67oOURlpZUNbiHW7fKlt+Es/vzYw29aOdgpahOvX4igRIn7rEnyc
glADr1weaWZrQf8bdhE0dajazott6mdnXKBQScm7AtEY5SxGu2uaJpmOHRrQ5W+2v2oYdMS8FJhc
3ndkTvPleiuiGR1AJjaN8wA9Fb1y8Jxd/O2sSWJI/VBaD3LvKgLLQCfKERnRfwlReNtHLXnd008b
DUFZbMwWqyHr3T+P5R865hDQ+vfgbCnMZ7/QK+Gdn0PorTNXoFfoVPBjb8hstzFpPwOSvFVLh5Je
Zb4yPdZ7XEXIEfE6wpoYYizYy60qHuwdfIgTNWE6ytpEjaAP+aiQjBIH+CXa3SnpFELuJEej7SAO
qkz2ETlwCfV1RagpxbVmAInBM5/tA01+VxlPhrJzzXeYxRq4YOYEd/WOFuK5AiUgA29ZesbBLRt+
DkoUg72Lu8/0k1zmYryaZZk3AVIoHsW01vgEnSrFkW+hlclZSeGi2EO09aJhPbPvdSwGFQaK5kfj
FzMfTDwwydy+pheSEs9+h9xuxiODwJDf0b8Ms+uw4cdlL6TD1a60nKUImcJY53lNtyOn7A9RwRo+
l1rFv/cXFGPS91iYwCvO6O4Ue96JzUlH44ey6z1BlqXDUGOzOgxbYh5bq8UwPaC0Xk/cJsT9ap3C
oFdUM7Zu+e6eZqmrMpgFzYYwSK/fZAK0MkFDS1g/3MxCcp47k2Fsxl8/S/yTMmbUM0fiblZevANP
DoyFh3RQD92MizzdA8Ce8WTp4Bgrl8Ullz/0lWqJb+ClsJH36BQwv/A4UJCD+8jJM/2RXjZSOtgD
Kkpd3DAYdDmPTl0F39ECCL4e0MtZlvXc7EoPhKwzt90z1El/DNhHXnWrg7b2zLRe4830R5PCnY1B
sDEztXGPOWhBE8b6G7nX/kP/9oMvGmdxh2tflVxJBfIrr2D+d5BEffZq2ckNM8NBpj4fz1VO7PKT
KpvCqz0sh3VZMbZQN19ct/rgwTM84agwyL5y1dE9bJcLQSBuljPFBeGvP7cM9fOHSLQt2Bqa7jwd
6NHB+pX+UhG8aCTUN5nTKKyrQ3rhm0VztklZLcPLsLm6YAs8aQxoqbXzABqkYs8fd1qO2G48HEN1
q2j6Neh24DFZadSZ9H050oTWXbIBGHUvqeJl9nTY3xaij21oVoEQDL04xxUZ96RYou0F4rQwXlM9
3wUpeujrbrlzg8oRiNEApnoX6azWbF81iRNwJ6MEuxlSnsR1PkPOhTXaRfbyS1tJJMMr9LDQ+opw
U4aPqik+rLLMVVH6n08YtmvRyv32kMWeoDVhTH3nBj7G4XRpmm7kEKJ8KQHOmBoowesqkJeBsDiY
ODtpB4O/nJdBuqNhOxWwr3qF5pjr
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

`timescale 1ns / 1ns

module vga_tb;

// 输入信号
reg clk;          // 系统时钟
reg rst_n;        // 复位信号（低电平有效）

// 输出信号
wire [4:0] R;     // 红色分量
wire [5:0] G;     // 绿色分量
wire [4:0] B;     // 蓝色分量
wire HSYNC;       // 水平同步信号
wire VSYNC;       // 垂直同步信号

// 实例化被测模块
vga_top u_vga_top (
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .R      (R      ),
    .G      (G      ),
    .B      (B      ),
    .HSYNC  (HSYNC  ),
    .VSYNC  (VSYNC  )
);

always #10 clk = ~clk; // 每 10ns 翻转一次，生成 50MHz 时钟

// 测试过程
initial begin

    clk = 0;       // 初始时钟为低电平

    rst_n = 0;     // 初始复位信号为低电平（复位）
    #100;          // 等待 100ns
    rst_n = 1;     // 释放复位信号

    // 观察输出信号
    #100000000; // 运行 100,000ns（100us）

    // 结束仿真
    $stop; // 停止仿真
end

endmodule

module vga_top (
    input   clk,
    input   rst_n,

    output  wire [4:0] R, B,
    output  wire [5:0] G,
    output  wire HSYNC, VSYNC
);

//wire define    
wire  clk_50M;
wire  [10:0]  pixel_xpos;    //当前像素点横坐标
wire  [10:0]  pixel_ypos;    //当前像素点纵坐标
wire  [10:0]  h_disp    ;    //LCD屏水平分辨率
wire  [10:0]  v_disp    ;    //LCD屏垂直分辨率
wire  [15:0]  pixel_data;    //像素数据
wire  [15:0]  lcd_rgb_o ;    //输出的像素数据
wire  lcd_de;
wire  [15:0]  lcd_rgb;

//像素数据方向切换
assign lcd_rgb = lcd_de ?  lcd_rgb_o :  {16{1'bz}};
assign {R, G, B} = lcd_rgb;

//assign clk_50M = clk;

//PLL时钟复位是高电平复位
pll0	pll0_inst (
	.areset ( ~rst_n ),
	.inclk0 ( clk ),
	.c0 ( clk_50M )
	);

//LCD显示模块    
lcd_display u_lcd_display(
    .lcd_pclk       (clk_50M  ),
    .rst_n          (rst_n ),
    .pixel_xpos     (pixel_xpos),
    .pixel_ypos     (pixel_ypos),
    .h_disp         (h_disp    ),
    .v_disp         (v_disp    ),
    .pixel_data     (pixel_data)
    );  

//LCD驱动模块
lcd_driver u_lcd_driver(
    .lcd_pclk      (clk_50M  ),
    .rst_n         (rst_n ),
    .pixel_data    (pixel_data),
    .pixel_xpos    (pixel_xpos),
    .pixel_ypos    (pixel_ypos),
    .h_disp        (h_disp    ),
    .v_disp        (v_disp    ),
	.data_req	   (		  ),
	
    .lcd_de        (lcd_de    ),
    .lcd_hs        (HSYNC    ),
    .lcd_vs        (VSYNC    ),
    .lcd_bl        (lcd_bl    ),
    .lcd_clk       (lcd_clk   ),
    .lcd_rst       (lcd_rst   ),
    .lcd_rgb       (lcd_rgb_o )
    );
    
endmodule

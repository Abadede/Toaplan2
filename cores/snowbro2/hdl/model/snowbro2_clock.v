/*
* <-- pr4m0d -->
* https://pram0d.com
* https://twitter.com/pr4m0d
* https://github.com/psomashekar
*
* Copyright (c) 2022 Pramod Somashekar
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
module snowbro2_clock (
    input CLK, //48mhz
    input CLK96,
    output CEN675,
    output CEN675B,
    output CEN4,
    output CEN4B,
    //output CEN2,
    //output CEN2B,
    output CEN3p375,
    output CEN3p375B,
    //output CEN1,
    //output CENp7575,
    //output CEN1B,
    output CEN1p6875,
    output CEN1p6875B,
    output reg CEN1350,
    output CEN1350B
);

// 6.75mhz for GP9001 (SNOWBRO2)
// 96*(9/128) == 6.75

// 13.50
reg	[31:0] counter;
always @(posedge CLK96)
        { CEN1350, counter } <= counter + 32'd603979776;

jtframe_cendiv u_cen_675 (
    .clk(CLK96),
    .cen_in(CEN1350),
    .cen_da(CEN675)
);

// oki 2.7mhz (SNOWBRO2)
// 96*(1/24) == 2.7
jtframe_frac_cen u_frac_cen_4(
    .clk(CLK96),
    .n(9),
    .m(320),
    .cen(CEN4),
    .cenb(CEN4B)
);

// ym2151 3.375mhz (SNOWBRO2)
jtframe_cendiv u_cen_3375 (
    .clk(CLK96),
    .cen_in(CEN675),
    .cen_da(CEN3p375)
);

jtframe_cendiv u_cen_16875 (
    .clk(CLK96),
    .cen_in(CEN3p375),
    .cen_da(CEN1p6875)
);

endmodule
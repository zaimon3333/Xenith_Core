module tb;

reg src_clk = 0 ;
reg dst_clk = 0 ;
reg src_rst = 1 ;
reg dst_rst = 1 ;
reg src_pulse = 0 ;
wire dst_pulse;

xenith_design uut(.src_rst(src_rst), .src_clk(src_clk), .dst_rst(dst_rst), .dst_clk(dst_clk), .dst_pulse(dst_pulse), .src_pulse(src_pulse));

always #5 src_clk=~src_clk ;
always #8.5 dst_clk=~dst_clk ;

initial begin
#20;
$display("----Simulation is Starting----");
src_rst = 0;
dst_rst = 0;
end

integer i;
initial begin
#30;
$display("----Generating Random Pulses----");
for(i=0;i<20;i=i+1) begin
#($urandom_range(0,50));
src_pulse = 1;
#10;
src_pulse = 0;
end end

initial begin
$monitor("Time=%0t  src_pulse=%b  dst_pulse=%b",$time,src_pulse,dst_pulse);
end

initial begin
#1000;
$display("----Simulation is Ending----");
$finish;
end
endmodule

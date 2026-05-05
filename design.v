module xenith_design(
input wire src_rst,
input wire src_clk,
input wire src_pulse,
input wire dst_rst,
input wire dst_clk,
output wire dst_pulse
);

reg toggle_src;

always @(posedge src_clk or posedge src_rst) begin
if(src_rst)
toggle_src <=  0;
else if(src_pulse)
toggle_src <= ~toggle_src;
end

reg sync_ff1, sync_ff2;

always @(posedge dst_clk or posedge dst_rst) begin
if(dst_rst) begin
sync_ff1 <= 0;
sync_ff2 <= 0; end
else begin
sync_ff1 <= toggle_src;
sync_ff2 <= sync_ff1;
end end

assign dst_pulse = sync_ff1 ^ sync_ff2;
endmodule

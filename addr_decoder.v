module addr_decoder (
    input  [31:0] address,
    output [21:0] tag,
    output [5:0]  index,
    output [3:0]  offset
);
    // 1 KB cache, 16-byte blocks -> 64 lines total
    assign offset = address[3:0];   // 4 bits for 16-byte block offset
    assign index  = address[9:4];   // 6 bits for 64 cache lines
    assign tag    = address[31:10]; // Remaining 22 bits for Tag
endmodule

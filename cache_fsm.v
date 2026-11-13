module cache_fsm (
    input clk,
    input reset,
    input mem_req,      
    input cache_hit,    
    input mem_ready,    
    output reg stall,   
    output reg mem_read 
);
    parameter IDLE = 2'b00, COMPARE = 2'b01, ALLOCATE = 2'b10;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) state <= IDLE;
        else       state <= next_state;
    end

    always @(*) begin
        stall = 0; mem_read = 0; next_state = state;
        case (state)
            IDLE: if (mem_req) next_state = COMPARE;
            COMPARE: begin
                if (cache_hit) next_state = IDLE;
                else begin stall = 1; mem_read = 1; next_state = ALLOCATE; end
            end
            ALLOCATE: begin
                stall = 1; mem_read = 1;
                if (mem_ready) next_state = COMPARE;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule

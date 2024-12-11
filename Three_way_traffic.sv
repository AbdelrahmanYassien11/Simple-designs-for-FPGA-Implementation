module sva_trial ();


	bit clk_sva;

	bit ack, req;

	logic [3:0] q_id, k_id;



	property owo;
		logic [3:0] temp_id;
		@(clk_sva) (req, temp_id = q_id) |-> ##[0:5] ((ack) && (k_id == temp_id)) ;
	endproperty


	owo_assert: 	assert property (owo);

	// Assertions coverage

	owo_cover:   cover property (owo);


endmodule 
vlib work 
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -cover
add wave /top/ser_if/*
add wave /top/DUT/current_state
add wave /top/DUT/next_state
add wave /top/DUT/bit_to_serialize
coverage save SER_tb.ucdb -onexit 
run -all
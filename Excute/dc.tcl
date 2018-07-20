
#//wing information you should confirm and change to your current value
set TOP_DESIGN  Excute
set CLK         clk
set LIB         "ss_1v62_125c"
set RTL_LIST    {/home/train/liuhena/Shuzixitong/Excute/Excute.v}
set CURRENT_DIRECTORY  {/home/train/liuhena/Shuzixitong/Excute}
#---------------------------------------------------------------------------#
#The following information is DC environment, Please do not change unless the instructions.
sh rm -rf report
sh mkdir report




set search_path "  /eda/synopsys/dc_2016/libraries/syn/  \
                 /home/train/share_library/smic018_library/smic18_sc-metro-v10_2005q4v1/aci/synopsys \
                  /home/train/share_library/smic018_library/SMIC_IO_SP018_v1.5/SP018_V1p5_otherDK/syn  \
                   /home/train/yechen/dc_16 "

set target_library      " ss_1v62_125c.db "
set synthetic_library   "dw_foundation.sldb  standard.sldb"
set link_library        "* ss_1v62_125c.db    $synthetic_library      SP018_V1p4_max.db"
set symbol_library      "smic18m.sdb"

				   
set hdlin_unsigned_integers {true}
set compile_preserve_subdesign_interfaces {true}
set compile_delete_unloaded_sequential_cells false
set verilogout_no_tri {true}
set physopt_fix_multiple_port_nets true
set pdefin_use_nameprefix false
set compile_seqmap_propagate_constants false




#---------------------------------------------------------------------------#


analyze -format verilog $RTL_LIST
elaborate $TOP_DESIGN
current_design  $TOP_DESIGN
uniquify
link

set_operating_conditions -library ss_1v62_125c


create_clock -period 10 -name $CLK 
set_input_delay  6 -clock $CLK  [all_inputs]
set_output_delay       6  -clock $CLK -max [all_outputs]
#set_clock_transition    0.5     [get_clocks $CLK]
#set_dont_touch_network          [get_clocks $CLK]
#set_ideal_network               [get_clocks $CLK]
set_clock_latency       0.2     [get_clocks $CLK]
set_clock_uncertainty   0.3     [get_clocks $CLK]
set_load -pin_load      0.5     [ all_outputs ]
set_max_area            0.0
set_critical_range      0.5     [current_design]
set_max_transition      0.5     [current_design]
set_max_fanout          20       [current_design]

set verilogout_no_tri true
set_fix_multiple_port_nets -all -buffer_constants
set_fix_multiple_port_nets -feedthrough

compile

set verilogout_no_tri true
change_names -rules verilog -hier
set_fix_multiple_port_nets -all -buffer_constants
set_fix_multiple_port_nets -feedthrough

#--------------------------------q-------------------------------------------#

#--:write the DC result to report file!
write -f verilog    -hierarchy -output      ./report/multiplication4_4.v
write -f ddc        -hierarchy -output      ./report/multiplication4_4.ddc
write_sdc                                   ./report/multiplication4_4.sdc
write_sdf                                   ./report/multiplication4_4.sdf

report_timing   -sort_by slack -nets -cap -transition -sig 5 -input_pins -delay max -max_paths 200 > ./report/multiplication4_4.timing
report_area     -hier                   > ./report/multiplication4_4.area
report_constraint       -all_violators  > ./report/multiplication4_4.vio
report_qor                              > ./report/multiplication4_4.qor
report_cell                             > ./report/multiplication4_4.cell
report_power                            > ./report/multiplication4_4.power
check_design                            > ./report/rpt.problem




#process for getting script file directory
variable dispScriptFile [file normalize [info script]]
proc getScriptDirectory {} {
    variable dispScriptFile
    set scriptFolder [file dirname $dispScriptFile]
    return $scriptFolder
}

#change working directory to script file directory
cd [getScriptDirectory]
#set project directory
set projectDir .\/RV32I/RISCV_project

file mkdir $projectDir

# MAKE A PROJECT
create_project RISCV_project $projectDir -part xc7z010clg400-1 -force
set_property board_part digilentinc.com:zybo-z7-10:part0:1.2 [current_project]

add_files -norecurse ./RV32I/TOP_RISCV.vhd 
add_files -norecurse ./RV32I/control_path/alu_decoder.vhd 
add_files -norecurse ./RV32I/data_path/immediate.vhd 
add_files -norecurse ./RV32I/data_path/ALU_simple.vhd 
add_files -norecurse ./RV32I/data_path/register_bank.vhd 
add_files -norecurse ./RV32I/control_path/control_path.vhd 
add_files -norecurse ./RV32I/control_path/ctrl_decoder.vhd
add_files -norecurse ./RV32I/control_path/forwarding_unit.vhd
add_files -norecurse ./RV32I/control_path/hazard_unit.vhd 
add_files -norecurse ./RV32I/data_path/data_path.vhd
add_files -norecurse ./RV32I/packages/alu_ops_pkg.vhd 
add_files -norecurse ./RV32I/packages/txt_util.vhd
add_files -norecurse ./RV32I/packages/controlpath_signals_pkg.vhd
add_files -norecurse ./RV32I/packages/datapath_signals_pkg.vhd
update_compile_order -fileset sources_1
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse ./RV32I/RISCV_tb/BRAM_byte_addressable.vhd
add_files -fileset sim_1 -norecurse ./RV32I/RISCV_tb/TOP_RISCV_tb.vhd
update_compile_order -fileset sim_1

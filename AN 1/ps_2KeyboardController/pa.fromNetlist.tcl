
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name ps_2KeyboardController -dir "D:/PS_2 KeyboardCtrl/ps_2KeyboardController/planAhead_run_1" -part xc3s100ecp132-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/PS_2 KeyboardCtrl/ps_2KeyboardController/ps_2.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/PS_2 KeyboardCtrl/ps_2KeyboardController} }
set_property target_constrs_file "ps_2.ucf" [current_fileset -constrset]
add_files [list {ps_2.ucf}] -fileset [get_property constrset [current_run]]
link_design

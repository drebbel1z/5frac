[Postprocessors]
    # relative pressure at 16A
  [relative_pressure_16a]
    type = FunctionValuePostprocessor
    function = 'relative_pressure_16a'
  []
  
  [L2_diff_pressure_3]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=3.5*24*3600,(relative_pressure_16a-p_in_3)^2,0)'
    pp_names = 'relative_pressure_16a p_in_3'
    use_t= true
  []
  [integrated_L2_diff_pressure_3]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_3
  []

  [L2_diff_pressure_4]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=3.5*24*3600,(relative_pressure_16a-p_in_4)^2,0)'
    pp_names = 'relative_pressure_16a p_in_4'
    use_t= true
  []
  [integrated_L2_diff_pressure_4]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_4
  []

  [L2_diff_pressure_8_3]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=3.5*24*3600,(relative_pressure_16a-p_in_8_3)^2,0)'
    pp_names = 'relative_pressure_16a p_in_8_3'
    use_t= true
  []
  [integrated_L2_diff_pressure_8_3]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_8_3
  []

  [L2_diff_pressure_8_4]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=3.5*24*3600,(relative_pressure_16a-p_in_8_4)^2,0)'
    pp_names = 'relative_pressure_16a p_in_8_4'
    use_t= true
  []
  [integrated_L2_diff_pressure_8_4]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_8_4
  []

  [L2_diff_pressure_10]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=3.5*24*3600,(relative_pressure_16a-p_in_10)^2,0)'
    pp_names = 'relative_pressure_16a p_in_10'
    use_t= true
  []
  [integrated_L2_diff_pressure_10]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_10
  []

  
  [sum_pressures]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = '(integrated_L2_diff_pressure_3+integrated_L2_diff_pressure_4+integrated_L2_diff_pressure_8_3+integrated_L2_diff_pressure_8_4+integrated_L2_diff_pressure_10)/5'
    pp_names = 'integrated_L2_diff_pressure_3 integrated_L2_diff_pressure_4 integrated_L2_diff_pressure_8_3 integrated_L2_diff_pressure_8_4 integrated_L2_diff_pressure_10'
  []

  

    # fluid recovery rate
  # [mass_rate]
  #   type = FunctionValuePostprocessor
  #   function = 'mass_rate'
  # []

  [mass_rate_simulation]
    # right now, match mass rate that will be 2 when projected to 20 days
    type = ParsedPostprocessor
    expression = '(fluid_report/a1_dt/2.65 - 2.4)^2'
    pp_names = 'fluid_report a1_dt'
  []




    #tracer mass rate
  [normalized_exp_tracer_rate]
    type = FunctionValuePostprocessor
    function = 'normalized_exp_tracer_rate'
  [] 

  [normalized_exp_tracer_rate_sq]
    type = ParsedPostprocessor
    expression = 'if(t<${tracer_start_time},0,normalized_exp_tracer_rate*normalized_exp_tracer_rate)'
    pp_names = 'normalized_exp_tracer_rate'
    use_t= true
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [normalized_exp_tracer_rate_sq_integrated]
    type = TimeIntegratedPostprocessor
    value = normalized_exp_tracer_rate_sq
    # execute_on = 'timestep_end'
    # outputs = none
  []


  [sim_tracer_rate]
    type = ParsedPostprocessor
    expression = 'tracer_report / a1_dt'
    pp_names = 'tracer_report a1_dt'
    # execute_on = 'timestep_end'
  []
  
  [sim_tracer_rate_sq]
    type = ParsedPostprocessor
    expression = 'sim_tracer_rate*sim_tracer_rate'
    pp_names = 'sim_tracer_rate'
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [sim_tracer_rate_sq_integrated]
    type = TimeIntegratedPostprocessor
    value = sim_tracer_rate_sq
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [exp_sim_tracer_rate]
    type = ParsedPostprocessor
    expression = 'normalized_exp_tracer_rate*sim_tracer_rate'
    pp_names = 'normalized_exp_tracer_rate sim_tracer_rate'
    # execute_on = 'timestep_end'
    # outputs = none
  []
  [exp_sim_tracer_rate_integrated]
    type = TimeIntegratedPostprocessor
    value = exp_sim_tracer_rate
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [tracer_rate_max]
    type = TimeExtremeValue
    postprocessor = sim_tracer_rate
    # outputs = none
  []

  [integrated_L2_diff_tracer_rate]
    type = ParsedPostprocessor
    expression = 'normalized_exp_tracer_rate_sq_integrated
                   -2*exp_sim_tracer_rate_integrated/(tracer_rate_max+1e-10)
                   +sim_tracer_rate_sq_integrated/(tracer_rate_max+1e-10)/(tracer_rate_max+1e-10)'
    pp_names = 'normalized_exp_tracer_rate_sq_integrated sim_tracer_rate_sq_integrated exp_sim_tracer_rate_integrated tracer_rate_max'
    # execute_on = 'timestep_end'
  []

  [log_inverse_error]
    type = FunctionValuePostprocessor
    function = 'log_inv_error'
    # execute_on = transfer
  []  
[]

[Functions]
  [log_inv_error]
    type = ParsedFunction
    # normalize each of the objectives by the integral of the curve you want
    expression = 'if(t=${endTime},-3*a/3.2978e19 - 5*b/5.76 - 10*c/(d+1e-15),-10^2)'
    symbol_names = 'a b c d'
    symbol_values = 'sum_pressures mass_rate_simulation integrated_L2_diff_tracer_rate normalized_exp_tracer_rate_sq_integrated'
  []

  [relative_pressure_16a]
    type = PiecewiseLinear
    data_file = relative_pressure_well_16A.csv
    format ="columns"
  []

  # [mass_rate]
  #   type = PiecewiseLinear
  #   data_file = mass_rate.csv
  #   format ="columns"
  # []

  [normalized_exp_tracer_rate]
    type = PiecewiseLinear
    data_file = normalized_tracer_rate.csv
    format ="columns"
  []
[]


















  
  

  
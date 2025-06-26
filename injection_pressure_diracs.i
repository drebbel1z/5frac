# created by write_diracs_input.py
[DiracKernels]
  [source_3]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src_stage_3
    point = '173.3267902347 238.3649675763 317.7711687694'
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_4]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src_stage_4
    point = '163.6697730725 237.3241637408 322.2608010408'
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_3]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src_stage_8_3
    point = '10.5909799924 220.8257986353 393.4284792113'
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_4]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src_stage_8_4
    point = '3.3320105757 220.0434490667 396.8032379804'
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_10]
    type = PorousFlowPointSourceFromPostprocessor
    variable = porepressure
    mass_flux = mass_flux_src_stage_10
    point = '-83.6358901331 210.6703141636 437.2353804364'
    point_not_found_behavior = WARNING
    # block = 100
  []
[]

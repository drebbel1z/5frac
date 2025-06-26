# created by write_frac_materials_input.py
# see Materials Property section in porous flow notes: 
# https://mooseframework.inl.gov/modules/porous_flow/multiapp_fracture_flow_PorousFlow_3D.html 
# DFN from fname 
all_frac_ids = "fracture1 fracture2 fracture3 fracture4 fracture5 "

frac_aperture_1 = ${frac_aperature1}
frac_aperture_2 = ${frac_aperature2}
frac_aperture_3 = ${frac_aperature3}
frac_aperture_4 = ${frac_aperature4}
frac_aperture_5 = ${frac_aperature5}

aper_Hi_1 = ${frac_aperture_1}
aper_Hi_2 = ${frac_aperture_2}
aper_Hi_3 = ${frac_aperture_3}
aper_Hi_4 = ${frac_aperture_4}
aper_Hi_5 = ${frac_aperture_5}

aper_Lo = 1e-5

frac_roughness_1 = ${frac_roughness}
frac_roughness_2 = ${frac_roughness}
frac_roughness_3 = ${frac_roughness}
frac_roughness_4 = ${frac_roughness}
frac_roughness_5 = ${frac_roughness}

one_over_bulk = 1.4e-11 #bulk modulus = 70GPa
[AuxVariables]
  [aperture_fracture1]
    order = CONSTANT
    family = MONOMIAL
  []
  [aperture_fracture2]
    order = CONSTANT
    family = MONOMIAL
  []
  [aperture_fracture3]
    order = CONSTANT
    family = MONOMIAL
  []
  [aperture_fracture4]
    order = CONSTANT
    family = MONOMIAL
  []
  [aperture_fracture5]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[AuxKernels]
  [aperture_fracture5]
    type=CapsuleApertureAux
    variable = aperture_fracture5
    start_point ='-83.6358901331 210.6703141636 437.2353804364'
    end_point ='-83.6358901331 210.6703141636 537.2353804364'
    a_max = '${aper_Hi_1}'
    a_min = '${aper_Lo}'
    midpoint_of_sigmoid = 50
    slope_at_midpoint = 1
    block = 'fracture5'
    execute_on = 'INITIAL'
  []

  [aperture_fracture4]
    type=CapsuleApertureAux
    variable = aperture_fracture4
    start_point ='3.3320105757 220.0434490667 396.8032379804'
    end_point ='3.3320105757 220.0434490667 496.8032379804'
    a_max = '${aper_Hi_2}'
    a_min = '${aper_Lo}'
    midpoint_of_sigmoid = 50
    slope_at_midpoint = 0.1
    block = 'fracture4'
    execute_on = 'INITIAL'
  []

  [aperture_fracture3]
    type=CapsuleApertureAux
    variable = aperture_fracture3
    start_point ='10.5909799924 220.8257986353 393.4284792113'
    end_point ='10.5909799924 220.8257986353 493.4284792113'
    a_max = '${aper_Hi_3}'
    a_min = '${aper_Lo}'
    midpoint_of_sigmoid = 50
    slope_at_midpoint = 0.01
    block = 'fracture3'
    execute_on = 'INITIAL'
  []

  [aperture_fracture2]
    type=CapsuleApertureAux
    variable = aperture_fracture2
    start_point ='163.6697730725 237.3241637408 322.2608010408'
    end_point ='163.6697730725 237.3241637408 422.2608010408'
    a_max = '${aper_Hi_4}'
    a_min = '${aper_Lo}'
    midpoint_of_sigmoid = 30
    slope_at_midpoint = 1
    block = 'fracture2'
    execute_on = 'INITIAL'
  []

  [aperture_fracture1]
    type=CapsuleApertureAux
    variable = aperture_fracture1
    start_point ='173.3267902347 238.3649675763 317.7711687694'
    end_point ='173.3267902347 238.3649675763 417.7711687694'
    a_max = '${aper_Hi_5}'
    a_min = '${aper_Lo}'
    midpoint_of_sigmoid = 30
    slope_at_midpoint = 0.1
    block = 'fracture1'
    execute_on = 'INITIAL'
  []
[]

[Materials]
  [porosity_fracture1]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_1}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_1/10}
    block = fracture1
  []
  [porosity_fracture2]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_2}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_2/10}
    block = fracture2
  []
  [porosity_fracture3]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_3}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_3/10}
    block = fracture3
  []
  [porosity_fracture4]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_4}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_4/10}
    block = fracture4
  []
  [porosity_fracture5]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_5}
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_5/10}
    block = fracture5
  []
  [permeability_fracture1]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = ${fparse frac_roughness_1/12*frac_aperture_1^3}
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_1}
    block = fracture1
  []
  [permeability_fracture2]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = ${fparse frac_roughness_2/12*frac_aperture_2^3}
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_2}
    block = fracture2
  []
  [permeability_fracture3]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = ${fparse frac_roughness_3/12*frac_aperture_3^3}
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_3}
    block = fracture3
  []
  [permeability_fracture4]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = ${fparse frac_roughness_4/12*frac_aperture_4^3}
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_4}
    block = fracture4
  []
  [permeability_fracture5]
    type = PorousFlowPermeabilityKozenyCarman
    k0 = ${fparse frac_roughness_5/12*frac_aperture_5^3}
    poroperm_function = kozeny_carman_phi0
    m = 0
    n = 3
    phi0 = ${frac_aperture_5}
    block = fracture5
  []

  [rock_internal_energy_fracture]
    type = PorousFlowMatrixInternalEnergy
    density = 2500
    specific_heat_capacity = 100.0
    block = ${all_frac_ids}
  []

  [thermal_conductivity_fracture]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '3 0 0 0 3 0 0 0 3'
    block = ${all_frac_ids}
  []
[]

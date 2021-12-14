#------------------------------------
# Archetype #4 Parameters
#------------------------------------

#------------------------------------
# Section Properties
#------------------------------------
set hc1	[expr 350*$mm];	# Column #1 section height
set bc1	[expr 350*$mm];	# Column #1 section width

set hc2	[expr 300*$mm];	# Column #2 section height
set bc2	[expr 300*$mm];	# Column #2 section width

set hc3 [expr 250*$mm]; # Column #3 section height
set bc3 [expr 250*$mm]; # Column #3 section height

set hb1	[expr 500*$mm];	# Beam section height (Drop)
set bb1	[expr 300*$mm];	# Beam section width  (Drop)

set sb	[expr 200*$mm];	# Beam stirrup spacing (Drop) was 115mm
set sc	[expr 150*$mm];	# Column stirrup spacing

set cv 	[expr 20*$mm];	# Concrete cover

set H 	[expr 3.00*$m];	# Floor height

set dbL1 	[expr 12*$mm];	# Diameter of longitudinal reinforcement bars
set dbL2 	[expr 14*$mm];	# Diameter of longitudinal reinforcement bars
set dbL3  [expr 16*$mm]; # Diameter of longitudinal reinforcement bars
set dbL4  [expr 20*$mm]; # Diameter of longitudinal reinforcement bars

set dbV 	[expr 6*$mm];	# Diameter of transverse reinforcement bars

#------------------------------------
# Material Properties
#------------------------------------

set fcb1 	15.0;	# fc of beam concrete on first floor (in MPa)
set Ecb1 	[expr 3320*sqrt($fcb1)+6900];	# Elastic modulus of beam concrete on first floor (in MPa)

set fcc1 	15.0;	# fc of column concrete on first floor (in MPa)
set Ecc1 	[expr 3320*sqrt($fcc1)+6900];	# Elastic modulus of column concrete on first floor (in MPa)

set fyL	280.0;	# Yield strength (in MPa) of longitudinal reinforcement bars
set fuL	[expr 1.25*$fyL];	# Ultimate strength (in MPa) of longitudinal reinforcement bars
set fyV	280.0;	# Yield strength (in MPa) of transverse reinforcement bars
set fuV	[expr 1.25*$fyL];	# Ultimate strength (in MPa) of transverse reinforcement bars
set Es 	200e3;	# Elastic modulus of steel (in MPa)

#------------------------------------
# Reinforcement ratios (These are computed based on the reinforcement provided at each plastic hinge zone)
#------------------------------------

#for Columns

#Column #1 (450x450)
set rC1_top 0.00397; 	  set rC1_web 0; 	set rC1_bot 0.00397; 	  set rC1_shr 0.00093; # Column Section #1
#Column #2 (400x400)
set rC2_top 0.00377; 	  set rC2_web 0; 	set rC2_bot 0.00377; 	  set rC2_shr 0.00093; # Column Section #2
#Column #3 (350x350)
set rC3_top 0.00479; 	  set rC3_web 0; 	set rC3_bot 0.00479; 	  set rC3_shr 0.00093; # Column Section #3

#for Beams

#Beam #1 External (500x300)
set rB1_top 0.00308; 	  set rB1_web 0; 	set rB1_bot 0.00205; 	  set rB1_shr 0.00109;	# Beam Section 1
#Beam #2 Internal (500x300)
set rB2_top 0.00411; 	  set rB2_web 0; 	set rB2_bot 0.00308; 	  set rB2_shr 0.00109;	# Beam Section 2

#------------------------------------
# Joint Properties
#------------------------------------

set k_cr_int 	0.29;		set k_pk_int 	0.42;		set k_ult_int 	0.42; 	            # Interior beam-column joints principle tensile stress coefficients (kappa)
set k_cr_ext 	0.132; 	set k_pk_ext 	0.132;	set k_ult_ext 	0.053;	            # Exterior beam-column joints principle tensile stress coefficients (kappa) (0.132, 0.132, 0.053)
set gamm_cr_int		0.0002;	set gamm_pk_int		0.0090;	set gamm_ult_int	0.020;	  # Beam-column joint shear deformations (gamma)
set gamm_cr_ext		0.0002;	set gamm_pk_ext		0.0132;	set gamm_ult_ext	0.027;	  # Beam-column joint shear deformations (gamma)

set ptc_int 	[list $k_cr_int $k_pk_int $k_ult_int $k_cr_int $k_pk_int $k_ult_int];
set ptc_ext 	[list $k_cr_ext $k_pk_ext $k_ult_ext $k_cr_ext $k_pk_ext $k_ult_ext];
set gamm_ext 	[list $gamm_cr_ext $gamm_pk_ext $gamm_ult_ext $gamm_cr_ext $gamm_pk_ext $gamm_ult_ext];
set gamm_int 	[list $gamm_cr_int $gamm_pk_int $gamm_ult_int $gamm_cr_int $gamm_pk_int $gamm_ult_int];

set hyst_ext 	[list 0.6 0.2 0.0 0.0 0.3];
set hyst_int 	[list 0.6 0.2 0.0 0.010 0.3];
set hyst_rof 	[list 0.6 0.2 0.0 0.0 0.3];

set c_c1 		[list $fcc1 $Ecc1 $cv];

set brs1 		[list $dbL1 $dbV]; 		# bars		Bar dias (dbL dbV) m
set brs2 		[list $dbL2 $dbV]; 		# bars		Bar dias (dbL dbV) m
set brs3    [list $dbL3 $dbV];

set col1 		[list $hc1 $bc1]; 			# (hcX hcY) m
set col2 		[list $hc2 $bc2]; 			# (hcX hcY) m
set col3    [list $hc3 $bc3];

set bm1		[list $hb1 $hb1 $bb1 $bb1]; 	# (hbX hbY bbX bbY) m

# --------------------------------------
# Floor Loading
# --------------------------------------
set FloorL	12.0;		# Floor Loading in kPa
set RoofL	  11.5;		# Roof Loading in kPa

set BX1 [expr 3.5*$m];
set BX2 [expr 7.0*$m];
set BX3 [expr 10.0*$m];
set BX4 [expr 12.6*$m];
set BX5 [expr 15.6*$m];
set BX6 [expr 19.1*$m];
set BX7 [expr 22.6*$m];

set BY1 [expr 4.7*$m];
set BY2 [expr 9.2*$m];

set BX34 [expr $BX3+1.3];
set BY231 [expr $BY1+1.00];
set BY232 [expr $BY2-1.00];

set mass11	[expr 0.077433628*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 11 (kkg)
set mass21	[expr 0.154867257*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 21 (kkg)
set mass31	[expr 0.14380531*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 31 (kkg)
set mass41	[expr 0.123893805*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 41 (kkg)
set mass51	[expr 0.123893805*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 51 (kkg)
set mass61	[expr 0.14380531*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 61 (kkg)
set mass71	[expr 0.154867257*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 71 (kkg)
set mass81	[expr 0.077433628*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 81 (kkg)

set mass12	[expr 0.077433628*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 12 (kkg)
set mass22	[expr 0.154867257*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 22 (kkg)
set mass32	[expr 0.14380531*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 32 (kkg)
set mass42	[expr 0.123893805*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 42 (kkg)
set mass52	[expr 0.123893805*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 52 (kkg)
set mass62	[expr 0.14380531*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 62 (kkg)
set mass72	[expr 0.154867257*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 72 (kkg)
set mass82	[expr 0.077433628*0.5*$FloorL*$BX7*$BY2/9.81];		# Mass on column 82 (kkg)

set mass13	[expr 0.077433628*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 13 (kkg)
set mass23	[expr 0.154867257*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 23 (kkg)
set mass33	[expr 0.14380531*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 33 (kkg)
set mass43	[expr 0.123893805*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 43 (kkg)
set mass53	[expr 0.123893805*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 53 (kkg)
set mass63	[expr 0.14380531*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 63 (kkg)
set mass73	[expr 0.154867257*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 73 (kkg)
set mass83	[expr 0.077433628*0.244565217*$FloorL*$BX7*$BY2/9.81];		# Mass on column 83 (kkg)

set mass11r	[expr 0.077433628*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 11 (roof) (kkg)
set mass21r	[expr 0.154867257*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 21 (roof) (kkg)
set mass31r	[expr 0.14380531*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 31 (roof) (kkg)
set mass41r	[expr 0.123893805*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 41 (roof) (kkg)
set mass51r	[expr 0.123893805*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 51 (roof) (kkg)
set mass61r	[expr 0.14380531*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 61 (roof) (kkg)
set mass71r	[expr 0.154867257*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 71 (roof) (kkg)
set mass81r	[expr 0.077433628*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 81 (roof) (kkg)

set mass12r	[expr 0.077433628*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 12 (roof) (kkg)
set mass22r	[expr 0.154867257*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 22 (roof) (kkg)
set mass32r	[expr 0.14380531*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 32 (roof) (kkg)
set mass42r	[expr 0.123893805*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 42 (roof) (kkg)
set mass52r	[expr 0.123893805*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 52 (roof) (kkg)
set mass62r	[expr 0.14380531*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 62 (roof) (kkg)
set mass72r	[expr 0.154867257*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 72 (roof) (kkg)
set mass82r	[expr 0.077433628*0.5*$RoofL*$BX7*$BY2/9.81];		# Mass on column 82 (roof) (kkg)

set mass13r	[expr 0.077433628*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 13 (roof) (kkg)
set mass23r	[expr 0.154867257*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 23 (roof) (kkg)
set mass33r	[expr 0.14380531*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 33 (roof) (kkg)
set mass43r	[expr 0.123893805*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 43 (roof) (kkg)
set mass53r	[expr 0.123893805*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 53 (roof) (kkg)
set mass63r	[expr 0.14380531*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 63 (roof) (kkg)
set mass73r	[expr 0.154867257*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 73 (roof) (kkg)
set mass83r	[expr 0.077433628*0.244565217*$RoofL*$BX7*$BY2/9.81];		# Mass on column 83 (roof) (kkg)

set massT	[expr $FloorL*$BX7*$BY2/9.81];			# Total mass per floor (for PDelta) (kkg)
set massTr	[expr $RoofL*$BX7*$BY2/9.81];			# Total mass per floor (for PDelta) (roof) (kkg)

set bdg_w	[expr ($massTr+($nst-1)*$massT)*$g];

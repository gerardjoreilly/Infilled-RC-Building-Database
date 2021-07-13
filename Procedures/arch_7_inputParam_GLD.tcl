#------------------------------------
# Archetype #7 Parameters
#------------------------------------

#------------------------------------
# Section Properties
#------------------------------------
set hc1	[expr 300*$mm];	# Column #1 section height
set bc1	[expr 300*$mm];	# Column #1 section width

set hc2	[expr 250*$mm];	# Column #2 section height
set bc2	[expr 250*$mm];	# Column #2 section width

set hc3 [expr 200*$mm]; # Column #3 section height
set bc3 [expr 200*$mm]; # Column #3 section height

set hb1	[expr 550*$mm];	# Beam section height (Drop)
set bb1	[expr 300*$mm];	# Beam section width  (Drop)

set sb	[expr 200*$mm];	# Beam stirrup spacing (Drop) was 115mm
set sc	[expr 150*$mm];	# Column stirrup spacing

set cv 	[expr 20*$mm];	# Concrete cover

set H 	[expr 3.00*$m];	# Floor height

set dbL1 	[expr 12*$mm];	# Diameter of longitudinal reinforcement bars
set dbL2 	[expr 14*$mm];	# Diameter of longitudinal reinforcement bars
set dbL3  [expr 16*$mm];  # Diameter of longitudinal reinforcement bars
set dbL4  [expr 20*$mm];  # Diameter of longitudinal reinforcement bars

set dbV 	[expr 6*$mm];	# Diameter of transverse reinforcement bars

#------------------------------------
# Material Properties
#------------------------------------

set fcb1 	15.0;	# fc of beam concrete on first floor (in MPa)
set Ecb1 	[expr 3320*sqrt($fcb1)+6900];	# Elastic modulus of beam concrete on first floor (in MPa)

set fcc1 	15.0;	# fc of column concrete on first floor (in MPa)
set Ecc1 	[expr 3320*sqrt($fcc1)+6900];	# Elastic modulus of column concrete on first floor (in MPa)

set fyL	280.0;	# Yield strength (in MPa) of longitudinal reinforcement bars
set fuL	290.0;	# Ultimate strength (in MPa) of longitudinal reinforcement bars
set fyV	280.0;	# Yield strength (in MPa) of transverse reinforcement bars
set fuV	290.0;	# Ultimate strength (in MPa) of transverse reinforcement bars
set Es 	200e3;	# Elastic modulus of steel (in MPa)

#------------------------------------
# Reinforcement ratios (These are computed based on the reinforcement provided at each plastic hinge zone)
#------------------------------------

#for Columns

#Column #1 (350x350)
set rC1_top 0.00492; 	  set rC1_web 0; 	set rC1_bot 0.00492; 	  set rC1_shr 0.00093; # Column Section #1
#Column #2 (300x300)
set rC2_top 0.00446; 	  set rC2_web 0; 	set rC2_bot 0.00446; 	  set rC2_shr 0.00093; # Column Section #2
#Column #3 (250x250)
set rC3_top 0.00492; 	  set rC3_web 0; 	set rC3_bot 0.00492; 	  set rC3_shr 0.00093; # Column Section #3

#for Beams

#Beam #1 External (550x300)
set rB1_top 0.00609; 	  set rB1_web 0; 	set rB1_bot 0.00487; 	  set rB1_shr 0.00109;	# Beam Section 1
#Beam #2 Internal (550x300)
set rB2_top 0.00731; 	  set rB2_web 0; 	set rB2_bot 0.00609; 	  set rB2_shr 0.00109;	# Beam Section 2

#------------------------------------
# Joint Properties
#------------------------------------

set k_cr_int 	0.29;		set k_pk_int 	0.42;		set k_ult_int 	0.42; 	# Interior beam-column joints principle tensile stress coefficients (kappa)
set k_cr_ext 	0.20; 	set k_pk_ext 	0.20;	   set k_ult_ext 	0.20;	  # Exterior beam-column joints principle tensile stress coefficients (kappa) (0.132, 0.132, 0.053)
set gamm_cr		0.0002;	set gamm_pk		0.0132;	set gamm_ult	0.020;	  # Beam-column joint shear deformations (gamma)

set ptc_int 	[list $k_cr_int $k_pk_int $k_ult_int $k_cr_int $k_pk_int $k_ult_int];
set ptc_ext 	[list $k_cr_ext $k_pk_ext $k_ult_ext $k_cr_ext $k_pk_ext $k_ult_ext];
set gamm_ext 	[list $gamm_cr $gamm_pk $gamm_ult $gamm_cr $gamm_pk $gamm_ult];
set gamm_int 	[list $gamm_cr $gamm_pk $gamm_ult $gamm_cr $gamm_pk $gamm_ult];

set hyst_ext 	[list 0.6 0.2 0.0 0.0 0.3];
set hyst_int 	[list 0.6 0.2 0.0 0.010 0.3];
set hyst_rof 	[list 0.6 0.2 0.0 0.0 0.3];

set c_c1 		[list $fcc1 $Ecc1 $cv];

set brs1 		[list $dbL1 $dbV]; 		# bars		Bar dias (dbL dbV) m
set brs2 		[list $dbL2 $dbV]; 		# bars		Bar dias (dbL dbV) m
set brs3    [list $dbL3 $dbV];
set brs4    [list $dbL4 $dbV];

set col1 		[list $hc1 $bc1]; 			# (hcX hcY) m
set col2 		[list $hc2 $bc2]; 			# (hcX hcY) m
set col3    [list $hc3 $bc3];

set bm1		[list $hb1 $hb1 $bb1 $bb1]; 	# (hbX hbY bbX bbY) m

# --------------------------------------
# Floor Loading
# --------------------------------------

set FloorL	10.0;		# Floor Loading in kPa
set RoofL	   9.5;		# Roof Loading in kPa

set BX1 [expr 5.40*$m];
set BX2 [expr 8.40*$m];
set BX3 [expr 13.40*$m];

set BY1 [expr 3.50*$m];
set BY2 [expr 5.50*$m];
set BY3 [expr 9.00*$m];

set BX34  [expr $BX1+1.50];
set BY231 [expr $BY3-1.00];

set mass11	[expr 0.195652174*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 11 (kkg)
set mass21	[expr 0.304347826*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 21 (kkg)
set mass31	[expr 0.304347826*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 31 (kkg)
set mass41	[expr 0.195652174*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 41 (kkg)

set mass12	[expr 0.195652174*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 12 (kkg)
set mass22	[expr 0.304347826*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 22 (kkg)
set mass32	[expr 0.304347826*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 32 (kkg)
set mass42	[expr 0.195652174*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 42 (kkg)

set mass13	[expr 0.195652174*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 13 (kkg)
set mass23	[expr 0.304347826*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 23 (kkg)
set mass33	[expr 0.304347826*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 33 (kkg)
set mass43	[expr 0.195652174*0.305555556*$FloorL*$BX3*$BY3/9.81];		# Mass on column 43 (kkg)

set mass14	[expr 0.195652174*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 14 (kkg)
set mass24	[expr 0.304347826*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 24 (kkg)
set mass34	[expr 0.304347826*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 34 (kkg)
set mass44	[expr 0.195652174*0.194444444*$FloorL*$BX3*$BY3/9.81];		# Mass on column 44 (kkg)

set mass11r	[expr 0.195652174*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 11 (roof) (kkg)
set mass21r	[expr 0.304347826*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 21 (roof) (kkg)
set mass31r	[expr 0.304347826*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 31 (roof) (kkg)
set mass41r	[expr 0.195652174*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 41 (roof) (kkg)

set mass12r	[expr 0.195652174*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 12 (roof) (kkg)
set mass22r	[expr 0.304347826*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 22 (roof) (kkg)
set mass32r	[expr 0.304347826*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 32 (roof) (kkg)
set mass42r	[expr 0.195652174*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 42 (roof) (kkg)

set mass13r	[expr 0.195652174*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 13 (roof) (kkg)
set mass23r	[expr 0.304347826*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 23 (roof) (kkg)
set mass33r	[expr 0.304347826*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 33 (roof) (kkg)
set mass43r	[expr 0.195652174*0.305555556*$RoofL*$BX3*$BY3/9.81];		# Mass on column 43 (roof) (kkg)

set mass14r	[expr 0.195652174*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 14 (roof) (kkg)
set mass24r	[expr 0.304347826*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 24 (roof) (kkg)
set mass34r	[expr 0.304347826*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 34 (roof) (kkg)
set mass44r	[expr 0.195652174*0.194444444*$RoofL*$BX3*$BY3/9.81];		# Mass on column 44 (roof) (kkg)

set massT	[expr $FloorL*$BX3*$BY3/9.81];			# Total mass per floor (for PDelta) (kkg)
set massTr	[expr $RoofL*$BX3*$BY3/9.81];			# Total mass per floor (for PDelta) (roof) (kkg)

set bdg_w	[expr ($massTr+($nst-1)*$massT)*$g];

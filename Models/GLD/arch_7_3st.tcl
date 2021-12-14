# --------------------------------------------------
# 3D Model of Archetype Plan #7
# --------------------------------------------------
# Copyright by Al Mouayed Bellah Nafeh
# IUSS Pavia, Italy
# April 2020
# Description: 3-storey infilled RC building
# --------------------------------------------------
puts "Welcome..."

file mkdir $outsdir
file mkdir $outsdir/info/props
file mkdir $outsdir/info/models
file mkdir $outsdir/info/modal
file mkdir $outsdir/info/recorders

global procdir
global modeldir
global MPa
global mm
global AType

# --------------------------------------
# Define the model
# --------------------------------------
#  3D Model (3-dimensional, 6 degrees-of-freedom)
model basic -ndm 3 -ndf 6

# --------------------------------------
# Load some procedures
# --------------------------------------
# These following two files are in another repository

source $procdir/Units.tcl
source $procdir/rcBC_nonDuct.tcl
source $procdir/jointModel.tcl
source $procdir/modalAnalysis.tcl
source $procdir/infill.tcl
source $procdir/infill_prop.tcl
source $procdir/arch_7_inputParam_GLD.tcl

# --------------------------------------
# Define some basic model parameters
# --------------------------------------
# Dimensions and General Para.

set nst 3; #Number of Stories
set mtype "Infill"; #Typology
set STb 1; #Shear Hinge for Beam (0: No, 1: Yes)
set STc 1; #Shear Hinge for Column (0: No, 1: Yes)
set stairsOPT 0; #Add Stairs (0: No, 1: Yes)
set infillsOPT 1; #Add Infills (0: No, 1: Yes)
set pilotisOPT 0; #Remove Infills on Ground Floor (0: No, 1: Yes)


# --------------------------------------
# Define the base nodes
# --------------------------------------
# node 	tag 	X		Y		Z
# Base Nodes

# Y=1;
node	1110		0.0		  0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1210		$BX1		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1310		$BX2		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1410		$BX3		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=2;
node	1120		0.0		  $BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1220		$BX1		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1320		$BX2		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1420		$BX3		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=3;
node	1130		0.0		  $BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1230		$BX1		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1330		$BX2		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1430		$BX3		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=4;
node	1140		0.0		  $BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1240		$BX1		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1340		$BX2		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1440		$BX3		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

if {$stairsOPT == 1} {
#Define the staircase Nodes

#nodes on landing [on intersection of axis 3(in x) and between axes 3 and 4(in y) every 0.5 floor]
node 10 $BX2 $BY231 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 11 $BX2 $BY231 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of axis 2(in x) and between axes 3 and 4(in y) every 0.5 floor]
node 20 $BX1 $BY231 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 21 $BX1 $BY231 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of between axes 2-3 (in x) and 3-4 (in y) every 0.5 floor]
node 30 $BX34 $BY231 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 31 $BX34 $BY231 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#mid-stair node which starts at level 0 to level 5
node 40 $BX34 $BY2 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 41 $BX34 $BY2 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 42 $BX34 $BY2 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#split the columns nodes

node 12401 $BX1 $BY3 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 12412 $BX1 $BY3 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 13401 $BX2 $BY3 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 13412 $BX2 $BY3 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

}

# --------------------------------------
# Define Transformations
# --------------------------------------
# Use P-Delta geometric transformations. Include rigid-end offsets to account for the rigid zones of the beam-column joints.
# These are incorporated here as opposed to inserting rigid members at each joint for computational efficiency.
geomTransf PDelta 	1  0 1 0 -jntOffset 0.0 0.0 [expr $hc1/2] 0.0 0.0 [expr -$hc1/2] ; # z is in Y
geomTransf PDelta 	2  0 1 0 -jntOffset 0.0 0.0 [expr $hc2/2] 0.0 0.0 [expr -$hc2/2] ; # z is in Y
geomTransf PDelta 	3  0 1 0 -jntOffset 0.0 0.0 [expr $hc3/2] 0.0 0.0 [expr -$hc3/2] ; # z is in Y

geomTransf PDelta 	5  0 1 0 -jntOffset [expr $hb1/2] 0.0 0.0  [expr -$hb1/2]  0.0 0.0 ; # z is in Y
geomTransf PDelta 	6  -1 0 0 -jntOffset 0.0 [expr $hb1/2] 0.0  0.0 [expr -$hb1/2]  0.0 ; # z is in Y

set GTc1 1;
set GTc2 2;
set GTc3 3;

set GTbX1	5;
set GTbY1 6;
# --------------------------------------
# Define Elements
# --------------------------------------
# Open a set of files so that the properties of the beams, columns and joint elements creted using the provided procedures can be examined later.
set pfile_jnts [open $outsdir/Properties_joints.txt w];
set pfile_bms  [open $outsdir/Properties_beams.txt w];
set pfile_cols [open $outsdir/Properties_columnn.txt w];

# Build the model without stairs
if {$stairsOPT == 0} {
puts " # -------------------------------------------------- "
puts " # Building Model without Stairs			                "
puts " # -------------------------------------------------- "
# -------------------
# Joints
# -------------------
# Y=1; 1st Floor
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=4; 1st Floor
jointModel 	 "Exterior"	141 	[list 0.00 $BY3 [expr 1*$H]] $mass14 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	241 	[list $BX1 $BY3 [expr 1*$H]] $mass24 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	341 	[list $BX2 $BY3 [expr 1*$H]] $mass34 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	441 	[list $BX3 $BY3 [expr 1*$H]] $mass44 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=4; 2nd Floor
jointModel 	 "Exterior"	142 	[list 0.00 $BY3 [expr 2*$H]] $mass14 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	242 	[list $BX1 $BY3 [expr 2*$H]] $mass24 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	342 	[list $BX2 $BY3 [expr 2*$H]] $mass34 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	442 	[list $BX3 $BY3 [expr 2*$H]] $mass44 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=4; 3rd Floor
jointModel 	 "Exterior"	143 	[list 0.00 $BY3 [expr 3*$H]] $mass14 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	243 	[list $BX1 $BY3 [expr 3*$H]] $mass24 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	343 	[list $BX2 $BY3 [expr 3*$H]] $mass34 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	443 	[list $BX3 $BY3 [expr 3*$H]] $mass44 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct   $STb 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
#rcBC_nonDuct   $STb 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_nonDuct   $STb 	5141 $GTbX1  6141 6241 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5241 $GTbX1  6241 6341 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5341 $GTbX1  6341 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_nonDuct   $STb 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
#rcBC_nonDuct   $STb 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_nonDuct   $STb 	5142 $GTbX1  6142 6242 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5242 $GTbX1  6242 6342 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5342 $GTbX1  6342 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# Y=1;
rcBC_nonDuct   $STb 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
#rcBC_nonDuct   $STb 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_nonDuct   $STb 	5143 $GTbX1  6143 6243 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5243 $GTbX1  6243 6343 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5343 $GTbX1  6343 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_nonDuct   $STb 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.25  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6131 $GTbY1  6131 6141 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6411 $GTbY1  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6421 $GTbY1  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6431 $GTbY1  6431 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_nonDuct   $STb 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.25  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6132 $GTbY1  6132 6142 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6412 $GTbY1  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6422 $GTbY1  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6432 $GTbY1  6432 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# X=1;
rcBC_nonDuct   $STb 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.25  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6133 $GTbY1  6133 6143 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6413 $GTbY1  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6423 $GTbY1  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6433 $GTbY1  6433 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct  $STc 	7111 $GTc2 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7211 $GTc2 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7311 $GTc2 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7411 $GTc2 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7121 $GTc2 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7221 $GTc2 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7321 $GTc2 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7421 $GTc2 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7131 $GTc2 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7231 $GTc2 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7331 $GTc2 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7431 $GTc2 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

# Y=4;
rcBC_nonDuct  $STc 	7141 $GTc2 1140 	1141 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7241 $GTc2 1240 	1241 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7341 $GTc2 1340 	1341 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7441 $GTc2 1440 	1441 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#2nd Floor

# Y=1;
rcBC_nonDuct  $STc 	7112 $GTc3 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7212 $GTc3 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7312 $GTc3 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7412 $GTc3 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7122 $GTc3 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7222 $GTc3 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7322 $GTc3 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7422 $GTc3 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7132 $GTc3 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7232 $GTc3 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7332 $GTc3 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7432 $GTc3 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=4;
rcBC_nonDuct  $STc 	7142 $GTc3 1141 	1142 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass14+$mass14r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7242 $GTc3 1241 	1242 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass24+$mass24r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7342 $GTc3 1341 	1342 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass34+$mass34r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7442 $GTc3 1441 	1442 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass44+$mass44r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

#3rd Floor

# Y=1;
rcBC_nonDuct  $STc 	7113 $GTc3 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7213 $GTc3 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7313 $GTc3 1312 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7413 $GTc3 1412 	1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7123 $GTc3 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7223 $GTc3 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7323 $GTc3 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7423 $GTc3 1422 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7133 $GTc3 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7233 $GTc3 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7333 $GTc3 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7433 $GTc3 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=4;
rcBC_nonDuct  $STc 	7143 $GTc3 1142 	1143 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass14+$mass14r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7243 $GTc3 1242 	1243 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass24+$mass24r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7343 $GTc3 1342 	1343 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass34+$mass34r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7443 $GTc3 1442 	1443 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass44+$mass44r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

puts "Columns created..."
}

# Build the model with stairs
if {$stairsOPT == 1} {
puts " # -------------------------------------------------- "
puts " # Building Model with Stairs			                    "
puts " # -------------------------------------------------- "
# -------------------
# Joints
# -------------------
# Y=1; 1st Floor
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=4; 1st Floor
jointModel 	 "Exterior"	141 	[list 0.00 $BY3 [expr 1*$H]] $mass14 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	241 	[list $BX1 $BY3 [expr 1*$H]] $mass24 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	341 	[list $BX2 $BY3 [expr 1*$H]] $mass34 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	441 	[list $BX3 $BY3 [expr 1*$H]] $mass44 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=4; 2nd Floor
jointModel 	 "Exterior"	142 	[list 0.00 $BY3 [expr 2*$H]] $mass14 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	242 	[list $BX1 $BY3 [expr 2*$H]] $mass24 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	342 	[list $BX2 $BY3 [expr 2*$H]] $mass34 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	442 	[list $BX3 $BY3 [expr 2*$H]] $mass44 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=4; 3rd Floor
jointModel 	 "Exterior"	143 	[list 0.00 $BY3 [expr 3*$H]] $mass14 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	243 	[list $BX1 $BY3 [expr 3*$H]] $mass24 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	343 	[list $BX2 $BY3 [expr 3*$H]] $mass34 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	443 	[list $BX3 $BY3 [expr 3*$H]] $mass44 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct   $STb 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
#rcBC_nonDuct   $STb 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_nonDuct   $STb 	5141 $GTbX1  6141 6241 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5241 $GTbX1  6241 6341 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5341 $GTbX1  6341 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_nonDuct   $STb 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
#rcBC_nonDuct   $STb 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_nonDuct   $STb 	5142 $GTbX1  6142 6242 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5242 $GTbX1  6242 6342 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5342 $GTbX1  6342 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# Y=1;
rcBC_nonDuct   $STb 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
#rcBC_nonDuct   $STb 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_nonDuct   $STb 	5143 $GTbX1  6143 6243 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5243 $GTbX1  6243 6343 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5343 $GTbX1  6343 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.700  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_nonDuct   $STb 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.25  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6131 $GTbY1  6131 6141 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6411 $GTbY1  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6421 $GTbY1  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6431 $GTbY1  6431 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_nonDuct   $STb 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.25  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6132 $GTbY1  6132 6142 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6412 $GTbY1  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6422 $GTbY1  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6432 $GTbY1  6432 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# X=1;
rcBC_nonDuct   $STb 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.25  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6133 $GTbY1  6133 6143 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6413 $GTbY1  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6423 $GTbY1  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6433 $GTbY1  6433 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 1.75  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct  $STc 	7111 $GTc2 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7211 $GTc2 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7311 $GTc2 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7411 $GTc2 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7121 $GTc2 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7221 $GTc2 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7321 $GTc2 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7421 $GTc2 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7131 $GTc2 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7231 $GTc2 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7331 $GTc2 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7431 $GTc2 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

# Y=4;
rcBC_nonDuct  $STc 	7141 $GTc2 1140 	1141 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_nonDuct  $STc 	72401 $GTc2 1240 	12401 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7241 $GTc2 12401 	1241 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

rcBC_nonDuct  $STc 	73401 $GTc2 1340 	13401 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7341 $GTc2 13401 	1341 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
#--------------------

rcBC_nonDuct  $STc 	7441 $GTc2 1440 	1441 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#2nd Floor

# Y=1;
rcBC_nonDuct  $STc 	7112 $GTc3 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7212 $GTc3 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7312 $GTc3 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7412 $GTc3 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7122 $GTc3 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7222 $GTc3 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7322 $GTc3 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7422 $GTc3 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7132 $GTc3 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7232 $GTc3 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7332 $GTc3 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7432 $GTc3 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=4;
rcBC_nonDuct  $STc 	7142 $GTc3 1141 	1142 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass14+$mass14r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_nonDuct  $STc 	72412 $GTc3 1241 	12412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass24+$mass24r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7242 $GTc3 12412 	1242 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass24+$mass24r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

rcBC_nonDuct  $STc 	73412 $GTc3 1341 	13412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass34+$mass34r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7342 $GTc3 13412 	1342 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass34+$mass34r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
#--------------------

rcBC_nonDuct  $STc 	7442 $GTc3 1441 	1442 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (1*$mass44+$mass44r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

#3rd Floor

# Y=1;
rcBC_nonDuct  $STc 	7113 $GTc3 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7213 $GTc3 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7313 $GTc3 1312 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7413 $GTc3 1412 	1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7123 $GTc3 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7223 $GTc3 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7323 $GTc3 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7423 $GTc3 1422 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7133 $GTc3 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7233 $GTc3 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7333 $GTc3 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7433 $GTc3 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

# Y=4;
rcBC_nonDuct  $STc 	7143 $GTc3 1142 	1143 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass14+$mass14r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7243 $GTc3 1242 	1243 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass24+$mass24r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7343 $GTc3 1342 	1343 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass34+$mass34r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7443 $GTc3 1442 	1443 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL2 $dbV [expr (0*$mass44+$mass44r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

puts "Columns created..."
}

if {$infillsOPT == 1} {
# -------------------
# Infills
# -------------------
# X-Direction
# -------------------
if {$pilotisOPT == 0} {
# 1st Floor

# Y=1;
infill 		2111 	single 	[list 1111 1211 1210 1110] 	 5400. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2311 	single 	[list 1311 1411 1410 1310] 	 5400. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2221 	single 	[list 1221 1321 1320 1220] 	 3000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=4;
infill 		2141 	single 	[list 1141 1241 1240 1140] 	 5400. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2241 	single 	[list 1241 1341 1340 1240] 	 3000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2341 	single 	[list 1341 1441 1440 1340] 	 5400. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

}

# 2nd Floor

# Y=1;
infill 		2112 	single 	[list 1112 1212 1211 1111] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2312 	single 	[list 1312 1412 1411 1311] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2222 	single 	[list 1222 1322 1321 1221] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=4;
infill 		2142 	single 	[list 1142 1242 1241 1141] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2242 	single 	[list 1242 1342 1341 1241] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2342 	single 	[list 1342 1442 1441 1341] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 3rd Floor

# Y=1;
infill 		2113 	single 	[list 1113 1213 1212 1112] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2313 	single 	[list 1313 1413 1412 1312] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2223 	single 	[list 1223 1323 1322 1222] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=4;
infill 		2143 	single 	[list 1143 1243 1242 1142] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2243 	single 	[list 1243 1343 1342 1242] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2343 	single 	[list 1343 1443 1442 1342] 	 5400. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# -------------------
# Y-Direction
# -------------------
if {$pilotisOPT==0} {
# 1st Floor

# X=1;
infill 		3111 	single 	[list 1111 1121 1120 1110] 	3500. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3211 	single 	[list 1121 1131 1130 1120] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3311 	single 	[list 1131 1141 1140 1130] 	3500. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=2;
infill 		3121 	single 	[list 1211 1221 1220 1210] 	3500. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3221 	single 	[list 1221 1231 1230 1220] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=3;
infill 		3131 	single 	[list 1311 1321 1320 1310] 	3500. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3231 	single 	[list 1321 1331 1330 1320] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3141 	single 	[list 1411 1421 1420 1410] 	3500. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3241 	single 	[list 1421 1431 1430 1420] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3341 	single 	[list 1431 1441 1440 1430] 	3500. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

}

# 2nd Floor

# X=1;
infill 		3112 	single 	[list 1112 1122 1121 1111] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3212 	single 	[list 1122 1132 1131 1121] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3312 	single 	[list 1132 1142 1141 1131] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=2;
infill 		3122 	single 	[list 1212 1222 1221 1211] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3222 	single 	[list 1222 1232 1231 1221] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=3;
infill 		3132 	single 	[list 1312 1322 1321 1311] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3232 	single 	[list 1322 1332 1331 1321] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3142 	single 	[list 1412 1422 1421 1411] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3242 	single 	[list 1422 1432 1431 1421] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3342 	single 	[list 1432 1442 1441 1431] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 3rd Floor

# X=1;
infill 		3113 	single 	[list 1113 1123 1122 1112] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3213 	single 	[list 1123 1133 1132 1122] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3313 	single 	[list 1133 1143 1142 1132] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=2;
infill 		3123 	single 	[list 1213 1223 1222 1212] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3223 	single 	[list 1223 1233 1232 1222] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=3;
infill 		3133 	single 	[list 1313 1323 1322 1312] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3233 	single 	[list 1323 1333 1332 1322] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3143 	single 	[list 1413 1423 1422 1412] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3243 	single 	[list 1423 1433 1432 1422] 	2000. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3343 	single 	[list 1433 1443 1442 1432] 	3500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

puts "Infills created..."
}

# --------------------------------------
# DEFINE STAIRS
# --------------------------------------
if {$stairsOPT == 1} {

  # Stairs from 0 to 1

  rcBC_nonDuct            $STb 	99911     $GTbY1  1330 10 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99921     $GTbY1  40   30 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99931     $GTbY1  10 13401 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99941     $GTbX1  13401 12401 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99951     $GTbY1  12401 20 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99961     $GTbX1  10 30 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99971     $GTbX1  30 20 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99981     $GTbY1  30 41    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99991     $GTbY1  20 1231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999101     $GTbX1  1231 41 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999111     $GTbX1  41 1331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  # Stairs from 1 to 2
	rcBC_nonDuct            $STb 	99912     $GTbY1  1331 11 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99922     $GTbY1  41   31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99932     $GTbY1  11 13412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99942     $GTbX1  13412 12412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99952     $GTbY1  12412 21 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99962     $GTbX1  11 31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99972     $GTbX1  31 21 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99982     $GTbY1  31 42    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99992     $GTbY1  21 1232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999102     $GTbX1  1232 42 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Stairs created..."
}


close $pfile_jnts
close $pfile_cols
close $pfile_bms

# --------------------------------------
# BOUNDARY CONDITIONS
# --------------------------------------
# Base Supports
# fix 	node	dX dY dZ rX rY rZ
fix 	1110	1  1  1  1  1  1
fix 	1210	1  1  1  1  1  1
fix 	1310	1  1  1  1  1  1
fix 	1410	1  1  1  1  1  1

fix 	1120	1  1  1  1  1  1
fix 	1220	1  1  1  1  1  1
fix 	1320	1  1  1  1  1  1
fix 	1420	1  1  1  1  1  1

fix 	1130	1  1  1  1  1  1
fix 	1230	1  1  1  1  1  1
fix 	1330	1  1  1  1  1  1
fix   1430  1  1  1  1  1  1

fix 	1140	1  1  1  1  1  1
fix 	1240	1  1  1  1  1  1
fix 	1340	1  1  1  1  1  1
fix   1440  1  1  1  1  1  1

# Rigid Diaphragm

rigidDiaphragm 3	1231 1111 1211 1311 1411 1121 1221 1321 1421 1131 1331 1431 1141 1241 1341 1441
rigidDiaphragm 3	1232 1112 1212 1312 1412 1122 1222 1322 1422 1132 1332 1432 1142 1242 1342 1442
rigidDiaphragm 3	1233 1113 1213 1313 1413 1123 1223 1323 1423 1133 1333 1433 1143 1243 1343 1443

# --------------------------------------
# GRAVITY LOAD PATTERN + ANALYSIS
# --------------------------------------
# Assign the loads
pattern Plain 101 Constant {
	load 1111 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # First Floor
	load 1211 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0; # First Floor
	load 1311 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0; # First Floor
	load 1411 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0; # First Floor

	load 1121 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0; # First Floor
	load 1221 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0; # First Floor
	load 1321 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0; # First Floor
	load 1421 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0; # First Floor

	load 1131 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0; # First Floor
	load 1231 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0; # First Floor
	load 1331 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0; # First Floor
	load 1431 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0; # First Floor

	load 1141 	0.0	0.0	[expr -$mass14*$g] 	0.0	0.0	0.0; # First Floor
	load 1241 	0.0	0.0	[expr -$mass24*$g] 	0.0	0.0	0.0; # First Floor
	load 1341 	0.0	0.0	[expr -$mass34*$g] 	0.0	0.0	0.0; # First Floor
	load 1441 	0.0	0.0	[expr -$mass44*$g] 	0.0	0.0	0.0; # First Floor

  load 1112 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Second Floor
  load 1212 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1312 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1412 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;

  load 1122 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1222 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1322 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
	load 1422 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;

  load 1132 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1232 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1332 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
	load 1432 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;

	load 1142 	0.0	0.0	[expr -$mass14*$g] 	0.0	0.0	0.0;
	load 1242 	0.0	0.0	[expr -$mass24*$g] 	0.0	0.0	0.0;
	load 1342 	0.0	0.0	[expr -$mass34*$g] 	0.0	0.0	0.0;
	load 1442 	0.0	0.0	[expr -$mass44*$g] 	0.0	0.0	0.0;

  load 1113 	0.0	0.0	[expr -$mass11r*$g] 	0.0	0.0	0.0; # Third Floor
  load 1213 	0.0	0.0	[expr -$mass21r*$g] 	0.0	0.0	0.0;
  load 1313 	0.0	0.0	[expr -$mass31r*$g] 	0.0	0.0	0.0;
	load 1413 	0.0	0.0	[expr -$mass41r*$g] 	0.0	0.0	0.0;

  load 1123 	0.0	0.0	[expr -$mass12r*$g] 	0.0	0.0	0.0;
  load 1223 	0.0	0.0	[expr -$mass22r*$g] 	0.0	0.0	0.0;
  load 1323 	0.0	0.0	[expr -$mass32r*$g] 	0.0	0.0	0.0;
	load 1423 	0.0	0.0	[expr -$mass42r*$g] 	0.0	0.0	0.0;

  load 1133 	0.0	0.0	[expr -$mass13r*$g] 	0.0	0.0	0.0;
  load 1233 	0.0	0.0	[expr -$mass23r*$g] 	0.0	0.0	0.0;
  load 1333 	0.0	0.0	[expr -$mass33r*$g] 	0.0	0.0	0.0;
	load 1433 	0.0	0.0	[expr -$mass43r*$g] 	0.0	0.0	0.0;

	load 1143 	0.0	0.0	[expr -$mass14r*$g] 	0.0	0.0	0.0;
	load 1243 	0.0	0.0	[expr -$mass24r*$g] 	0.0	0.0	0.0;
	load 1343 	0.0	0.0	[expr -$mass34r*$g] 	0.0	0.0	0.0;
	load 1443 	0.0	0.0	[expr -$mass44r*$g] 	0.0	0.0	0.0;

}

# Apply the load
constraints Transformation
numberer RCM
system UmfPack
test NormDispIncr	1e-6 500
algorithm Newton
set nG 100;
integrator LoadControl [expr 1/$nG]
analysis Static
analyze $nG

# maintain constant gravity loads and reset time to zero
loadConst -time 0.0

# --------------------------------------
# MODAL ANALYSIS
# --------------------------------------
modalAnalysis $nst 1 _Archetype_7_${nst}st_${mtype} "$outsdir/info/modal/"

# --------------------------------------
# PRINT STUFF
# --------------------------------------
file delete $outsdir/info/models/Archetype_7_model_${nst}st_${mtype}.txt
print $outsdir/info/models/Archetype_7_model_${nst}st_${mtype}.txt

# --------------------------------------
# DEFINE RECORDERS
# --------------------------------------
set node_recorder 		{1230 1231 1232 1233}; # List of nodes to record
#set beam_recorder		{5111 5211 5311 5411 5511 5611 5121 5221 5321 5421 5521 5621 5131 5231 5331 5431 5531 5631 5112 5212 5312 5412 5512 5612 5122 5222 5322 5422 5522 5622 5132 5232 5332 5432 5532 5632};
#set column_recorder 	{7111 7211 7311 7411 7511  7121 7221 7321 7421 7521 7621 7131 7231 7331 7431 7531 7651 7112 7212 7312 7412 7512 7612 7122 7222 7322 7422 7522 7622 7132 7232 7332 7432 7532 7632};
#set joint_recorder 		{9111 9211 9311 9411 9511  9121 9221 9321 9421 9521 9621 9131 9231 9331 9431 9531 9631 9112 9212 9312 9412 9512 9612 9122 9222 9322 9422 9522 9622 9132 9232 9332 9432 9532 9632}; # The centre joint hinges

set bNode {1230 1231 1232}; # iNodes for drift
set tNode {1231 1232 1233}; # jNodes for drift
set baseNode 1230; # Base Node (for roof drift recorder)
set roofNode 1233; # Top Node


# Print a list of the elements and nodes recorded
file delete $outsdir/info/recorders/Archetype_7_recordersList_${nst}st_${mtype}.m
set rec_list [open $outsdir/info/recorders/Archetype_7_recordersList_${nst}st_${mtype}.m w];
puts $rec_list "node_list=\[$node_recorder];"
puts $rec_list "bNode=\[$bNode];"
puts $rec_list "tNode=\[$tNode];"
puts $rec_list "bdg_w=$bdg_w;"
close $rec_list


# --------------------------------------
# LATERAL ANALYSIS PARAMETERS
# --------------------------------------
if {$AType == "NRHA" || $AType == "IDA"} {
	# --------------------------------------
	# DEFINE DAMPING
	# --------------------------------------
	# Use a constant modal damping model
	modalDamping $xi

	# --------------------------------------
	# DEFINE TIME SERIES
	# --------------------------------------
	set tsTagX 1		; # Set a timeseries tag, this is needed for total floor acceleration recorder
	set tsTagY 2		; # Set a timeseries tag, this is needed for total floor acceleration recorder
	set pTagX 1		; # Set a pattern tag
	set pTagY 2		; # Set a pattern tag
	timeSeries Path $tsTagX -dt $dtX -filePath $EQnameX -factor $sfX
	timeSeries Path $tsTagY -dt $dtY -filePath $EQnameY -factor $sfY

	# --------------------------------------
	# DEFINE LOAD PATTERN
	# --------------------------------------
	#pattern  UniformExcitation       ptag     dir  -accel  timetag
	pattern UniformExcitation 		  $pTagX 	1 -accel $tsTagX
	pattern UniformExcitation 		  $pTagY 	2 -accel $tsTagY

  # --------------------------------------
  # DEFINE RECORDERS
  # --------------------------------------
  # Displacements
  eval "recorder Node	-file $outsdir/dispX.${AType}.${nst}st_${mtype}.$run.txt 	-node $node_recorder -dof 1 disp"
  eval "recorder Node	-file $outsdir/dispY.${AType}.${nst}st_${mtype}.$run.txt 	-node $node_recorder -dof 2 disp"
  # Storey Drifts
  eval "recorder Drift -file $outsdir/drftX.${AType}.${nst}st_${mtype}.$run.txt -iNode $bNode -jNode $tNode -dof 1 -perpDirn 3"
  eval "recorder Drift -file $outsdir/drftY.${AType}.${nst}st_${mtype}.$run.txt -iNode $bNode -jNode $tNode -dof 2 -perpDirn 3"
  # Relative Accelerations
  eval "recorder Node	-file $outsdir/accelRelX.${AType}.${nst}st_${mtype}.$run.txt -time -node $node_recorder -dof 1 accel"
  eval "recorder Node	-file $outsdir/accelRelY.${AType}.${nst}st_${mtype}.$run.txt -time -node $node_recorder -dof 2 accel"
  # Floor Accelerations (if no timeseries given, records relative accel)
  eval "recorder Node	-file $outsdir/accelX.${AType}.${nst}st_${mtype}.$run.txt -time -timeSeries $tsTagX -node $node_recorder -dof 1 accel"
  eval "recorder Node	-file $outsdir/accelY.${AType}.${nst}st_${mtype}.$run.txt -time -timeSeries $tsTagY -node $node_recorder -dof 2 accel"


	# --------------------------------------
	# DEFINE ANALYSIS OBJECTS
	# --------------------------------------
	constraints Transformation
	numberer RCM
	system UmfPack

}

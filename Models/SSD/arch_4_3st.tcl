# --------------------------------------------------
# 3D Model of Archetype Plan #4
# --------------------------------------------------
# Copyright by Al Mouayed Bellah Nafeh
# IUSS Pavia, Italy
# April 2020
# Description: 3-storey infilled RC frame
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
source $procdir/arch_4_inputParam_SSD.tcl

# --------------------------------------
# Define some basic model parameters
# --------------------------------------
# Dimensions and General Para.

set nst 3; #Number of Stories
set mtype "Infill"; #Typology
set STb 0; #Shear Hinge for Beam (0: No, 1: Yes)
set STc 1; #Shear Hinge for Column (0: No, 1: Yes)
set stairsOPT 0; #Add Stairs (0: No, 1: Yes)
set infillsOPT 1; #Add Infills (0: No, 1: Yes)
set pilotisOPT 0; #Open Ground Floor (0: No, 1: Yes)

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
node	1510		$BX4		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1610		$BX5		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1710		$BX6		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1810		$BX7		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=2;
node	1120		0.0		  $BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1220		$BX1		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1320		$BX2		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1420		$BX3		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1520		$BX4		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1620		$BX5		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1720		$BX6		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1820		$BX7		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=3;
node	1130		0.0		  $BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1230		$BX1		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1330		$BX2		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1430		$BX3		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1530		$BX4		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1630		$BX5		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1730		$BX6		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1830		$BX7		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

if {$stairsOPT == 1} {
#Define the staircase Nodes

#nodes on landing [on intersection of axis 3(in x) and between axes 3 and 4(in y) every 0.5 floor]
node 10 $BX4 $BY232 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 11 $BX4 $BY232 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of axis 4(in x) and between axes 3 and 4(in y) every 0.5 floor]
node 20 $BX3 $BY232 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 21 $BX3 $BY232 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of between axes 3-4 (in x) and 3-4 (in y) every 0.5 floor]
node 30 $BX34 $BY232 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 31 $BX34 $BY232 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#mid-stair node which starts at level 0 to level 5
node 40 $BX34 $BY231 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 41 $BX34 $BY231 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 42 $BX34 $BY231 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#split the columns nodes
node 91341 $BX3 $BY231 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 91342 $BX3 $BY231 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 91440 $BX4 $BY231 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 91441 $BX4 $BY231 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 91442 $BX4 $BY231 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 15301 $BX4 $BY2 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 15312 $BX4 $BY2 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 14301 $BX3 $BY2 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14312 $BX3 $BY2 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

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
geomTransf PDelta 	7  0 1 0 -jntOffset [expr $hb2/2] 0.0 0.0  [expr -$hb2/2]  0.0 0.0 ; # z is in Y
geomTransf PDelta 	8  -1 0 0 -jntOffset 0.0 [expr $hb2/2] 0.0  0.0 [expr -$hb2/2]  0.0 ; # z is in Y


geomTransf Linear   9  0 1 1;
geomTransf Linear   10  0 -1 1;


set GTc1 1;
set GTc2 2;
set GTc3 3;

set GTbX1	5;
set GTbY1 6;
set GTbX2	7;
set GTbY2 8;

set GTs1 9;
set GTs2 10;

# --------------------------------------
# Define Elements
# --------------------------------------
# Open a set of files so that the properties of the beams, columns and joint elements creted using the provided procedures can be examined later.
set pfile_jnts [open $outsdir/Properties_joints.txt w];
set pfile_bm1s  [open $outsdir/Properties_beams.txt w];
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
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	711 	[list $BX6 0.0 [expr 1*$H]] $mass71  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass71+$mass71r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	811 	[list $BX7 0.0 [expr 1*$H]] $mass81  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass81+$mass81r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	712 	[list $BX6 0.0 [expr 2*$H]] $mass71  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass71+$mass71r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	812 	[list $BX7 0.0 [expr 2*$H]] $mass81  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass81+$mass81r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	513 	[list $BX4 0.0 [expr 3*$H]] $mass51r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	613 	[list $BX5 0.0 [expr 3*$H]] $mass61r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	713 	[list $BX6 0.0 [expr 3*$H]] $mass71r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass71+$mass71r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	813 	[list $BX7 0.0 [expr 3*$H]] $mass81r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass81+$mass81r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	721 	[list $BX6 $BY1 [expr 1*$H]] $mass72  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass72+$mass72r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	821 	[list $BX7 $BY1 [expr 1*$H]] $mass82  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass82+$mass82r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	722 	[list $BX6 $BY1 [expr 2*$H]] $mass72  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass72+$mass72r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	822 	[list $BX7 $BY1 [expr 2*$H]] $mass82  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass82+$mass82r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	523 	[list $BX4 $BY1 [expr 3*$H]] $mass52r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	623 	[list $BX5 $BY1 [expr 3*$H]] $mass62r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	723 	[list $BX6 $BY1 [expr 3*$H]] $mass72r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass72+$mass72r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	823 	[list $BX7 $BY1 [expr 3*$H]] $mass82r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass82+$mass82r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	731 	[list $BX6 $BY2 [expr 1*$H]] $mass73  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass73+$mass73r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	831 	[list $BX7 $BY2 [expr 1*$H]] $mass83  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass83+$mass83r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	732 	[list $BX6 $BY2 [expr 2*$H]] $mass73  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass73+$mass73r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	832 	[list $BX7 $BY2 [expr 2*$H]] $mass83  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass83+$mass83r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	533 	[list $BX4 $BY2 [expr 3*$H]] $mass53r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	633 	[list $BX5 $BY2 [expr 3*$H]] $mass63r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	733 	[list $BX6 $BY2 [expr 3*$H]] $mass73r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass73+$mass73r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	833 	[list $BX7 $BY2 [expr 3*$H]] $mass83r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass83+$mass83r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct   $STb 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5611 $GTbX1  6611 6711 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5711 $GTbX1  6711 6811 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# Y=2;
rcBC_nonDuct   $STb 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5621 $GTbX1  6621 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5721 $GTbX1  6721 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s

# Y=3;
rcBC_nonDuct   $STb 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5431 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5531 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5631 $GTbX1  6631 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5731 $GTbX1  6731 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

#2nd Floor

# Y=1;
rcBC_nonDuct   $STb 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5612 $GTbX1  6612 6712 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5712 $GTbX1  6712 6812 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# Y=2;
rcBC_nonDuct   $STb 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5622 $GTbX1  6622 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5722 $GTbX1  6722 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s

# Y=3;
rcBC_nonDuct   $STb 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5432 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5532 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5632 $GTbX1  6632 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5732 $GTbX1  6732 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

#3rd Floor

# Y=1;
rcBC_nonDuct   $STb 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5413 $GTbX1  6413 6513 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5513 $GTbX1  6513 6613 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5613 $GTbX1  6613 6713 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5713 $GTbX1  6713 6813 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# Y=2;
rcBC_nonDuct   $STb 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5423 $GTbX1  6423 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5523 $GTbX1  6523 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5623 $GTbX1  6623 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5723 $GTbX1  6723 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s

# Y=3;
rcBC_nonDuct   $STb 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5433 $GTbX1  6433 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5533 $GTbX1  6533 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5633 $GTbX1  6633 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5733 $GTbX1  6733 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;

rcBC_nonDuct   $STb 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# X=2;
rcBC_nonDuct   $STb 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=3;
rcBC_nonDuct   $STb 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=4;
rcBC_nonDuct   $STb 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=5;
rcBC_nonDuct   $STb 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=6;
rcBC_nonDuct   $STb 	6611 $GTbY2  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6621 $GTbY2  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=7;
rcBC_nonDuct   $STb 	6711 $GTbY2  6711 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6721 $GTbY2  6721 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=8;
rcBC_nonDuct   $STb 	6811 $GTbY1  6811 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6821 $GTbY1  6821 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# 2nd Floor

# X=1;
rcBC_nonDuct   $STb 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# X=2;
rcBC_nonDuct   $STb 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=3;
rcBC_nonDuct   $STb 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=4;
rcBC_nonDuct   $STb 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=5;
rcBC_nonDuct   $STb 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=6;
rcBC_nonDuct   $STb 	6612 $GTbY2  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6622 $GTbY2  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=7;
rcBC_nonDuct   $STb 	6712 $GTbY2  6712 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6722 $GTbY2  6722 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=8;
rcBC_nonDuct   $STb 	6812 $GTbY1  6812 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6822 $GTbY1  6822 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# 3rd Floor

# X=1;
rcBC_nonDuct   $STb 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# X=2;
rcBC_nonDuct   $STb 	6213 $GTbY2  6213 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6223 $GTbY2  6223 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=3;
rcBC_nonDuct   $STb 	6313 $GTbY2  6313 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6323 $GTbY2  6323 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=4;
rcBC_nonDuct   $STb 	6413 $GTbY2  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6423 $GTbY2  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=5;
rcBC_nonDuct   $STb 	6513 $GTbY2  6513 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6523 $GTbY2  6523 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=6;
rcBC_nonDuct   $STb 	6613 $GTbY2  6613 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6623 $GTbY2  6623 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=7;
rcBC_nonDuct   $STb 	6713 $GTbY2  6713 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6723 $GTbY2  6723 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=8;
rcBC_nonDuct   $STb 	6813 $GTbY1  6813 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6823 $GTbY1  6823 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct  $STc 	7111 $GTc2 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7211 $GTc2 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7311 $GTc2 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7411 $GTc2 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7511 $GTc2 1510 	1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7611 $GTc2 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7711 $GTc2 1710 	1711 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7811 $GTc2 1810 	1811 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7121 $GTc2 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7221 $GTc2 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7321 $GTc2 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7421 $GTc2 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7521 $GTc2 1520 	1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7621 $GTc2 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7721 $GTc2 1720 	1721 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7821 $GTc2 1820 	1821 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass81+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7131 $GTc2 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7231 $GTc2 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7331 $GTc2 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7431 $GTc2 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7531 $GTc2 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7631 $GTc2 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7731 $GTc2 1730 	1731 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7831 $GTc2 1830 	1831 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_nonDuct  $STc 	7112 $GTc3 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7212 $GTc3 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7312 $GTc3 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7412 $GTc3 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7512 $GTc3 1511 	1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7612 $GTc3 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7712 $GTc3 1711 	1712 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass71+$mass71r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7812 $GTc3 1811 	1812 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass81+$mass81r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7122 $GTc3 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7222 $GTc3 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7322 $GTc3 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7422 $GTc3 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7522 $GTc3 1521 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass52+$mass52r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7622 $GTc3 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass62+$mass62r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7722 $GTc3 1721 	1722 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass72+$mass72r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7822 $GTc3 1821 	1822 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass82+$mass82r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7132 $GTc3 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7232 $GTc3 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7332 $GTc3 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7432 $GTc3 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7532 $GTc3 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass53+$mass53r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7632 $GTc3 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass63+$mass63r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7732 $GTc3 1731 	1732 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass73+$mass73r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7832 $GTc3 1831 	1832 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass83+$mass83r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

#3rd Floor

# Y=1;
rcBC_nonDuct  $STc 	7113 $GTc3 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7213 $GTc3 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7313 $GTc3 1312 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7413 $GTc3 1412 	1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7513 $GTc3 1512 	1513 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7613 $GTc3 1612 	1613 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7713 $GTc3 1712 	1713 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass71+$mass71r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7813 $GTc3 1812 	1813 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass81+$mass81r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7123 $GTc3 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7223 $GTc3 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7323 $GTc3 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7423 $GTc3 1422 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7523 $GTc3 1522 	1523 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass52+$mass52r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7623 $GTc3 1622 	1623 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass62+$mass62r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7723 $GTc3 1722 	1723 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass72+$mass72r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7823 $GTc3 1822 	1823 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass82+$mass82r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7133 $GTc3 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7233 $GTc3 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7333 $GTc3 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7433 $GTc3 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7533 $GTc3 1532 	1533 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass53+$mass53r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7633 $GTc3 1632 	1633 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass63+$mass63r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7733 $GTc3 1732 	1733 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass73+$mass73r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7833 $GTc3 1832 	1833 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass83+$mass83r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

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
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	711 	[list $BX6 0.0 [expr 1*$H]] $mass71  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass71+$mass71r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	811 	[list $BX7 0.0 [expr 1*$H]] $mass81  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass81+$mass81r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	712 	[list $BX6 0.0 [expr 2*$H]] $mass71  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass71+$mass71r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	812 	[list $BX7 0.0 [expr 2*$H]] $mass81  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass81+$mass81r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	513 	[list $BX4 0.0 [expr 3*$H]] $mass51r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	613 	[list $BX5 0.0 [expr 3*$H]] $mass61r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	713 	[list $BX6 0.0 [expr 3*$H]] $mass71r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass71+$mass71r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	813 	[list $BX7 0.0 [expr 3*$H]] $mass81r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass81+$mass81r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	721 	[list $BX6 $BY1 [expr 1*$H]] $mass72  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass72+$mass72r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	821 	[list $BX7 $BY1 [expr 1*$H]] $mass82  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass82+$mass82r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	722 	[list $BX6 $BY1 [expr 2*$H]] $mass72  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass72+$mass72r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	822 	[list $BX7 $BY1 [expr 2*$H]] $mass82  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass82+$mass82r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	523 	[list $BX4 $BY1 [expr 3*$H]] $mass52r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	623 	[list $BX5 $BY1 [expr 3*$H]] $mass62r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	723 	[list $BX6 $BY1 [expr 3*$H]] $mass72r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass72+$mass72r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	823 	[list $BX7 $BY1 [expr 3*$H]] $mass82r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass82+$mass82r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	731 	[list $BX6 $BY2 [expr 1*$H]] $mass73  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass73+$mass73r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	831 	[list $BX7 $BY2 [expr 1*$H]] $mass83  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass83+$mass83r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	732 	[list $BX6 $BY2 [expr 2*$H]] $mass73  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass73+$mass73r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	832 	[list $BX7 $BY2 [expr 2*$H]] $mass83  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass83+$mass83r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	533 	[list $BX4 $BY2 [expr 3*$H]] $mass53r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	633 	[list $BX5 $BY2 [expr 3*$H]] $mass63r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	733 	[list $BX6 $BY2 [expr 3*$H]] $mass73r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass73+$mass73r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	833 	[list $BX7 $BY2 [expr 3*$H]] $mass83r  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass83+$mass83r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct   $STb 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5611 $GTbX1  6611 6711 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5711 $GTbX1  6711 6811 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# Y=2;
rcBC_nonDuct   $STb 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5621 $GTbX1  6621 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5721 $GTbX1  6721 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s

# Y=3;
rcBC_nonDuct   $STb 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5431 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5531 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5631 $GTbX1  6631 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5731 $GTbX1  6731 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

#2nd Floor

# Y=1;
rcBC_nonDuct   $STb 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5612 $GTbX1  6612 6712 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5712 $GTbX1  6712 6812 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# Y=2;
rcBC_nonDuct   $STb 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5622 $GTbX1  6622 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5722 $GTbX1  6722 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s

# Y=3;
rcBC_nonDuct   $STb 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5432 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5532 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5632 $GTbX1  6632 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5732 $GTbX1  6732 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

#3rd Floor

# Y=1;
rcBC_nonDuct   $STb 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5413 $GTbX1  6413 6513 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5513 $GTbX1  6513 6613 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5613 $GTbX1  6613 6713 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5713 $GTbX1  6713 6813 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# Y=2;
rcBC_nonDuct   $STb 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5423 $GTbX1  6423 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5523 $GTbX1  6523 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5623 $GTbX1  6623 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5723 $GTbX1  6723 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bm1s

# Y=3;
rcBC_nonDuct   $STb 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5433 $GTbX1  6433 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5533 $GTbX1  6533 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5633 $GTbX1  6633 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	5733 $GTbX1  6733 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;

rcBC_nonDuct   $STb 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# X=2;
rcBC_nonDuct   $STb 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=3;
rcBC_nonDuct   $STb 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=4;
rcBC_nonDuct   $STb 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=5;
rcBC_nonDuct   $STb 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=6;
rcBC_nonDuct   $STb 	6611 $GTbY2  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6621 $GTbY2  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=7;
rcBC_nonDuct   $STb 	6711 $GTbY2  6711 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6721 $GTbY2  6721 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=8;
rcBC_nonDuct   $STb 	6811 $GTbY1  6811 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6821 $GTbY1  6821 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# 2nd Floor

# X=1;
rcBC_nonDuct   $STb 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# X=2;
rcBC_nonDuct   $STb 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=3;
rcBC_nonDuct   $STb 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=4;
rcBC_nonDuct   $STb 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=5;
rcBC_nonDuct   $STb 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=6;
rcBC_nonDuct   $STb 	6612 $GTbY2  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6622 $GTbY2  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=7;
rcBC_nonDuct   $STb 	6712 $GTbY2  6712 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6722 $GTbY2  6722 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=8;
rcBC_nonDuct   $STb 	6812 $GTbY1  6812 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6822 $GTbY1  6822 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# 3rd Floor

# X=1;
rcBC_nonDuct   $STb 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

# X=2;
rcBC_nonDuct   $STb 	6213 $GTbY2  6213 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6223 $GTbY2  6223 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=3;
rcBC_nonDuct   $STb 	6313 $GTbY2  6313 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6323 $GTbY2  6323 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=4;
rcBC_nonDuct   $STb 	6413 $GTbY2  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6423 $GTbY2  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=5;
rcBC_nonDuct   $STb 	6513 $GTbY2  6513 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6523 $GTbY2  6523 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=6;
rcBC_nonDuct   $STb 	6613 $GTbY2  6613 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6623 $GTbY2  6623 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=7;
rcBC_nonDuct   $STb 	6713 $GTbY2  6713 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6723 $GTbY2  6723 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.250  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bm1s

# X=8;
rcBC_nonDuct   $STb 	6813 $GTbY1  6813 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
rcBC_nonDuct   $STb 	6823 $GTbY1  6823 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.250  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct  $STc 	7111 $GTc2 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7211 $GTc2 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7311 $GTc2 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7411 $GTc2 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7511 $GTc2 1510 	1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7611 $GTc2 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7711 $GTc2 1710 	1711 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7811 $GTc2 1810 	1811 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7121 $GTc2 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7221 $GTc2 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7321 $GTc2 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7421 $GTc2 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7521 $GTc2 1520 	1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7621 $GTc2 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7721 $GTc2 1720 	1721 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7821 $GTc2 1820 	1821 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass81+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7131 $GTc2 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7231 $GTc2 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7331 $GTc2 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7431 $GTc2 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7531 $GTc2 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7631 $GTc2 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7731 $GTc2 1730 	1731 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7831 $GTc2 1830 	1831 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_nonDuct  $STc 	7112 $GTc3 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7212 $GTc3 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7312 $GTc3 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7412 $GTc3 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7512 $GTc3 1511 	1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7612 $GTc3 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7712 $GTc3 1711 	1712 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass71+$mass71r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7812 $GTc3 1811 	1812 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass81+$mass81r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7122 $GTc3 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7222 $GTc3 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7322 $GTc3 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7422 $GTc3 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7522 $GTc3 1521 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass52+$mass52r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7622 $GTc3 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass62+$mass62r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7722 $GTc3 1721 	1722 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass72+$mass72r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7822 $GTc3 1821 	1822 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass82+$mass82r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7132 $GTc3 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7232 $GTc3 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7332 $GTc3 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7432 $GTc3 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7532 $GTc3 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass53+$mass53r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7632 $GTc3 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass63+$mass63r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7732 $GTc3 1731 	1732 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass73+$mass73r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7832 $GTc3 1831 	1832 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass83+$mass83r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

#3rd Floor

# Y=1;
rcBC_nonDuct  $STc 	7113 $GTc3 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7213 $GTc3 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7313 $GTc3 1312 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7413 $GTc3 1412 	1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7513 $GTc3 1512 	1513 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7613 $GTc3 1612 	1613 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7713 $GTc3 1712 	1713 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass71+$mass71r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7813 $GTc3 1812 	1813 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass81+$mass81r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7123 $GTc3 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7223 $GTc3 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7323 $GTc3 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7423 $GTc3 1422 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7523 $GTc3 1522 	1523 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass52+$mass52r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7623 $GTc3 1622 	1623 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass62+$mass62r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7723 $GTc3 1722 	1723 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass72+$mass72r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7823 $GTc3 1822 	1823 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass82+$mass82r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7133 $GTc3 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass13+$mass13r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7233 $GTc3 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass23+$mass23r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7333 $GTc3 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass33+$mass33r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7433 $GTc3 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass43+$mass43r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7533 $GTc3 1532 	1533 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass53+$mass53r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7633 $GTc3 1632 	1633 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass63+$mass63r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7733 $GTc3 1732 	1733 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass73+$mass73r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7833 $GTc3 1832 	1833 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass83+$mass83r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

puts "Columns created..."
}

if {$infillsOPT == 1} {
# -------------------
# Infills
# -------------------
# X-Direction
# -------------------
if {$pilotisOPT==0} {

# 1st Floor

# Y=1;
infill 		2111 	single 	[list 1111 1211 1210 1110] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2211 	single 	[list 1211 1311 1310 1210] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2311 	single 	[list 1311 1411 1410 1310] 	 3000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2411 	single 	[list 1411 1511 1510 1410] 	 2600. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2511 	single 	[list 1511 1611 1610 1510] 	 3000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2611 	single 	[list 1611 1711 1710 1610] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2711 	single 	[list 1711 1811 1810 1710] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=3;
infill 		2131 	single 	[list 1131 1231 1230 1130] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2231 	single 	[list 1231 1331 1330 1230] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2331 	single 	[list 1331 1431 1430 1330] 	 3000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2431 	single 	[list 1431 1531 1530 1430] 	 2600. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2531 	single 	[list 1531 1631 1630 1530] 	 3000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2631 	single 	[list 1631 1731 1730 1630] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2731 	single 	[list 1731 1831 1830 1730] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

}

# 2nd Floor

# Y=1;
infill 		2112 	single 	[list 1112 1212 1211 1111] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2212 	single 	[list 1212 1312 1311 1211] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2312 	single 	[list 1312 1412 1411 1311] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2412 	single 	[list 1412 1512 1511 1411] 	 2600. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2512 	single 	[list 1512 1612 1611 1511] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2612 	single 	[list 1612 1712 1711 1611] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2712 	single 	[list 1712 1812 1811 1711] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=3;
infill 		2132 	single 	[list 1132 1232 1231 1131] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2232 	single 	[list 1232 1332 1331 1231] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2332 	single 	[list 1332 1432 1431 1331] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2432 	single 	[list 1432 1532 1531 1431] 	 2600. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2532 	single 	[list 1532 1632 1631 1531] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2632 	single 	[list 1632 1732 1731 1631] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2732 	single 	[list 1732 1832 1831 1731] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 3rd Floor

# Y=1;
infill 		2113 	single 	[list 1113 1213 1212 1112] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2213 	single 	[list 1213 1313 1312 1212] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2313 	single 	[list 1313 1413 1412 1312] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2413 	single 	[list 1413 1513 1512 1412] 	 2600. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2513 	single 	[list 1513 1613 1612 1512] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2613 	single 	[list 1613 1713 1712 1612] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2713 	single 	[list 1713 1813 1812 1712] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=3;
infill 		2133 	single 	[list 1133 1233 1232 1132] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2233 	single 	[list 1233 1333 1332 1232] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2333 	single 	[list 1333 1433 1432 1332] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2433 	single 	[list 1433 1533 1532 1432] 	 2600. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2533 	single 	[list 1533 1633 1632 1532] 	 3000. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2633 	single 	[list 1633 1733 1732 1632] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2733 	single 	[list 1733 1833 1832 1732] 	 3500. [expr $H*1000] 	   $hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# -------------------
# Y-Direction
# -------------------
if {$pilotisOPT==0} {

# 1st Floor

# X=1;
infill 		3111 	single 	[list 1111 1121 1120 1110] 	4700. [expr $H*1000] 	$hb1  	$hc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3211 	single 	[list 1121 1131 1130 1120] 	4500. [expr $H*1000] 	$hb1  	$hc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=4;
infill 		3141 	single 	[list 1411 1421 1420 1410] 	4700. [expr $H*1000] 	$hb2  	$hc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3241 	single 	[list 1421 1431 1430 1420] 	4500. [expr $H*1000] 	$hb2  	$hc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=5;
infill 		3151 	single 	[list 1511 1521 1520 1510] 	4700. [expr $H*1000] 	$hb2  	$hc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3251 	single 	[list 1521 1531 1530 1520] 	4500. [expr $H*1000] 	$hb2  	$hc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=8;
infill 		3181 	single 	[list 1811 1821 1820 1810] 	4700. [expr $H*1000] 	$hb1  	$hc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3281 	single 	[list 1821 1831 1830 1820] 	4500. [expr $H*1000] 	$hb1  	$hc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

}

# 2nd Floor

# X=1;
infill 		3112 	single 	[list 1112 1122 1121 1111] 	4700. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3212 	single 	[list 1122 1132 1131 1121] 	4500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=4;
infill 		3142 	single 	[list 1412 1422 1421 1411] 	4700. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3242 	single 	[list 1422 1432 1431 1421] 	4500. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=5;
infill 		3152 	single 	[list 1512 1522 1521 1511] 	4700. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3252 	single 	[list 1522 1532 1531 1521] 	4500. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=8;
infill 		3182 	single 	[list 1812 1822 1821 1811] 	4700. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3282 	single 	[list 1822 1832 1831 1821] 	4500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 3rd Floor

# X=1;
infill 		3113 	single 	[list 1113 1123 1122 1112] 	4700. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3213 	single 	[list 1123 1133 1132 1122] 	4500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=4;
infill 		3143 	single 	[list 1413 1423 1422 1412] 	4700. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3243 	single 	[list 1423 1433 1432 1422] 	4500. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=5;
infill 		3153 	single 	[list 1513 1523 1522 1512] 	4700. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		3253 	single 	[list 1523 1533 1532 1522] 	4500. [expr $H*1000] 	$hb2  	$bc3	$hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=8;
infill 		3183 	single 	[list 1813 1823 1822 1812] 	4700. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3283 	single 	[list 1823 1833 1832 1822] 	4500. [expr $H*1000] 	$hb1  	$bc3	$hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

puts "Infills created..."
}

# --------------------------------------
# DEFINE STAIRS
# --------------------------------------
if {$stairsOPT == 1} {

  # Stairs from 0 to 1

  rcBC_nonDuct            $STb 	99911     $GTs1  91440 10 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99921     $GTs1  40    30 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99931     $GTbY1  10 15301 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99941     $GTbX1  15301 14301 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99951     $GTbY1  14301 20 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99961     $GTbX1  10 30 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99971     $GTbX1  30 20 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99981     $GTs2  30 41    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99991     $GTs2  20 91341 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	999101    $GTbX1  91341 41 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

  # Stairs from 1 to 2

  rcBC_nonDuct            $STb 	999111    $GTbX1  41 91441 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99912     $GTs1  91441 11 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	999922    $GTs1  41    31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99932     $GTbY1  11 15312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99942     $GTbX1  15312 14312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99952     $GTbY1  14312 21 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99962     $GTbX1  11 31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99972     $GTbX1  31 21 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99982     $GTs2  31 42    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	99992     $GTs2  21 91342 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	999102    $GTbX1  91342 42 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s
  rcBC_nonDuct            $STb 	999112    $GTbX1  42 91442 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bm1s

puts "Stairs created..."
}

# --------------------------------------
# BOUNDARY CONDITIONS
# --------------------------------------
# Base Supports
# fix 	node	dX dY dZ rX rY rZ
fix 	1110	1  1  1  1  1  1
fix 	1210	1  1  1  1  1  1
fix 	1310	1  1  1  1  1  1
fix 	1410	1  1  1  1  1  1
fix 	1510	1  1  1  1  1  1
fix 	1610	1  1  1  1  1  1
fix 	1710	1  1  1  1  1  1
fix 	1810	1  1  1  1  1  1

fix 	1120	1  1  1  1  1  1
fix 	1220	1  1  1  1  1  1
fix 	1320	1  1  1  1  1  1
fix 	1420	1  1  1  1  1  1
fix 	1520	1  1  1  1  1  1
fix 	1620	1  1  1  1  1  1
fix 	1720	1  1  1  1  1  1
fix 	1820	1  1  1  1  1  1

fix 	1130	1  1  1  1  1  1
fix 	1230	1  1  1  1  1  1
fix 	1330	1  1  1  1  1  1
fix 	1430	1  1  1  1  1  1
fix 	1530	1  1  1  1  1  1
fix 	1630	1  1  1  1  1  1
fix 	1730	1  1  1  1  1  1
fix 	1830	1  1  1  1  1  1

if {$stairsOPT == 1} {
fix 91440   1  1  1  1  1  1
fix    40   1  1  1  1  1  1
}

# Rigid Diaphragm

rigidDiaphragm 3	1421 1321 1111 1211 1311 1411 1511 1611 1711 1811  1121 1221 1521 1621 1721 1821 1131 1231 1331 1431 1531 1631 1731 1831
rigidDiaphragm 3	1422 1322 1112 1212 1312 1412 1512 1612 1712 1812  1122 1222 1522 1622 1722 1822 1132 1232 1332 1432 1532 1632 1732 1832
rigidDiaphragm 3	1423 1323 1113 1213 1313 1413 1513 1613 1713 1813  1123 1223 1523 1623 1723 1823 1133 1233 1333 1433 1533 1633 1733 1833

# --------------------------------------
# GRAVITY LOAD PATTERN + ANALYSIS
# --------------------------------------
# Assign the loads
pattern Plain 101 Constant {
	load 1111 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # First Floor
	load 1211 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0; # First Floor
	load 1311 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0; # First Floor
	load 1411 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0; # First Floor
  load 1511 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0; # First Floor
  load 1611 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0; # First Floor
  load 1711 	0.0	0.0	[expr -$mass71*$g] 	0.0	0.0	0.0; # First Floor
  load 1811 	0.0	0.0	[expr -$mass81*$g] 	0.0	0.0	0.0; # First Floor

	load 1121 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0; # First Floor
	load 1221 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0; # First Floor
	load 1321 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0; # First Floor
	load 1421 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0; # First Floor
  load 1521 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0; # First Floor
  load 1621 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0; # First Floor
  load 1721 	0.0	0.0	[expr -$mass72*$g] 	0.0	0.0	0.0; # First Floor
  load 1821 	0.0	0.0	[expr -$mass82*$g] 	0.0	0.0	0.0; # First Floor

	load 1131 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0; # First Floor
	load 1231 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0; # First Floor
	load 1331 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0; # First Floor
	load 1431 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0; # First Floor
  load 1531 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0; # First Floor
  load 1631 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0; # First Floor
  load 1731 	0.0	0.0	[expr -$mass73*$g] 	0.0	0.0	0.0; # First Floor
  load 1831 	0.0	0.0	[expr -$mass83*$g] 	0.0	0.0	0.0; # First Floor

  load 1112 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Second Floor
  load 1212 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1312 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1412 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;
  load 1512 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0;
  load 1612 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0;
  load 1712 	0.0	0.0	[expr -$mass71*$g] 	0.0	0.0	0.0;
  load 1812 	0.0	0.0	[expr -$mass81*$g] 	0.0	0.0	0.0;

  load 1122 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1222 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1322 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
  load 1422 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;
  load 1522 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0;
  load 1622 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0;
  load 1722 	0.0	0.0	[expr -$mass72*$g] 	0.0	0.0	0.0;
  load 1822 	0.0	0.0	[expr -$mass82*$g] 	0.0	0.0	0.0;

  load 1132 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1232 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1332 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
  load 1432 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;
  load 1532 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0;
  load 1632 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0;
  load 1732 	0.0	0.0	[expr -$mass73*$g] 	0.0	0.0	0.0;
  load 1832 	0.0	0.0	[expr -$mass83*$g] 	0.0	0.0	0.0;

  load 1113 	0.0	0.0	[expr -$mass11r*$g] 	0.0	0.0	0.0; # Third Floor
  load 1213 	0.0	0.0	[expr -$mass21r*$g] 	0.0	0.0	0.0;
  load 1313 	0.0	0.0	[expr -$mass31r*$g] 	0.0	0.0	0.0;
  load 1413 	0.0	0.0	[expr -$mass41r*$g] 	0.0	0.0	0.0;
  load 1513 	0.0	0.0	[expr -$mass51r*$g] 	0.0	0.0	0.0;
  load 1613 	0.0	0.0	[expr -$mass61r*$g] 	0.0	0.0	0.0;
  load 1713 	0.0	0.0	[expr -$mass71r*$g] 	0.0	0.0	0.0;
  load 1813 	0.0	0.0	[expr -$mass81r*$g] 	0.0	0.0	0.0;

  load 1123 	0.0	0.0	[expr -$mass12r*$g] 	0.0	0.0	0.0;
  load 1223 	0.0	0.0	[expr -$mass22r*$g] 	0.0	0.0	0.0;
  load 1323 	0.0	0.0	[expr -$mass32r*$g] 	0.0	0.0	0.0;
  load 1423 	0.0	0.0	[expr -$mass42r*$g] 	0.0	0.0	0.0;
  load 1523 	0.0	0.0	[expr -$mass52r*$g] 	0.0	0.0	0.0;
  load 1623 	0.0	0.0	[expr -$mass62r*$g] 	0.0	0.0	0.0;
  load 1723 	0.0	0.0	[expr -$mass72r*$g] 	0.0	0.0	0.0;
  load 1823 	0.0	0.0	[expr -$mass82r*$g] 	0.0	0.0	0.0;

  load 1133 	0.0	0.0	[expr -$mass13r*$g] 	0.0	0.0	0.0;
  load 1233 	0.0	0.0	[expr -$mass23r*$g] 	0.0	0.0	0.0;
  load 1333 	0.0	0.0	[expr -$mass33r*$g] 	0.0	0.0	0.0;
  load 1433 	0.0	0.0	[expr -$mass43r*$g] 	0.0	0.0	0.0;
  load 1533 	0.0	0.0	[expr -$mass53r*$g] 	0.0	0.0	0.0;
  load 1633 	0.0	0.0	[expr -$mass63r*$g] 	0.0	0.0	0.0;
  load 1733 	0.0	0.0	[expr -$mass73r*$g] 	0.0	0.0	0.0;
  load 1833 	0.0	0.0	[expr -$mass83r*$g] 	0.0	0.0	0.0;
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
modalAnalysis $nst 1 _Archetype_4_${nst}st_${mtype} "$outsdir/info/modal/"

# --------------------------------------
# PRINT STUFF
# --------------------------------------
file delete $outsdir/info/models/Archetype_4_model_${nst}st_${mtype}.txt
print $outsdir/info/models/Archetype_4_model_${nst}st_${mtype}.txt

# --------------------------------------
# DEFINE RECORDERS
# --------------------------------------
set node_recorder 		{1420 1421 1422 1423}; # List of nodes to record {1220 1221 1222};
#set beam_recorder		{5111 5211 5311 5411 5511 5611 5121 5221 5321 5421 5521 5621 5131 5231 5331 5431 5531 5631 5112 5212 5312 5412 5512 5612 5122 5222 5322 5422 5522 5622 5132 5232 5332 5432 5532 5632};
#set column_recorder 	{7111 7211 7311 7411 7511  7121 7221 7321 7421 7521 7621 7131 7231 7331 7431 7531 7651 7112 7212 7312 7412 7512 7612 7122 7222 7322 7422 7522 7622 7132 7232 7332 7432 7532 7632};
#set joint_recorder 		{9111 9211 9311 9411 9511  9121 9221 9321 9421 9521 9621 9131 9231 9331 9431 9531 9631 9112 9212 9312 9412 9512 9612 9122 9222 9322 9422 9522 9622 9132 9232 9332 9432 9532 9632}; # The centre joint hinges

set bNode {1420 1421 1422}; # iNodes for drift
set tNode {1421 1422 1423}; # jNodes for drift
set baseNode 1420; # Base Node (for roof drift recorder)
set roofNode 1423; # Top Node

# Print a list of the elements and nodes recorded
file delete $outsdir/info/recorders/Archetype_4_recordersList_${nst}st_${mtype}.m
set rec_list [open $outsdir/info/recorders/Archetype_4_recordersList_${nst}st_${mtype}.m w];
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

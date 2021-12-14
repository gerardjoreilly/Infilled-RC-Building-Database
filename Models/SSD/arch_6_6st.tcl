# --------------------------------------------------
# 3D Model of Archetype Plan #6
# --------------------------------------------------
# Copyright by Al Mouayed Bellah Nafeh
# IUSS Pavia, Italy
# April 2020
# Description: 6-storey infilled RC building
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
source $procdir/arch_6_inputParam_SSD.tcl

# --------------------------------------
# Define some basic model parameters
# --------------------------------------
# Dimensions and General Para.

set nst 6; #Number of Stories
set mtype "Infill"; #Typology
set STb 1; #Shear Hinge for Beam (0: No, 1: Yes)
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

# Y=2;
node	1120		0.0		  $BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1220		$BX1		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1320		$BX2		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1420		$BX3		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1520		$BX4		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1620		$BX5		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=3;
node	1130		0.0		  $BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1230		$BX1		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1330		$BX2		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1430		$BX3		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1530		$BX4		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1630		$BX5		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

if {$stairsOPT == 1} {
#Define the staircase Nodes

node 10 $BX2 $BY122 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 11 $BX2 $BY122 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 12 $BX2 $BY122 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 13 $BX2 $BY122 [expr 3*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14 $BX2 $BY122 [expr 4*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 20 $BX23 $BY122 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 21 $BX23 $BY122 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 22 $BX23 $BY122 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 23 $BX23 $BY122 [expr 3*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 24 $BX23 $BY122 [expr 4*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 25 $BX23 $BY122 [expr 5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 31 $BX3 $BY122 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 32 $BX3 $BY122 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 33 $BX3 $BY122 [expr 3*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 34 $BX3 $BY122 [expr 4*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 35 $BX3 $BY122 [expr 5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 40 $BX2 $BY121 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 41 $BX2 $BY121 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 42 $BX2 $BY121 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 43 $BX2 $BY121 [expr 3.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 44 $BX2 $BY121 [expr 4.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 50 $BX23 $BY121 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 51 $BX23 $BY121 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 52 $BX23 $BY121 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 53 $BX23 $BY121 [expr 3.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 54 $BX23 $BY121 [expr 4.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 60 $BX3 $BY121 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 61 $BX3 $BY121 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 62 $BX3 $BY121 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 63 $BX3 $BY121 [expr 3.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 64 $BX3 $BY121 [expr 4.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 13101 $BX2 0.0 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 13112 $BX2 0.0 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 13123 $BX2 0.0 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 13134 $BX2 0.0 [expr 3.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 13145 $BX2 0.0 [expr 4.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 14101 $BX3 0.0 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14112 $BX3 0.0 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14123 $BX3 0.0 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14134 $BX3 0.0 [expr 3.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14145 $BX3 0.0 [expr 4.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

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


set GTc1 1;
set GTc2 2;
set GTc3 3;

set GTbX1	5;
set GTbY1 6;

set GTbX2	7;
set GTbY2 8;
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
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	513 	[list $BX4 0.0 [expr 3*$H]] $mass51  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	613 	[list $BX5 0.0 [expr 3*$H]] $mass61  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 4th Floor
jointModel 	 "Exterior"	114 	[list 0.00 0.0 [expr 4*$H]] $mass11  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	214 	[list $BX1 0.0 [expr 4*$H]] $mass21  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	314 	[list $BX2 0.0 [expr 4*$H]] $mass31  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	414 	[list $BX3 0.0 [expr 4*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	514 	[list $BX4 0.0 [expr 4*$H]] $mass51  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	614 	[list $BX5 0.0 [expr 4*$H]] $mass61  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 5th Floor
jointModel 	 "Exterior"	115 	[list 0.00 0.0 [expr 5*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	215 	[list $BX1 0.0 [expr 5*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	315 	[list $BX2 0.0 [expr 5*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	415 	[list $BX3 0.0 [expr 5*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	515 	[list $BX4 0.0 [expr 5*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	615 	[list $BX5 0.0 [expr 5*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 6th Floor
jointModel 	 "Exterior"	116 	[list 0.00 0.0 [expr 6*$H]] $mass11r $col3 $bm1 $c_c1 $brs3 [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	216 	[list $BX1 0.0 [expr 6*$H]] $mass21r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	316 	[list $BX2 0.0 [expr 6*$H]] $mass31r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	416 	[list $BX3 0.0 [expr 6*$H]] $mass41r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	516 	[list $BX4 0.0 [expr 6*$H]] $mass51r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	616 	[list $BX5 0.0 [expr 6*$H]] $mass61r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	523 	[list $BX4 $BY1 [expr 3*$H]] $mass52 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	623 	[list $BX5 $BY1 [expr 3*$H]] $mass62 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 4th Floor
jointModel 	 "Exterior"	124 	[list 0.00 $BY1 [expr 4*$H]] $mass12 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	224 	[list $BX1 $BY1 [expr 4*$H]] $mass22 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	324 	[list $BX2 $BY1 [expr 4*$H]] $mass32 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	424 	[list $BX3 $BY1 [expr 4*$H]] $mass42 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	524 	[list $BX4 $BY1 [expr 4*$H]] $mass52 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	624 	[list $BX5 $BY1 [expr 4*$H]] $mass62 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 5th Floor
jointModel 	 "Exterior"	125 	[list 0.00 $BY1 [expr 5*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	225 	[list $BX1 $BY1 [expr 5*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	325 	[list $BX2 $BY1 [expr 5*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	425 	[list $BX3 $BY1 [expr 5*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	525 	[list $BX4 $BY1 [expr 5*$H]] $mass52 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	625 	[list $BX5 $BY1 [expr 5*$H]] $mass62 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 6th Floor
jointModel 	 "Exterior"	126 	[list 0.00 $BY1 [expr 6*$H]] $mass12r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	226 	[list $BX1 $BY1 [expr 6*$H]] $mass22r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	326 	[list $BX2 $BY1 [expr 6*$H]] $mass32r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	426 	[list $BX3 $BY1 [expr 6*$H]] $mass42r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	526 	[list $BX4 $BY1 [expr 6*$H]] $mass52r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	626 	[list $BX5 $BY1 [expr 6*$H]] $mass62r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	533 	[list $BX4 $BY2 [expr 3*$H]] $mass53 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	633 	[list $BX5 $BY2 [expr 3*$H]] $mass63 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 4th Floor
jointModel 	 "Exterior"	134 	[list 0.00 $BY2 [expr 4*$H]] $mass13 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	234 	[list $BX1 $BY2 [expr 4*$H]] $mass23 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	334 	[list $BX2 $BY2 [expr 4*$H]] $mass33 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	434 	[list $BX3 $BY2 [expr 4*$H]] $mass43 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	534 	[list $BX4 $BY2 [expr 4*$H]] $mass53 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	634 	[list $BX5 $BY2 [expr 4*$H]] $mass63 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 5th Floor
jointModel 	 "Exterior"	135 	[list 0.00 $BY2 [expr 5*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	235 	[list $BX1 $BY2 [expr 5*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	335 	[list $BX2 $BY2 [expr 5*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	435 	[list $BX3 $BY2 [expr 5*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	535 	[list $BX4 $BY2 [expr 5*$H]] $mass53 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	635 	[list $BX5 $BY2 [expr 5*$H]] $mass63 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 6th Floor
jointModel 	 "Exterior"	136 	[list 0.00 $BY2 [expr 6*$H]] $mass13r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	236 	[list $BX1 $BY2 [expr 6*$H]] $mass23r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	336 	[list $BX2 $BY2 [expr 6*$H]] $mass33r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	436 	[list $BX3 $BY2 [expr 6*$H]] $mass43r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	536 	[list $BX4 $BY2 [expr 6*$H]] $mass53r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	636 	[list $BX5 $BY2 [expr 6*$H]] $mass63r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct   $STb 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5431 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5531 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_nonDuct   $STb 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5432 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5532 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# Y=1;
rcBC_nonDuct   $STb 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5413 $GTbX1  6413 6513 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5513 $GTbX1  6513 6613 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5423 $GTbX1  6423 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5523 $GTbX1  6523 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5433 $GTbX1  6433 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5533 $GTbX1  6533 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# Y=1;
rcBC_nonDuct   $STb 	5114 $GTbX1  6114 6214 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5214 $GTbX1  6214 6314 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5314 $GTbX1  6314 6414 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5414 $GTbX1  6414 6514 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5514 $GTbX1  6514 6614 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5124 $GTbX1  6124 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5224 $GTbX1  6224 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5324 $GTbX1  6324 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5424 $GTbX1  6424 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5524 $GTbX1  6524 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5134 $GTbX1  6134 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5234 $GTbX1  6234 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5334 $GTbX1  6334 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5434 $GTbX1  6434 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5534 $GTbX1  6534 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#5th Floor

# Y=1;
rcBC_nonDuct   $STb 	5115 $GTbX1  6115 6215 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5215 $GTbX1  6215 6315 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5315 $GTbX1  6315 6415 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5415 $GTbX1  6415 6515 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5515 $GTbX1  6515 6615 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5125 $GTbX1  6125 6225 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5225 $GTbX1  6225 6325 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5325 $GTbX1  6325 6425 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5425 $GTbX1  6425 6525 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5525 $GTbX1  6525 6625 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5135 $GTbX1  6135 6235 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5235 $GTbX1  6235 6335 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5335 $GTbX1  6335 6435 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5435 $GTbX1  6435 6535 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5535 $GTbX1  6535 6635 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#6th Floor

# Y=1;
rcBC_nonDuct   $STb 	5116 $GTbX1  6116 6216 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5216 $GTbX1  6216 6316 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5316 $GTbX1  6316 6416 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5416 $GTbX1  6416 6516 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5516 $GTbX1  6516 6616 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5126 $GTbX1  6126 6226 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5226 $GTbX1  6226 6326 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5326 $GTbX1  6326 6426 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5426 $GTbX1  6426 6526 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5526 $GTbX1  6526 6626 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5136 $GTbX1  6136 6236 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5236 $GTbX1  6236 6336 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5336 $GTbX1  6336 6436 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5436 $GTbX1  6436 6536 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5536 $GTbX1  6536 6636 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_nonDuct   $STb 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6611 $GTbY1  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6621 $GTbY1  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_nonDuct   $STb 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6612 $GTbY1  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6622 $GTbY1  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# X=1;
rcBC_nonDuct   $STb 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6213 $GTbY2  6213 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6223 $GTbY2  6223 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6313 $GTbY2  6313 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6323 $GTbY2  6323 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6413 $GTbY2  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6423 $GTbY2  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6513 $GTbY2  6513 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6523 $GTbY2  6523 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6613 $GTbY1  6613 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6623 $GTbY1  6623 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# X=1;
rcBC_nonDuct   $STb 	6114 $GTbY1  6114 6124 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6124 $GTbY1  6124 6134 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6214 $GTbY2  6214 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6224 $GTbY2  6224 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6314 $GTbY2  6314 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6324 $GTbY2  6324 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6414 $GTbY2  6414 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6424 $GTbY2  6424 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6514 $GTbY2  6514 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6524 $GTbY2  6524 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6614 $GTbY1  6614 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6624 $GTbY1  6624 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#5th Floor

# X=1;
rcBC_nonDuct   $STb 	6115 $GTbY1  6115 6125 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6125 $GTbY1  6125 6135 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6215 $GTbY2  6215 6225 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6225 $GTbY2  6225 6235 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6315 $GTbY2  6315 6325 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6325 $GTbY2  6325 6335 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6415 $GTbY2  6415 6425 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6425 $GTbY2  6425 6435 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6515 $GTbY2  6515 6525 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6525 $GTbY2  6525 6535 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6615 $GTbY1  6615 6625 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6625 $GTbY1  6625 6635 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#6th Floor

# X=1;
rcBC_nonDuct   $STb 	6116 $GTbY1  6116 6126 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6126 $GTbY1  6126 6136 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6216 $GTbY2  6216 6226 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6226 $GTbY2  6226 6236 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6316 $GTbY2  6316 6326 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6326 $GTbY2  6326 6336 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6416 $GTbY2  6416 6426 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6426 $GTbY2  6426 6436 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6516 $GTbY2  6516 6526 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6526 $GTbY2  6526 6536 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6616 $GTbY1  6616 6626 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6626 $GTbY1  6626 6636 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct  $STc 	7111 $GTc1 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7211 $GTc1 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7311 $GTc1 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7411 $GTc1 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7511 $GTc1 1510 	1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7611 $GTc1 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7121 $GTc1 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass12+$mass12r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7221 $GTc1 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass22+$mass22r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7321 $GTc1 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass32+$mass32r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7421 $GTc1 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass42+$mass42r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7521 $GTc1 1520 	1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass52+$mass52r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7621 $GTc1 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass62+$mass62r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7131 $GTc1 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7231 $GTc1 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7331 $GTc1 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7431 $GTc1 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7531 $GTc1 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7631 $GTc1 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_nonDuct  $STc 	7112 $GTc1 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7212 $GTc1 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7312 $GTc1 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7412 $GTc1 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7512 $GTc1 1511 	1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7612 $GTc1 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7122 $GTc1 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass12+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7222 $GTc1 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass22+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7322 $GTc1 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass32+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7422 $GTc1 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass42+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7522 $GTc1 1521 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass52+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7622 $GTc1 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass62+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7132 $GTc1 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7232 $GTc1 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7332 $GTc1 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7432 $GTc1 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7532 $GTc1 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7632 $GTc1 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

#3rd Floor

# Y=1;
rcBC_nonDuct  $STc 	7113 $GTc2 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7213 $GTc2 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7313 $GTc2 1312 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7413 $GTc2 1412 	1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7513 $GTc2 1512 	1513 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7613 $GTc2 1612 	1613 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7123 $GTc2 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass12+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7223 $GTc2 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass22+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7323 $GTc2 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass32+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7423 $GTc2 1422 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass42+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7523 $GTc2 1522 	1523 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass52+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7623 $GTc2 1622 	1623 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass62+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7133 $GTc2 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7233 $GTc2 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7333 $GTc2 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7433 $GTc2 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7533 $GTc2 1532 	1533 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7633 $GTc2 1632 	1633 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#4th Floor

# Y=1;
rcBC_nonDuct  $STc 	7114 $GTc2 1113 	1114 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7214 $GTc2 1213 	1214 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7314 $GTc2 1313 	1314 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7414 $GTc2 1413 	1414 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7514 $GTc2 1513 	1514 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7614 $GTc2 1613 	1614 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7124 $GTc2 1123 	1124 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass12+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7224 $GTc2 1223 	1224 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass22+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7324 $GTc2 1323 	1324 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass32+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7424 $GTc2 1423 	1424 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass42+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7524 $GTc2 1523 	1524 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass52+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7624 $GTc2 1623 	1624 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass62+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7134 $GTc2 1133 	1134 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7234 $GTc2 1233 	1234 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7334 $GTc2 1333 	1334 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7434 $GTc2 1433 	1434 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7534 $GTc2 1533 	1534 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7634 $GTc2 1633 	1634 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#5th Floor

# Y=1;
rcBC_nonDuct  $STc 	7115 $GTc3 1114 	1115 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7215 $GTc3 1214 	1215 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7315 $GTc3 1314 	1315 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7415 $GTc3 1414 	1415 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7515 $GTc3 1514 	1515 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7615 $GTc3 1614 	1615 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7125 $GTc3 1124 	1125 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass12+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7225 $GTc3 1224 	1225 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass22+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7325 $GTc3 1324 	1325 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass32+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7425 $GTc3 1424 	1425 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass42+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7525 $GTc3 1524 	1525 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass52+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7625 $GTc3 1624 	1625 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass62+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7135 $GTc3 1134 	1135 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7235 $GTc3 1234 	1235 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7335 $GTc3 1334 	1335 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7435 $GTc3 1434 	1435 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7535 $GTc3 1534 	1535 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7635 $GTc3 1634 	1635 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

#6th Floor

# Y=1;
rcBC_nonDuct  $STc 	7116 $GTc3 1115 	1116 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7216 $GTc3 1215 	1216 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7316 $GTc3 1315 	1316 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7416 $GTc3 1415 	1416 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7516 $GTc3 1515 	1516 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7616 $GTc3 1615 	1616 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7126 $GTc3 1125 	1126 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass12+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7226 $GTc3 1225 	1226 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass22+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7326 $GTc3 1325 	1326 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass32+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7426 $GTc3 1425 	1426 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass42+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7526 $GTc3 1525 	1526 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass52+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7626 $GTc3 1625 	1626 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass62+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7136 $GTc3 1135 	1136 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7236 $GTc3 1235 	1236 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7336 $GTc3 1335 	1336 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7436 $GTc3 1435 	1436 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7536 $GTc3 1535 	1536 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7636 $GTc3 1635 	1636 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

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
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col1 $bm1 $c_c1 $brs3  [expr (5*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col1 $bm1 $c_c1 $brs3  [expr (4*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	513 	[list $BX4 0.0 [expr 3*$H]] $mass51  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	613 	[list $BX5 0.0 [expr 3*$H]] $mass61  $col2 $bm1 $c_c1 $brs3  [expr (3*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 4th Floor
jointModel 	 "Exterior"	114 	[list 0.00 0.0 [expr 4*$H]] $mass11  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	214 	[list $BX1 0.0 [expr 4*$H]] $mass21  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	314 	[list $BX2 0.0 [expr 4*$H]] $mass31  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	414 	[list $BX3 0.0 [expr 4*$H]] $mass41  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	514 	[list $BX4 0.0 [expr 4*$H]] $mass51  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	614 	[list $BX5 0.0 [expr 4*$H]] $mass61  $col2 $bm1 $c_c1 $brs3  [expr (2*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 5th Floor
jointModel 	 "Exterior"	115 	[list 0.00 0.0 [expr 5*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	215 	[list $BX1 0.0 [expr 5*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	315 	[list $BX2 0.0 [expr 5*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	415 	[list $BX3 0.0 [expr 5*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	515 	[list $BX4 0.0 [expr 5*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	615 	[list $BX5 0.0 [expr 5*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 6th Floor
jointModel 	 "Exterior"	116 	[list 0.00 0.0 [expr 6*$H]] $mass11r $col3 $bm1 $c_c1 $brs3 [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	216 	[list $BX1 0.0 [expr 6*$H]] $mass21r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	316 	[list $BX2 0.0 [expr 6*$H]] $mass31r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	416 	[list $BX3 0.0 [expr 6*$H]] $mass41r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	516 	[list $BX4 0.0 [expr 6*$H]] $mass51r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	616 	[list $BX5 0.0 [expr 6*$H]] $mass61r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	523 	[list $BX4 $BY1 [expr 3*$H]] $mass52 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	623 	[list $BX5 $BY1 [expr 3*$H]] $mass62 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 4th Floor
jointModel 	 "Exterior"	124 	[list 0.00 $BY1 [expr 4*$H]] $mass12 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	224 	[list $BX1 $BY1 [expr 4*$H]] $mass22 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	324 	[list $BX2 $BY1 [expr 4*$H]] $mass32 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	424 	[list $BX3 $BY1 [expr 4*$H]] $mass42 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	524 	[list $BX4 $BY1 [expr 4*$H]] $mass52 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	624 	[list $BX5 $BY1 [expr 4*$H]] $mass62 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 5th Floor
jointModel 	 "Exterior"	125 	[list 0.00 $BY1 [expr 5*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	225 	[list $BX1 $BY1 [expr 5*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	325 	[list $BX2 $BY1 [expr 5*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	425 	[list $BX3 $BY1 [expr 5*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	525 	[list $BX4 $BY1 [expr 5*$H]] $mass52 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	625 	[list $BX5 $BY1 [expr 5*$H]] $mass62 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 6th Floor
jointModel 	 "Exterior"	126 	[list 0.00 $BY1 [expr 6*$H]] $mass12r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	226 	[list $BX1 $BY1 [expr 6*$H]] $mass22r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	326 	[list $BX2 $BY1 [expr 6*$H]] $mass32r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	426 	[list $BX3 $BY1 [expr 6*$H]] $mass42r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	526 	[list $BX4 $BY1 [expr 6*$H]] $mass52r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	626 	[list $BX5 $BY1 [expr 6*$H]] $mass62r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63 $col1 $bm1 $c_c1 $brs3  [expr (5*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63 $col1 $bm1 $c_c1 $brs3  [expr (4*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	533 	[list $BX4 $BY2 [expr 3*$H]] $mass53 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	633 	[list $BX5 $BY2 [expr 3*$H]] $mass63 $col2 $bm1 $c_c1 $brs3  [expr (3*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 4th Floor
jointModel 	 "Exterior"	134 	[list 0.00 $BY2 [expr 4*$H]] $mass13 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	234 	[list $BX1 $BY2 [expr 4*$H]] $mass23 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	334 	[list $BX2 $BY2 [expr 4*$H]] $mass33 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	434 	[list $BX3 $BY2 [expr 4*$H]] $mass43 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	534 	[list $BX4 $BY2 [expr 4*$H]] $mass53 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	634 	[list $BX5 $BY2 [expr 4*$H]] $mass63 $col2 $bm1 $c_c1 $brs3  [expr (2*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 5th Floor
jointModel 	 "Exterior"	135 	[list 0.00 $BY2 [expr 5*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	235 	[list $BX1 $BY2 [expr 5*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	335 	[list $BX2 $BY2 [expr 5*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	435 	[list $BX3 $BY2 [expr 5*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	535 	[list $BX4 $BY2 [expr 5*$H]] $mass53 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	635 	[list $BX5 $BY2 [expr 5*$H]] $mass63 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 6th Floor
jointModel 	 "Exterior"	136 	[list 0.00 $BY2 [expr 6*$H]] $mass13r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	236 	[list $BX1 $BY2 [expr 6*$H]] $mass23r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	336 	[list $BX2 $BY2 [expr 6*$H]] $mass33r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	436 	[list $BX3 $BY2 [expr 6*$H]] $mass43r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	536 	[list $BX4 $BY2 [expr 6*$H]] $mass53r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	636 	[list $BX5 $BY2 [expr 6*$H]] $mass63r $col3 $bm1 $c_c1 $brs3  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct   $STb 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5431 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5531 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_nonDuct   $STb 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5432 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5532 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# Y=1;
rcBC_nonDuct   $STb 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5413 $GTbX1  6413 6513 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5513 $GTbX1  6513 6613 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5423 $GTbX1  6423 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5523 $GTbX1  6523 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5433 $GTbX1  6433 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5533 $GTbX1  6533 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# Y=1;
rcBC_nonDuct   $STb 	5114 $GTbX1  6114 6214 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5214 $GTbX1  6214 6314 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5314 $GTbX1  6314 6414 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5414 $GTbX1  6414 6514 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5514 $GTbX1  6514 6614 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5124 $GTbX1  6124 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5224 $GTbX1  6224 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5324 $GTbX1  6324 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5424 $GTbX1  6424 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5524 $GTbX1  6524 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5134 $GTbX1  6134 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5234 $GTbX1  6234 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5334 $GTbX1  6334 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5434 $GTbX1  6434 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5534 $GTbX1  6534 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#5th Floor

# Y=1;
rcBC_nonDuct   $STb 	5115 $GTbX1  6115 6215 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5215 $GTbX1  6215 6315 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5315 $GTbX1  6315 6415 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5415 $GTbX1  6415 6515 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5515 $GTbX1  6515 6615 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5125 $GTbX1  6125 6225 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5225 $GTbX1  6225 6325 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5325 $GTbX1  6325 6425 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5425 $GTbX1  6425 6525 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5525 $GTbX1  6525 6625 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5135 $GTbX1  6135 6235 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5235 $GTbX1  6235 6335 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5335 $GTbX1  6335 6435 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5435 $GTbX1  6435 6535 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5535 $GTbX1  6535 6635 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#6th Floor

# Y=1;
rcBC_nonDuct   $STb 	5116 $GTbX1  6116 6216 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5216 $GTbX1  6216 6316 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5316 $GTbX1  6316 6416 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5416 $GTbX1  6416 6516 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5516 $GTbX1  6516 6616 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_nonDuct   $STb 	5126 $GTbX1  6126 6226 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5226 $GTbX1  6226 6326 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5326 $GTbX1  6326 6426 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5426 $GTbX1  6426 6526 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_nonDuct   $STb 	5526 $GTbX1  6526 6626 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_nonDuct   $STb 	5136 $GTbX1  6136 6236 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5236 $GTbX1  6236 6336 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5336 $GTbX1  6336 6436 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5436 $GTbX1  6436 6536 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	5536 $GTbX1  6536 6636 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_nonDuct   $STb 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6611 $GTbY1  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6621 $GTbY1  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_nonDuct   $STb 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6612 $GTbY1  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6622 $GTbY1  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# X=1;
rcBC_nonDuct   $STb 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6213 $GTbY2  6213 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6223 $GTbY2  6223 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6313 $GTbY2  6313 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6323 $GTbY2  6323 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6413 $GTbY2  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6423 $GTbY2  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6513 $GTbY2  6513 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6523 $GTbY2  6523 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6613 $GTbY1  6613 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6623 $GTbY1  6623 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# X=1;
rcBC_nonDuct   $STb 	6114 $GTbY1  6114 6124 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6124 $GTbY1  6124 6134 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6214 $GTbY2  6214 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6224 $GTbY2  6224 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6314 $GTbY2  6314 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6324 $GTbY2  6324 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6414 $GTbY2  6414 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6424 $GTbY2  6424 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6514 $GTbY2  6514 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6524 $GTbY2  6524 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6614 $GTbY1  6614 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6624 $GTbY1  6624 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#5th Floor

# X=1;
rcBC_nonDuct   $STb 	6115 $GTbY1  6115 6125 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6125 $GTbY1  6125 6135 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6215 $GTbY2  6215 6225 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6225 $GTbY2  6225 6235 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6315 $GTbY2  6315 6325 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6325 $GTbY2  6325 6335 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6415 $GTbY2  6415 6425 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6425 $GTbY2  6425 6435 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6515 $GTbY2  6515 6525 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6525 $GTbY2  6525 6535 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6615 $GTbY1  6615 6625 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6625 $GTbY1  6625 6635 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#6th Floor

# X=1;
rcBC_nonDuct   $STb 	6116 $GTbY1  6116 6126 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6126 $GTbY1  6126 6136 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_nonDuct   $STb 	6216 $GTbY2  6216 6226 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6226 $GTbY2  6226 6236 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_nonDuct   $STb 	6316 $GTbY2  6316 6326 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6326 $GTbY2  6326 6336 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_nonDuct   $STb 	6416 $GTbY2  6416 6426 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6426 $GTbY2  6426 6436 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_nonDuct   $STb 	6516 $GTbY2  6516 6526 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_nonDuct   $STb 	6526 $GTbY2  6526 6536 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_nonDuct   $STb 	6616 $GTbY1  6616 6626 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_nonDuct   $STb 	6626 $GTbY1  6626 6636 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_nonDuct  $STc 	7111 $GTc1 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7211 $GTc1 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_nonDuct  $STc 	73101 $GTc1 1310 	13101 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7311 $GTc1 13101 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols

rcBC_nonDuct  $STc 	74101 $GTc1 1410 	14101 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7411 $GTc1 14101 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
#--------------------

rcBC_nonDuct  $STc 	7511 $GTc1 1510 	1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7611 $GTc1 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7121 $GTc1 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass12+$mass12r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7221 $GTc1 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass22+$mass22r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7321 $GTc1 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass32+$mass32r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7421 $GTc1 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass42+$mass42r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7521 $GTc1 1520 	1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass52+$mass52r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7621 $GTc1 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass62+$mass62r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7131 $GTc1 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7231 $GTc1 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7331 $GTc1 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7431 $GTc1 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7531 $GTc1 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7631 $GTc1 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (5*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_nonDuct  $STc 	7112 $GTc1 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7212 $GTc1 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_nonDuct  $STc 	73112 $GTc1 1311 	13112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7312 $GTc1 13112 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols

rcBC_nonDuct  $STc 	74112 $GTc1 1411 	14112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7412 $GTc1 14112 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
#--------------------

rcBC_nonDuct  $STc 	7512 $GTc1 1511 	1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7612 $GTc1 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7122 $GTc1 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass12+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7222 $GTc1 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass22+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7322 $GTc1 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass32+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7422 $GTc1 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass42+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7522 $GTc1 1521 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass52+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7622 $GTc1 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass62+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7132 $GTc1 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7232 $GTc1 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7332 $GTc1 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7432 $GTc1 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_nonDuct  $STc 	7532 $GTc1 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7632 $GTc1 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (4*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

#3rd Floor

# Y=1;
rcBC_nonDuct  $STc 	7113 $GTc2 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7213 $GTc2 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_nonDuct  $STc 	73123 $GTc2 1312 	13123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7313 $GTc2 13123 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

rcBC_nonDuct  $STc 	74123 $GTc2 1412 	14123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7413 $GTc2 14123 	1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
#--------------------

rcBC_nonDuct  $STc 	7513 $GTc2 1512 	1513 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7613 $GTc2 1612 	1613 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7123 $GTc2 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass12+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7223 $GTc2 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass22+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7323 $GTc2 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass32+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7423 $GTc2 1422 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass42+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7523 $GTc2 1522 	1523 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass52+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7623 $GTc2 1622 	1623 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass62+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7133 $GTc2 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7233 $GTc2 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7333 $GTc2 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7433 $GTc2 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7533 $GTc2 1532 	1533 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7633 $GTc2 1632 	1633 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (3*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#4th Floor

# Y=1;
rcBC_nonDuct  $STc 	7114 $GTc2 1113 	1114 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7214 $GTc2 1213 	1214 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_nonDuct  $STc 	73134 $GTc2 1313 	13134 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7314 $GTc2 13134 	1314 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

rcBC_nonDuct  $STc 	74134 $GTc2 1413 	14134 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7414 $GTc2 14134 	1414 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
#--------------------

rcBC_nonDuct  $STc 	7514 $GTc2 1513 	1514 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7614 $GTc2 1613 	1614 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7124 $GTc2 1123 	1124 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass12+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7224 $GTc2 1223 	1224 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass22+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7324 $GTc2 1323 	1324 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass32+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7424 $GTc2 1423 	1424 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass42+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7524 $GTc2 1523 	1524 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass52+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7624 $GTc2 1623 	1624 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass62+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7134 $GTc2 1133 	1134 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7234 $GTc2 1233 	1234 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7334 $GTc2 1333 	1334 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7434 $GTc2 1433 	1434 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_nonDuct  $STc 	7534 $GTc2 1533 	1534 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7634 $GTc2 1633 	1634 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL3 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#5th Floor

# Y=1;
rcBC_nonDuct  $STc 	7115 $GTc3 1114 	1115 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7215 $GTc3 1214 	1215 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_nonDuct  $STc 	73145 $GTc3 1314 	13145 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7315 $GTc3 13145 	1315 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

rcBC_nonDuct  $STc 	74145 $GTc3 1414 	14145 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7415 $GTc3 14145 	1415 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
#--------------------

rcBC_nonDuct  $STc 	7515 $GTc3 1514 	1515 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7615 $GTc3 1614 	1615 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7125 $GTc3 1124 	1125 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass12+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7225 $GTc3 1224 	1225 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass22+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7325 $GTc3 1324 	1325 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass32+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7425 $GTc3 1424 	1425 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass42+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7525 $GTc3 1524 	1525 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass52+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7625 $GTc3 1624 	1625 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass62+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7135 $GTc3 1134 	1135 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7235 $GTc3 1234 	1235 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7335 $GTc3 1334 	1335 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7435 $GTc3 1434 	1435 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7535 $GTc3 1534 	1535 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7635 $GTc3 1634 	1635 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

#6th Floor

# Y=1;
rcBC_nonDuct  $STc 	7116 $GTc3 1115 	1116 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7216 $GTc3 1215 	1216 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7316 $GTc3 1315 	1316 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7416 $GTc3 1415 	1416 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7516 $GTc3 1515 	1516 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7616 $GTc3 1615 	1616 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_nonDuct  $STc 	7126 $GTc3 1125 	1126 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass12+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7226 $GTc3 1225 	1226 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass22+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7326 $GTc3 1325 	1326 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass32+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7426 $GTc3 1425 	1426 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass42+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7526 $GTc3 1525 	1526 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass52+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7626 $GTc3 1625 	1626 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass62+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_nonDuct  $STc 	7136 $GTc3 1135 	1136 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7236 $GTc3 1235 	1236 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7336 $GTc3 1335 	1336 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7436 $GTc3 1435 	1436 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_nonDuct  $STc 	7536 $GTc3 1535 	1536 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_nonDuct  $STc 	7636 $GTc3 1635 	1636 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

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
infill 		2111 	single 	[list 1111 1211 1210 1110] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2211 	single 	[list 1211 1311 1310 1210] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2311 	single 	[list 1311 1411 1410 1310] 	 2600. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2411 	single 	[list 1411 1511 1510 1410] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2511 	single 	[list 1511 1611 1610 1510] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2121 	single 	[list 1121 1221 1220 1120] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2221 	single 	[list 1221 1321 1320 1220] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2321 	single 	[list 1321 1421 1420 1320] 	 2600. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2421 	single 	[list 1421 1521 1520 1420] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2521 	single 	[list 1521 1621 1620 1520] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

# Y=3;
infill 		2131 	single 	[list 1131 1231 1230 1130] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2231 	single 	[list 1231 1331 1330 1230] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2331 	single 	[list 1331 1431 1430 1330] 	 2600. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2431 	single 	[list 1431 1531 1530 1430] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2531 	single 	[list 1531 1631 1630 1530] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

}

# 2nd Floor

# Y=1;
infill 		2112 	single 	[list 1112 1212 1211 1111] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2212 	single 	[list 1212 1312 1311 1211] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2312 	single 	[list 1312 1412 1411 1311] 	 2600. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2412 	single 	[list 1412 1512 1511 1411] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2512 	single 	[list 1512 1612 1611 1511] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2122 	single 	[list 1122 1222 1221 1121] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2222 	single 	[list 1222 1322 1321 1221] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2322 	single 	[list 1322 1422 1421 1321] 	 2600. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2422 	single 	[list 1422 1522 1521 1421] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2522 	single 	[list 1522 1622 1621 1521] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

# Y=3;
infill 		2132 	single 	[list 1132 1232 1231 1131] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2232 	single 	[list 1232 1332 1331 1231] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2332 	single 	[list 1332 1432 1431 1331] 	 2600. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2432 	single 	[list 1432 1532 1531 1431] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2532 	single 	[list 1532 1632 1631 1531] 	 4000. [expr $H*1000] 	   $hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 3rd Floor

# Y=1;
infill 		2113 	single 	[list 1113 1213 1212 1112] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2213 	single 	[list 1213 1313 1312 1212] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2313 	single 	[list 1313 1413 1412 1312] 	 2600. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2413 	single 	[list 1413 1513 1512 1412] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2513 	single 	[list 1513 1613 1612 1512] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2123 	single 	[list 1123 1223 1222 1122] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2223 	single 	[list 1223 1323 1322 1222] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2323 	single 	[list 1323 1423 1422 1322] 	 2600. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2423 	single 	[list 1423 1523 1522 1422] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2523 	single 	[list 1523 1623 1622 1522] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

# Y=3;
infill 		2133 	single 	[list 1133 1233 1232 1132] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2233 	single 	[list 1233 1333 1332 1232] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2333 	single 	[list 1333 1433 1432 1332] 	 2600. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2433 	single 	[list 1433 1533 1532 1432] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2533 	single 	[list 1533 1633 1632 1532] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 4th Floor

# Y=1;
infill 		2114 	single 	[list 1114 1214 1213 1113] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2214 	single 	[list 1214 1314 1313 1213] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2314 	single 	[list 1314 1414 1413 1313] 	 2600. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2414 	single 	[list 1414 1514 1513 1413] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2514 	single 	[list 1514 1614 1613 1513] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2124 	single 	[list 1124 1224 1223 1123] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2224 	single 	[list 1224 1324 1323 1223] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2324 	single 	[list 1324 1424 1423 1323] 	 2600. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2424 	single 	[list 1424 1524 1523 1423] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2524 	single 	[list 1524 1624 1623 1523] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

# Y=3;
infill 		2134 	single 	[list 1134 1234 1233 1133] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2234 	single 	[list 1234 1334 1333 1233] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2334 	single 	[list 1334 1434 1433 1333] 	 2600. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2434 	single 	[list 1434 1534 1533 1433] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2534 	single 	[list 1534 1634 1633 1533] 	 4000. [expr $H*1000] 	   $hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 5th Floor

# Y=1;
infill 		2115 	single 	[list 1115 1215 1214 1114] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2215 	single 	[list 1215 1315 1314 1214] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2315 	single 	[list 1315 1415 1414 1314] 	 2600. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2415 	single 	[list 1415 1515 1514 1414] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2515 	single 	[list 1515 1615 1614 1514] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2125 	single 	[list 1125 1225 1224 1124] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2225 	single 	[list 1225 1325 1324 1224] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2325 	single 	[list 1325 1425 1424 1324] 	 2600. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2425 	single 	[list 1425 1525 1524 1424] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2525 	single 	[list 1525 1625 1624 1524] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

# Y=3;
infill 		2135 	single 	[list 1135 1235 1234 1134] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2235 	single 	[list 1235 1335 1334 1234] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2335 	single 	[list 1335 1435 1434 1334] 	 2600. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2435 	single 	[list 1435 1535 1534 1434] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2535 	single 	[list 1535 1635 1634 1534] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 6th Floor

# Y=1;
infill 		2116 	single 	[list 1116 1216 1215 1115] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2216 	single 	[list 1216 1316 1315 1215] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2316 	single 	[list 1316 1416 1415 1315] 	 2600. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2416 	single 	[list 1416 1516 1515 1415] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2516 	single 	[list 1516 1616 1615 1515] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=2;
infill 		2126 	single 	[list 1126 1226 1225 1125] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2226 	single 	[list 1226 1326 1325 1225] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2326 	single 	[list 1326 1426 1425 1325] 	 2600. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
infill 		2426 	single 	[list 1426 1526 1525 1425] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
infill 		2526 	single 	[list 1526 1626 1625 1525] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

# Y=3;
infill 		2136 	single 	[list 1136 1236 1235 1135] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2236 	single 	[list 1236 1336 1335 1235] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2336 	single 	[list 1336 1436 1435 1335] 	 2600. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2436 	single 	[list 1436 1536 1535 1435] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2536 	single 	[list 1536 1636 1635 1535] 	 4000. [expr $H*1000] 	   $hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# -------------------
# Y-Direction
# -------------------
if {$pilotisOPT==0} {

# 1st Floor

# X=1;
infill 		3111 	single 	[list 1111 1121 1120 1110] 	4000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3211 	single 	[list 1121 1131 1130 1120] 	5000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3131 	single 	[list 1321 1331 1330 1320] 	5000. [expr $H*1000] 	$hb2 $bc1 $hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3141 	single 	[list 1421 1431 1430 1420] 	5000. [expr $H*1000] 	$hb2 $bc1 $hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3161 	single 	[list 1611 1621 1620 1610] 	4000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3261 	single 	[list 1621 1631 1630 1620] 	5000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

}

# 2nd Floor

# X=1;
infill 		3112 	single 	[list 1112 1122 1121 1111] 	4000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3212 	single 	[list 1122 1132 1131 1121] 	5000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3132 	single 	[list 1322 1332 1331 1321] 	5000. [expr $H*1000] 	$hb2 $bc1 $hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3142 	single 	[list 1422 1432 1431 1421] 	5000. [expr $H*1000] 	$hb2 $bc1 $hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3162 	single 	[list 1612 1622 1621 1611] 	4000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3262 	single 	[list 1622 1632 1631 1621] 	5000. [expr $H*1000] 	$hb1 $bc1 $hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 3rd Floor

# X=1;
infill 		3113 	single 	[list 1113 1123 1122 1112] 	4000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3213 	single 	[list 1123 1133 1132 1122] 	5000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3133 	single 	[list 1323 1333 1332 1322] 	5000. [expr $H*1000] 	$hb2 $bc2 $hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3143 	single 	[list 1423 1433 1432 1422] 	5000. [expr $H*1000] 	$hb2 $bc2 $hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3163 	single 	[list 1613 1623 1622 1612] 	4000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3263 	single 	[list 1623 1633 1632 1622] 	5000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 4th Floor

# X=1;
infill 		3114 	single 	[list 1114 1124 1123 1113] 	4000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3214 	single 	[list 1124 1134 1133 1123] 	5000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3134 	single 	[list 1324 1334 1333 1323] 	5000. [expr $H*1000] 	$hb2 $bc2 $hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3144 	single 	[list 1424 1434 1433 1423] 	5000. [expr $H*1000] 	$hb2 $bc2 $hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3164 	single 	[list 1614 1624 1623 1613] 	4000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3264 	single 	[list 1624 1634 1633 1623] 	5000. [expr $H*1000] 	$hb1 $bc2 $hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 5th Floor

# X=1;
infill 		3115 	single 	[list 1115 1125 1124 1114] 	4000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3215 	single 	[list 1125 1135 1134 1124] 	5000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3135 	single 	[list 1325 1335 1334 1324] 	5000. [expr $H*1000] 	$hb2 $bc3 $hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3145 	single 	[list 1425 1435 1434 1424] 	5000. [expr $H*1000] 	$hb2 $bc3 $hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3165 	single 	[list 1615 1625 1624 1614] 	4000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3265 	single 	[list 1625 1635 1634 1624] 	5000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 6th Floor

# X=1;
infill 		3116 	single 	[list 1116 1126 1125 1115] 	4000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3216 	single 	[list 1126 1136 1135 1125] 	5000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3136 	single 	[list 1326 1336 1335 1325] 	5000. [expr $H*1000] 	$hb2 $bc3 $hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3146 	single 	[list 1426 1436 1435 1425] 	5000. [expr $H*1000] 	$hb2 $bc3 $hc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3166 	single 	[list 1616 1626 1625 1615] 	4000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3266 	single 	[list 1626 1636 1635 1625] 	5000. [expr $H*1000] 	$hb1 $bc3 $hc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

puts "Infills created..."
}

# --------------------------------------
# DEFINE STAIRS
# --------------------------------------
if {$stairsOPT == 1} {

  # Stairs from 0 to 1

  rcBC_nonDuct            $STb 	99911     $GTbY1  10 40 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99921     $GTbY1  20 50 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99931     $GTbY1  40 13101 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99941     $GTbX1  13101 14101 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99951     $GTbY1  14101 60 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99961     $GTbX1  40 50 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99971     $GTbX1  50 60 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99981     $GTbY1  50 21    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99991     $GTbY1  60 31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999101     $GTbX1  21 31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999111     $GTbX1  21 11 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  # Stairs from 1 to 2
  rcBC_nonDuct            $STb 	99912     $GTbY1  11 41 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99922     $GTbY1  21 51 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99932     $GTbY1  41 13112 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99942     $GTbX1  13112 14112 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99952     $GTbY1  14112 61 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99962     $GTbX1  41 51 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99972     $GTbX1  51 61 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99982     $GTbY1  51 22    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99992     $GTbY1  61 32 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999102     $GTbX1  22 32 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999112     $GTbX1  22 12 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  # Stairs from 2 to 3
  rcBC_nonDuct            $STb 	99913     $GTbY1  12 42 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99923     $GTbY1  22 52 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99933     $GTbY1  42 13123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99943     $GTbX1  13123 14123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99953     $GTbY1  14123 62 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99963     $GTbX1  42 52 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99973     $GTbX1  52 62 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99983     $GTbY1  52 23    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99993     $GTbY1  62 33 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999103     $GTbX1  23 33 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999113     $GTbX1  23 13 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  # Stairs from 3 to 4
  rcBC_nonDuct            $STb 	99914     $GTbY1  13 43 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99924     $GTbY1  23 53 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99934     $GTbY1  43 13134 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99944     $GTbX1  13134 14134 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99954     $GTbY1  14134 63 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99964     $GTbX1  43 53 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99974     $GTbX1  53 63 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99984     $GTbY1  53 24    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99994     $GTbY1  63 34 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999104     $GTbX1  24 34 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999114     $GTbX1  24 14 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  # Stairs from 4 to 5
  rcBC_nonDuct            $STb 	99915     $GTbY1  14 44 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99925     $GTbY1  24 54 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99935     $GTbY1  44 13145 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99945     $GTbX1  13145 14145 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99955     $GTbY1  14145 64 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99965     $GTbX1  44 54 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99975     $GTbX1  54 64 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99985     $GTbY1  54 25    $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99995     $GTbY1  64 35 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999105     $GTbX1  25 35 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

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
fix 	1510	1  1  1  1  1  1
fix 	1610	1  1  1  1  1  1

fix 	1120	1  1  1  1  1  1
fix 	1220	1  1  1  1  1  1
fix 	1320	1  1  1  1  1  1
fix 	1420	1  1  1  1  1  1
fix 	1520	1  1  1  1  1  1
fix 	1620	1  1  1  1  1  1

fix 	1130	1  1  1  1  1  1
fix 	1230	1  1  1  1  1  1
fix 	1330	1  1  1  1  1  1
fix 	1430	1  1  1  1  1  1
fix 	1530	1  1  1  1  1  1
fix 	1630	1  1  1  1  1  1

if {$stairsOPT == 1} {
  fix  10   1  1  1  1  1  1; #added node for stairs
  fix  20   1  1  1  1  1  1
}

# Rigid Diaphragm

rigidDiaphragm 3	1431 1111 1211 1311 1411 1511 1611  1121 1221 1321 1421 1521 1621 1131 1231 1331 1531 1631
rigidDiaphragm 3	1432 1112 1212 1312 1412 1512 1612  1122 1222 1322 1422 1522 1622 1132 1232 1332 1532 1632
rigidDiaphragm 3	1433 1113 1213 1313 1413 1513 1613  1123 1223 1323 1423 1523 1623 1133 1233 1333 1533 1633
rigidDiaphragm 3	1434 1114 1214 1314 1414 1514 1614  1124 1224 1324 1424 1524 1624 1134 1234 1334 1534 1634
rigidDiaphragm 3	1435 1115 1215 1315 1415 1515 1615  1125 1225 1325 1425 1525 1625 1135 1235 1335 1535 1635
rigidDiaphragm 3	1436 1116 1216 1316 1416 1516 1616  1126 1226 1326 1426 1526 1626 1136 1236 1336 1536 1636

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

	load 1121 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0; # First Floor
	load 1221 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0; # First Floor
	load 1321 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0; # First Floor
	load 1421 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0; # First Floor
  load 1521 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0; # First Floor
  load 1621 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0; # First Floor

	load 1131 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0; # First Floor
	load 1231 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0; # First Floor
	load 1331 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0; # First Floor
	load 1431 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0; # First Floor
  load 1531 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0; # First Floor
  load 1631 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0; # First Floor

  load 1112 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Second Floor
  load 1212 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1312 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1412 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;
  load 1512 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0;
  load 1612 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0;

  load 1122 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1222 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1322 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
  load 1422 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;
  load 1522 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0;
  load 1622 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0;

  load 1132 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1232 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1332 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
  load 1432 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;
  load 1532 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0;
  load 1632 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0;

  load 1113 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Third Floor
  load 1213 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1313 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1413 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;
  load 1513 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0;
  load 1613 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0;

  load 1123 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1223 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1323 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
  load 1423 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;
  load 1523 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0;
  load 1623 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0;

  load 1133 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1233 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1333 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
  load 1433 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;
  load 1533 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0;
  load 1633 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0;

  load 1114 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Fourth Floor
  load 1214 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1314 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1414 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;
  load 1514 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0;
  load 1614 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0;

  load 1124 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1224 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1324 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
  load 1424 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;
  load 1524 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0;
  load 1624 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0;

  load 1134 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1234 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1334 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
  load 1434 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;
  load 1534 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0;
  load 1634 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0;

  load 1115 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Fifth Floor
  load 1215 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1315 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1415 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;
  load 1515 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0;
  load 1615 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0;

  load 1125 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1225 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1325 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
  load 1425 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;
  load 1525 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0;
  load 1625 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0;

  load 1135 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1235 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1335 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
  load 1435 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;
  load 1535 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0;
  load 1635 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0;

	load 1116 	0.0	0.0	[expr -$mass11r*$g] 	0.0	0.0	0.0; # Roof Level
	load 1216 	0.0	0.0	[expr -$mass21r*$g] 	0.0	0.0	0.0;
	load 1316 	0.0	0.0	[expr -$mass31r*$g] 	0.0	0.0	0.0;
	load 1416 	0.0	0.0	[expr -$mass41r*$g] 	0.0	0.0	0.0;
  load 1516 	0.0	0.0	[expr -$mass51r*$g] 	0.0	0.0	0.0;
	load 1616 	0.0	0.0	[expr -$mass61r*$g] 	0.0	0.0	0.0;

  load 1126 	0.0	0.0	[expr -$mass12r*$g] 	0.0	0.0	0.0; # Roof Level
  load 1226 	0.0	0.0	[expr -$mass22r*$g] 	0.0	0.0	0.0;
  load 1326 	0.0	0.0	[expr -$mass32r*$g] 	0.0	0.0	0.0;
  load 1426 	0.0	0.0	[expr -$mass42r*$g] 	0.0	0.0	0.0;
  load 1526 	0.0	0.0	[expr -$mass52r*$g] 	0.0	0.0	0.0;
  load 1626 	0.0	0.0	[expr -$mass62r*$g] 	0.0	0.0	0.0;

  load 1136 	0.0	0.0	[expr -$mass13r*$g] 	0.0	0.0	0.0; # Roof Level
  load 1236 	0.0	0.0	[expr -$mass23r*$g] 	0.0	0.0	0.0;
  load 1336 	0.0	0.0	[expr -$mass33r*$g] 	0.0	0.0	0.0;
  load 1436 	0.0	0.0	[expr -$mass43r*$g] 	0.0	0.0	0.0;
  load 1536 	0.0	0.0	[expr -$mass53r*$g] 	0.0	0.0	0.0;
  load 1636 	0.0	0.0	[expr -$mass63r*$g] 	0.0	0.0	0.0;

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
modalAnalysis $nst 1 _Archetype_6_${nst}st_${mtype} "$outsdir/info/modal/"

# --------------------------------------
# PRINT STUFF
# --------------------------------------
file delete $outsdir/info/models/Archetype_6_model_${nst}st_${mtype}.txt
print $outsdir/info/models/Archetype_6_model_${nst}st_${mtype}.txt

# --------------------------------------
# DEFINE RECORDERS
# --------------------------------------
set node_recorder 		{1430 1431 1432 1433 1434 1435 1436}; # List of nodes to record

set bNode {1430 1431 1432 1433 1434 1435}; # iNodes for drift
set tNode {1431 1432 1433 1434 1435 1436}; # jNodes for drift
set baseNode 1430; #1220; # Base Node (for roof drift recorder)
set roofNode 1436; #1222; # Top Node


# Print a list of the elements and nodes recorded
file delete $outsdir/info/recorders/Archetype_6_recordersList_${nst}st_${mtype}.m
set rec_list [open $outsdir/info/recorders/Archetype_6_recordersList_${nst}st_${mtype}.m w];
puts $rec_list "node_list=\[$node_recorder];"
#puts $rec_list "bm_list=\[$beam_recorder];"
#puts $rec_list "col_list=\[$column_recorder];"
#puts $rec_list "jnt_list=\[$joint_recorder];"
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

# ------------------------------------------
#
# -- Script to Create a Masonry Infill -----
#
# ------------------------------------------
# Al Mouayed Bellah Nafeh
# Affiliation: IUSS Pavia
# September 2017

proc infill {eleTag typ nds B H hb hc bc tw Ec Ewh Ewv Gw v fwv fwu fws sig_v {pflag 0}} {
# --------------------------------------
# -- Description of the Parameters -----
# --------------------------------------
# eleTag 	label of panel
# typ		type of infill model (single/double/triple)
# nds 		list of nodes [list TL TR BR BL]/[list TL TL TR TR BR BR BL BL] (i.e always start numbering from top left corner)
# B 		Bay width (centrelines) [mm]
# H 		Height (centrelines) [mm]
# hb 		Beam height [mm]
# hc 		Column height [mm]
# bc 		Column width [mm]
# tw 		Wall thickness [mm]
# Ec 		Concrete Elastic Modulus [MPa]
# Ewh 		Horizontal secant modulus [MPa]
# Ewv 		Vertical Secant Modulus [MPa]
# Gw 		Shear Modulus [MPa]
# v 		Poissons Ratio
# fwv 		Vertical compressive strength [MPa]
# fwu 		Sliding shear resistance of mortar joints [MPa]
# fws 		Shear resistance under diagonal compression [MPa]
# sig_v		Vertical Compression due to gravity loading [MPa]
# GT_inf	geometric transformation tag for rigid beams
# pflag 	put 1 to print info
global MPa
global mm
set pi 3.14

# --------------------------------------
# CALCULATE SOME TERMS
# --------------------------------------
set Ic 		[expr $bc*pow($hc,3)/12]; # mm2
set Bw 		[expr $B-$hc]; # mm
set Hw		[expr $H-$hb]; # mm
set theta 	[expr atan($Hw/$Bw)]; # rad
set dw		[expr sqrt($Bw*$Bw+$Hw*$Hw)]; # mm
set Ewtheta	[expr 1/(pow(cos($theta),4)/$Ewh+pow(sin($theta),4)/$Ewv+pow(cos($theta),2)*pow(sin($theta),2)*(1.0/$Gw-2.0*$v/$Ewv))];
set lambdaH	[expr $H*pow($Ewtheta*$tw*sin(2*$theta)/4/$Ec/$Ic/$Hw,0.25)];
set z		[expr  $pi/2/$lambdaH*$H]; # mm
set s		[expr $z/3]; # in mm

# --------------------------------------
# DETERMINE WIDTH OF STRUT
# --------------------------------------
if {$lambdaH < 3.14} {set K1 1.300; set K2 -0.178}
if {$lambdaH > 3.14 && $lambdaH < 7.85} {set K1 0.707; set K2  0.010}
if {$lambdaH > 7.85} {set K1 0.470; set K2  0.040}
set bw		[expr $dw*($K1/$lambdaH+$K2)]; #mm
set Aw		[expr $bw*$tw*$mm*$mm]; #m2

# --------------------------------------
# DETERMINE CRITICAL STRESS IN EACH MODE
# --------------------------------------
set sigw1 [expr 1.16*$fwv*tan($theta)/($K1+$K2*$lambdaH)]; # Compression in centre
set sigw2 [expr 1.12*$fwv*sin($theta)*cos($theta)/($K1*pow($lambdaH,-0.12)+$K2*pow($lambdaH,0.88))]; # Compression at corners
set sigw3 [expr ($fwu*(1.2*sin($theta)+0.45*cos($theta))+0.3*$sig_v)*$dw/$bw]; # Shear sliding
set sigw4 [expr (0.6*$fws+0.3*$sig_v)*$dw/$bw]; # Diagonal tension

set sigw $sigw1
if {$sigw2 < $sigw} {set sigw $sigw2}
if {$sigw3 < $sigw} {set sigw $sigw3}
if {$sigw4 < $sigw} {set sigw $sigw4}

# --------------------------------------
# DETERMINE HYSTERETIC RULE
# --------------------------------------
set sigDS2		[expr $sigw*$MPa];
set sigDS1 		[expr 0.80*$sigDS2];
set sigDS4 		[expr 0.10*$sigDS2];

set K1 [expr 0.8*$Gw*$Bw*$tw/$Hw/1e3];
set Ftruss [expr $sigDS1*$Aw];
set FDS1 [expr $Ftruss*cos($theta)];
set del	[expr $FDS1/$K1];
set thetaDS1	[expr $del/$Hw];
if {$pflag==10} {puts [format "Params: K1=%.3f  Ftruss= %.3f FDS1=%.3f del=%.6f thetaDS1=%.6f" $K1 $Ftruss $FDS1 $del $thetaDS1];}

# Set drift limits (from Sassun et al. [2015])
set thetaDS1	0.0018
set thetaDS2	0.0046
set thetaDS3	0.0105
set thetaDS4 	0.0188
set epsDS1		[expr 1-sqrt((1+pow($B/$H-$thetaDS1,2))/(1+pow($B/$H,2)))];
set epsDS2		[expr 1-sqrt((1+pow($B/$H-$thetaDS2,2))/(1+pow($B/$H,2)))];
set epsDS3		[expr 1-sqrt((1+pow($B/$H-$thetaDS3,2))/(1+pow($B/$H,2)))];
set epsDS4		[expr 1-sqrt((1+pow($B/$H-$thetaDS4,2))/(1+pow($B/$H,2)))];


proc procUniaxialPinching { materialTag pEnvelopeStress nEnvelopeStress pEnvelopeStrain nEnvelopeStrain rDisp rForce uForce gammaK gammaD gammaF gammaE damage} {uniaxialMaterial Pinching4 $materialTag [lindex $pEnvelopeStress 0] [lindex $pEnvelopeStrain 0] [lindex $pEnvelopeStress 1] [lindex $pEnvelopeStrain 1] [lindex $pEnvelopeStress 2] [lindex $pEnvelopeStrain 2] [lindex $pEnvelopeStress 3] [lindex $pEnvelopeStrain 3] [lindex $nEnvelopeStress 0] [lindex $nEnvelopeStrain 0] [lindex $nEnvelopeStress 1] [lindex $nEnvelopeStrain 1] [lindex $nEnvelopeStress 2] [lindex $nEnvelopeStrain 2] [lindex $nEnvelopeStress 3] [lindex $nEnvelopeStrain 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage}

if {$typ=="truss"} {
	set deltaDS1	[expr $thetaDS1*$H/2];
	set deltaDS2	[expr $thetaDS2*$H/2];
	set deltaDS4	[expr $thetaDS4*$H/2];

	set forceDS1	[expr $sigDS1*$Aw];
	set forceDS2	[expr $sigDS2*$Aw];
	set forceDS4	[expr $sigDS4*$Aw];

	set pF [list $forceDS1 $forceDS2 $forceDS4 $forceDS4];
	set nF [list -$forceDS1 -$forceDS2 -$forceDS4 -$forceDS4];
	set pD [list $deltaDS1 $deltaDS2 $deltaDS4 $deltaDS4];
	set nD [list -$deltaDS1 -$deltaDS2 -$deltaDS4 -$deltaDS4];
	set rDisp [list 0.8 0.8]; # Pos_env. Neg_env. ##### Ratio of maximum deformation at which reloading begins
	set rForce [list 0.1 0.1]; # Pos_env. Neg_env. ##### Ratio of envelope force (corresponding to maximum deformation) at which reloading begins
	set uForce [list 0.0 0.0]; # Pos_env. Neg_env. ##### Ratio of monotonic strength developed upon unloading
	set gammaK [list 0.0 0.0 0.0 0.0 0.0]; # gammaK1 gammaK2 gammaK3 gammaK4 gammaKLimit ##### Coefficients for Unloading Stiffness degradation
	set gammaD [list 0.0 0.0 0.0 0.0 0.0]; # gammaD1 gammaD2 gammaD3 gammaD4 gammaDLimit ##### Coefficients for Reloading Stiffness degradation
	set gammaF [list 0.0 0.0 0.0 0.0 0.0]; # gammaF1 gammaF2 gammaF3 gammaF4 gammaFLimit ##### Coefficients for Strength degradation
	set gammaE 0.0
	set dam "energy"; # damage type (option: "energy", "cycle")
	# add the material to domain through the use of a procedure
	procUniaxialPinching 9${eleTag} $pF $nF $pD $nD $rDisp $rForce $uForce $gammaK $gammaD $gammaF $gammaE $dam
# 	uniaxialMaterial Elastic 800${eleTag} 1e10

} else {
	##### Positive/Negative envelope
	set pF [list 0.001 0.002 0.001 0.001]; # stress1 stress2 stress3 stress4
	set nF [list -$sigDS1 -$sigDS2 -$sigDS4 -$sigDS4]; # stress1 stress2 stress3 stress4
	##### Positive/Negative envelope
	set pD [list $epsDS1 $epsDS2 $epsDS4 $epsDS4]; # strain1 strain2 strain3 strain4
	set nD [list -$epsDS1 -$epsDS2 -$epsDS4 -$epsDS4]; # strain1 strain2 strain3 strain4
	set rD [list 0.8 0.8]; # Pos_env. Neg_env.##### Ratio of maximum deformation at which reloading begins
	set rF [list 0.1 0.1]; # Pos_env. Neg_env.##### Ratio of envelope force (corresponding to maximum deformation) at which reloading begins
	set uF [list 0.0 0.0]; # Pos_env. Neg_env.##### Ratio of monotonic strength developed upon unloading
	set gK [list 0.0 0.0 0.0 0.0 0.0]; # gammaK1 gammaK2 gammaK3 gammaK4 gammaKLimit
	set gD [list 0.0 0.0 0.0 0.0 0.0]; # gammaD1 gammaD2 gammaD3 gammaD4 gammaDLimit
	set gF [list 0.0 0.0 0.0 0.0 0.0]; # gammaF1 gammaF2 gammaF3 gammaF4 gammaFLimit
	set gE 0.0
	set dM "energy"; # damage type (option: "energy", "cycle")
	# add the material to domain through the use of a procedure
	procUniaxialPinching 8${eleTag} $pF $nF $pD $nD $rD $rF $uF $gK $gD $gF $gE $dM
# 	uniaxialMaterial Hysteretic $matTag $s1p $e1p $s2p $e2p <$s3p $e3p> $s1n $e1n $s2n $e2n <$s3n $e3n> $pinchX $pinchY $damage1 $damage2 <$beta0>
# 	set pinchX 0.8; # These terms are calibrated by Cavalieri et al. [2005] and listed in Landi et al. DBA chapter
# 	set pinchY 0.1;
# 	set damage1 0.0;
# 	set damage2 0.0;
# 	set beta0 0.5;
# 	uniaxialMaterial Hysteretic 8${eleTag} [lindex $pF 0] [lindex $pD 0] [lindex $pF 1] [lindex $pD 1] [lindex $pF 2] [lindex $pD 2] [lindex $nF 0] [lindex $nD 0] [lindex $nF 1] [lindex $nD 1] [lindex $nF 2] [lindex $nD 2] $pinchX $pinchY $damage1 $damage2 $beta0
}

# --------------------------------------
# CREATE ELEMENTS
# --------------------------------------
if {$typ=="single"} {
	set nI	[lindex $nds 0];
	set nJ	[lindex $nds 1];
	set nK	[lindex $nds 2];
	set nL	[lindex $nds 3];

	# element truss $eleTag $iNode $jNode 	$A 			$matTag <-doRayleigh $rFlag>
	element truss ${eleTag}1 $nI $nK $Aw 8${eleTag} -doRayleigh 1
	element truss ${eleTag}2 $nL $nJ $Aw 8${eleTag} -doRayleigh 1
}

if {$typ=="double"} {
	# Calculate the offset for the node
	set nI1	[lindex $nds 0];
	set nI2	[lindex $nds 1];
	set nJ1	[lindex $nds 2];
	set nJ2	[lindex $nds 3];
	set nK1	[lindex $nds 4];
	set nK2	[lindex $nds 5];
	set nL1	[lindex $nds 6];
	set nL2	[lindex $nds 7];

	# Remove nodes and redefine positions of actual offsets
# 	remove node $nI1
# 	remove node $nJ2
# 	remove node $nK1
# 	remove node $nL2
# 	node $nI1  [nodeCoord $nI2 1] [nodeCoord $nI2 2] [expr [nodeCoord $nI2 3]-$z/3*$mm]
# 	node $nJ2  [nodeCoord $nJ1 1] [nodeCoord $nJ1 2] [expr [nodeCoord $nJ1 3]-$z/3*$mm]
# 	node $nK1  [nodeCoord $nK2 1] [nodeCoord $nK2 2] [expr [nodeCoord $nK2 3]+$z/3*$mm]
# 	node $nL2  [nodeCoord $nL1 1] [nodeCoord $nL1 2] [expr [nodeCoord $nL1 3]+$z/3*$mm]

	# element truss $eleTag $iNode $jNode 	$A 			$matTag <-doRayleigh $rFlag>
	element truss ${eleTag}1 $nI1 $nK2 [expr 0.5*$Aw] 8${eleTag} -doRayleigh 1
	element truss ${eleTag}2 $nI2 $nK1 [expr 0.5*$Aw] 8${eleTag} -doRayleigh 1
	element truss ${eleTag}3 $nL1 $nJ2 [expr 0.5*$Aw] 8${eleTag} -doRayleigh 1
	element truss ${eleTag}4 $nL2 $nJ1 [expr 0.5*$Aw] 8${eleTag} -doRayleigh 1
}

if {$typ=="triple"} {
	set nI1	[lindex $nds 0];
	set nI2	[lindex $nds 1];
	set nI3	[lindex $nds 2];
	set nJ1	[lindex $nds 3];
	set nJ2	[lindex $nds 4];
	set nJ3	[lindex $nds 5];
	set nK1	[lindex $nds 6];
	set nK2	[lindex $nds 7];
	set nK3	[lindex $nds 8];
	set nL1	[lindex $nds 9];
	set nL2	[lindex $nds 10];
	set nL3	[lindex $nds 11];

	# Remove nodes and redefine positions of actual offsets
# 	remove node $nI1
# 	remove node $nI3
# 	remove node $nJ1
# 	remove node $nJ3
# 	remove node $nK1
# 	remove node $nK3
# 	remove node $nL1
# 	remove node $nL3
# 	set b [expr $B-($H-0.5*$z)/tan($theta)];
# 	node $nI1  [nodeCoord $nI2 1] 				[nodeCoord $nI2 2] [expr [nodeCoord $nI2 3]-$z/2*$mm]
# 	node $nI3  [expr [nodeCoord $nI2 1]+$b*$mm] [nodeCoord $nI2 2] 		 [nodeCoord $nI2 3]
# 	node $nJ1  [expr [nodeCoord $nJ2 1]-$b*$mm]		[nodeCoord $nJ2 2] 		 [nodeCoord $nJ2 3]
# 	node $nJ3  [nodeCoord $nJ2 1] 					[nodeCoord $nJ2 2] [expr [nodeCoord $nJ2 3]-$z/2*$mm]
# 	node $nK1  [nodeCoord $nK2 1] 				[nodeCoord $nK2 2] [expr [nodeCoord $nK2 3]+$z/2*$mm]
# 	node $nK3  [expr [nodeCoord $nK2 1]-$b*$mm] [nodeCoord $nK2 2] 		 [nodeCoord $nK2 3]
# 	node $nL1  [expr [nodeCoord $nL2 1]+$b*$mm]		[nodeCoord $nL2 2] 		 [nodeCoord $nL2 3]
# 	node $nL3  [nodeCoord $nL2 1] 					[nodeCoord $nL2 2] [expr [nodeCoord $nL2 3]+$z/2*$mm]

	# element truss $eleTag $iNode $jNode 	$A 			$matTag <-doRayleigh $rFlag>
	element truss ${eleTag}1 $nI1 $nK3 [expr 0.25*$bw*$tw*$mm*$mm] ${eleTag} -doRayleigh 1
	element truss ${eleTag}2 $nI2 $nK2 [expr 0.50*$bw*$tw*$mm*$mm] ${eleTag} -doRayleigh 1
	element truss ${eleTag}3 $nI3 $nK1 [expr 0.25*$bw*$tw*$mm*$mm] ${eleTag} -doRayleigh 1
	element truss ${eleTag}4 $nL1 $nJ3 [expr 0.25*$bw*$tw*$mm*$mm] ${eleTag} -doRayleigh 1
	element truss ${eleTag}5 $nL2 $nJ2 [expr 0.50*$bw*$tw*$mm*$mm] ${eleTag} -doRayleigh 1
	element truss ${eleTag}6 $nL3 $nJ1 [expr 0.25*$bw*$tw*$mm*$mm] ${eleTag} -doRayleigh 1
}

if {$typ=="truss"} {
	# This is the Rodrigues approach with Decanini and Sassun modification
	set nI	[lindex $nds 0];
	set nJ	[lindex $nds 1];
	set nK	[lindex $nds 2];
	set nL	[lindex $nds 3];

	set rig [list 0.5 0.1 1e10 1e10 0.1];
	set Ar [lindex $rig 0];
	set Ir [lindex $rig 1];
	set Er [lindex $rig 2];
	set Gr [lindex $rig 3];
	set Jr [lindex $rig 4];

	# Create the centre nodes
	set cNodeU 30${eleTag}
	set cNodeL 40${eleTag}

	set nIX [nodeCoord $nI 1];
	set nIY [nodeCoord $nI 2];
	set nIZ [nodeCoord $nI 3];

	puts "# THIS ASSSUMES INFILL IS IN X DIRECTION ONLY"
	set direc 1
	if {$direc == 1} {
		node $cNodeU [expr $nIX+0.5*$B] $nIY [expr $nIZ-0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
		node $cNodeL [expr $nIX+0.5*$B] $nIY [expr $nIZ-0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
	} elseif {$direc == 2} {
# 		node $cNodeU $X [expr $Y+0.5*$Lin]  [expr $Z-0.5*$Hin] -mass 0.0 0.0 0.0 0.0 0.0 0.0
# 		node $cNodeL $X [expr $Y+0.5*$Lin]  [expr $Z-0.5*$Hin] -mass 0.0 0.0 0.0 0.0 0.0 0.0
	}

	# Rigidlinks
	# element corotTruss $eleTag $iNode $jNode $A $matTag
	element elasticBeamColumn ${eleTag}1 $nI $cNodeU $Ar $Er $Gr $Jr $Ir $Ir $GT_inf
	element elasticBeamColumn ${eleTag}2 $nJ $cNodeU $Ar $Er $Gr $Jr $Ir $Ir $GT_inf
	element elasticBeamColumn ${eleTag}3 $nK $cNodeL $Ar $Er $Gr $Jr $Ir $Ir $GT_inf
	element elasticBeamColumn ${eleTag}4 $nL $cNodeL $Ar $Er $Gr $Jr $Ir $Ir $GT_inf

# 	element truss ${eleTag}1 $nI $cNodeU $Ar 800${eleTag} -doRayleigh 1
# 	element truss ${eleTag}2 $nJ $cNodeU $Ar 800${eleTag} -doRayleigh 1
# 	element truss ${eleTag}3 $nK $cNodeL $Ar 800${eleTag} -doRayleigh 1
# 	element truss ${eleTag}4 $nL $cNodeL $Ar 800${eleTag} -doRayleigh 1


	# Masonry Element
	element zeroLength ${eleTag}0 $cNodeU $cNodeL -mat 9${eleTag} -dir $direc

}

# --------------------------------------
# PRINT SOME OUTPUT
# --------------------------------------
if {$pflag>0} {
	if {$typ=="single"} {
# 		puts [format "Created Single-Strut Infill Wall %d between: %d-%d and %d-%d" $eleTag $nI $nK $nL $nJ]
	}
	if {$typ=="double"} {
		puts [format "Created Double-Strut Infill Wall %d between: %d-%d/%d-%d and %d-%d/%d-%d" $eleTag $nI1 $nK2 $nI2 $nK1 $nL1 $nJ2 $nL2 $nJ1]
	}
	if {$typ=="triple"} {
		puts [format "Created Triple-Strut Infill Wall %d between: %d-%d/%d-%d/%d-%d and %d-%d/%d-%d/%d-%d" $eleTag $nI1 $nK3 $nI2 $nK2 $nI3 $nK1 $nL1 $nJ3 $nL2 $nJ2 $nL3 $nJ1]
	}
	if {$typ=="truss"} {
		puts [format "Created Truss Infill Wall %d between: %d-%d and %d-%d" $eleTag $nI $nK $nL $nJ]
	}
}
if {$pflag>1} {
	puts [format "bw: %.1fmm dw: %.1fmm tw: %.1fmm z:%.1fmm s:%.1fmm theta:%.4frad" $bw $dw $tw $z $s $theta]
	puts [format "sigw: %.2fMPa Ewtheta:%.2fMPa Aw:%.3fm2" $sigw $Ewtheta $Aw]
}
if {$pflag>2} {
	puts [format "sigDS1: %.2f sigDS2: %.2f sigDS4: %.2f (kPa)" $sigDS1 $sigDS2 $sigDS4]
# 	puts [format "epsDS1: %.6f epsDS2: %.6f epsDS4: %.6f" $epsDS1 $epsDS2 $epsDS4]
}
if {$pflag>3} {
	puts [format "Mechanism Parameters:"]
	puts [format "Compression in centre: %.3f MPa" $sigw1]
	puts [format "Compression at corners: %.3f MPa" $sigw2]
	puts [format "Shear sliding: %.3f MPa" $sigw3]
	puts [format "Diagonal tension: %.3f MPa" $sigw4]
}

}

# ----------------------------------------------------------------------------------------------
# ----------- Script of OpenSeesPy to Create Beam-Column Joints --------------------------------
# ----------------------------------------------------------------------------------------------
# Copyright by Gerard J. O'Reilly, 2019
# IUSS Pavia, Italy
# Created: February 2015
# Last Updated: November 2019
#
# The procedure also requires MPa units to be specified in the units file.
#
# This script contains a number of functions that will create a beam-column joint.
# This was developed for interior and exterior beam column joints which possess no
# joint reinforcement and have smooth bars with end-hooks. The full derivation of the
# the terms used in these models can be found in O'Reilly [2016]. The joint
# basically consists of a central node pair that has a rotational hinge defined based
# on the specified properties of the joint. Rigid offsets illustrated in the joint model
# diagrams are intnded to be incorporated with rigid end offsets in the element
# transformations definition for modelling efficiency.
#
# In summary, the type of information submitted to these procedures is geometry,
# material properties, principal stress in the joint limit-states and hysteretic properties.
#
# One of the input options is the joint type that is required, which for now are Exterior,
# Interior, Roof or Elastic. This distongiushes which expressions are to be used for the
# moment capacity computation. In the case of elastic joints, however, all of the inputs
# requested by the procedure aren't actually needed for any computation. This is so the
# command is left the same and the joints can be turned "on" or "off" relatively easily
# if doing some form of parameter study.

# References:
# O’Reilly, G. J., Sullivan, T. J. [2019] “Modeling Techniques for the Seismic Assessment
# of the Existing Italian RC Frame Structures,” Journal of Earthquake Engineering, Vol.
# 23, No.8, pp. 1262–1296 DOI: 10.1080/13632469.2017.1360224.

# ----------------------------------------------------------------------------------------------

proc jointModel {jtype index XYZ M col bm conc bars P H ptc gamm hyst pfile {pflag 0}} {
# jointModel $jtype $index $XYZ $M $col $bm $conc $bars $P $H $ptc $gamm $hyst $pfile {pflag 0}
# ----------------------------------------------------------------------------------------------
# -- Description of the Parameters -----
# ----------------------------------------------------------------------------------------------
# jtype	Joint type ("Exterior", "Interior", "Roof", "Elastic")
# index	Index of joint, for example - Gridline Labels (X Y Z)
# XYZ		Coords (X Y Z) in metres
# M		  Mass at node (metric tonnes)
# col		column parameters (hcX hcY) in metres
# bm		beam parameters (hbX hbY bbX bbY) in metres
# conc	Concrete props (fc Ec cv) MPa and metres
# bars	Bar dias (dbL dbV) in metres
# dbL		Long bar dia in metres
# dbV		Shear bar dia in metres
# P		  Axial load in kN
# H		  Interstorey height  in metres
# ptc		Connection params (+crack +peak +ult -crack -peak -ult) This is the kappa term defined in O'Reilly [2016]
# gamm	Connection params (+crack +peak +ult -crack -peak -ult) in radians
# hyst	Connection params
# pfile	Print file -  prints the backbone properties to a specified file
# pflag	Print flag - 1 to print details (optional)

# ----------------------------------------------------------------------------------------------
# -- Initial Variables  ----------------
# ----------------------------------------------------------------------------------------------
global MPa

set X [lindex $XYZ 0];
set Y [lindex $XYZ 1];
set Z [lindex $XYZ 2];

set hcX [lindex $col 0];
set hcY [lindex $col 1];
set Ac [expr $hcX*$hcY];
set hbX [lindex $bm 0];
set hbY [lindex $bm 1];
set bbX [lindex $bm 2];
set bbY [lindex $bm 3];
if {$hbX < $hbY } {set hb $hbY} else {set hb $hbX}; # pick larger

set fc [lindex $conc 0];
set Ec [lindex $conc 1];
set cv [lindex $conc 2];

set dbL [lindex $bars 0];
set dbV [lindex $bars 1];

# ----------------------------------------------------------------------------------------------
# -- Create the nodes  -----------------
# ----------------------------------------------------------------------------------------------
node 1${index}	$X	$Y	$Z -mass [expr 0.8*$M] [expr 0.8*$M] 0.0 0.0 0.0 0.0; #multiplied by 0.8 to account for load-mass balance
node 6${index}	$X 	$Y	$Z -mass 0.0 0.0 0.0 0.0 0.0 0.0
# ----------------------------------------------------------------------------------------------
# -- Create the axial material  --------
# ----------------------------------------------------------------------------------------------
set Kspr 	[expr 2*$Ec*$MPa*$Ac/$hb];
uniaxialMaterial Elastic 1${index} 1e15
uniaxialMaterial Elastic 2${index} $Kspr
# ----------------------------------------------------------------------------------------------
# -- Determine the connection "width" --
# ----------------------------------------------------------------------------------------------
# X DIRECTION
if {$hcY >= $bbX} {set bjX $hcY} elseif {[expr $bbX+0.5*$hcX] < $hcY} {set bjX [expr $bbX+0.5*$hcX]}
if {$hcY < $bbX}  {set bjX $bbX} elseif {[expr $hcY+0.5*$hcX] < $bbX} {set bjX [expr $hcY+0.5*$hcX]}
# Y DIRECTION
if {$hcX >= $bbY} {set bjY $hcX} elseif {[expr $bbY+0.5*$hcY] < $hcX} {set bjY [expr $bbY+0.5*$hcY]}
if {$hcX < $bbY}  {set bjY $bbY} elseif {[expr $hcX+0.5*$hcY] < $bbY} {set bjY [expr $hcX+0.5*$hcY]}
# ----------------------------------------------------------------------------------------------
# -- Create the flexural materials -----
# ----------------------------------------------------------------------------------------------
set pt [];
set MjX []; # X direction
set MjY []; # Y direction
set jX  [expr 0.9*($hbX-$cv-$dbV-$dbL/2)];
set jY  [expr 0.9*($hbY-$cv-$dbV-$dbL/2)];
for {set ii 0} {$ii <= 5} {incr ii 1} {
	lappend pt 	[expr [lindex $ptc $ii]*sqrt($fc)*$MPa];
	if {$jtype=="Interior"} {
		# Interior joint
		lappend MjX		[expr [lindex $pt $ii]*$bjX*$hcX*($H*$jX/($H-$jX))*sqrt(1+$P/($bjX*$hcX*[lindex $pt $ii]))];
		lappend MjY		[expr [lindex $pt $ii]*$bjY*$hcY*($H*$jY/($H-$jY))*sqrt(1+$P/($bjY*$hcY*[lindex $pt $ii]))];
	} elseif {$jtype=="Exterior"} {
		#  Exterior joint
		lappend MjX		[expr [lindex $pt $ii]*$bjX*$hcX*($H*$jX/($H-$jX))*($hbX/(2*$hcX)+sqrt(pow($hbX/(2*$hcX),2)+1+$P/($bjX*$hcX*[lindex $pt $ii])))];
		lappend MjY		[expr [lindex $pt $ii]*$bjY*$hcY*($H*$jY/($H-$jY))*($hbY/(2*$hcY)+sqrt(pow($hbY/(2*$hcY),2)+1+$P/($bjY*$hcY*[lindex $pt $ii])))];
	} elseif {$jtype=="Roof"} {
		#  Roof joint
		lappend MjX		[expr 2*[lindex $pt $ii]*$bjX*$hcX*$jX*($hbX/(2*$hcX)+sqrt(pow($hbX/(2*$hcX),2)+1+$P/($bjX*$hcX*[lindex $pt $ii])))];
		lappend MjY		[expr 2*[lindex $pt $ii]*$bjY*$hcY*$jY*($hbY/(2*$hcY)+sqrt(pow($hbY/(2*$hcY),2)+1+$P/($bjY*$hcY*[lindex $pt $ii])))];
	} elseif {$jtype=="Elastic"} {
		lappend MjX		[expr [lindex $pt $ii]*$bjX*$hcX*($H*$jX/($H-$jX))*sqrt(1+$P/($bjX*$hcX*[lindex $pt $ii]))];
		lappend MjY		[expr [lindex $pt $ii]*$bjY*$hcY*($H*$jY/($H-$jY))*sqrt(1+$P/($bjY*$hcY*[lindex $pt $ii]))];
	}
}
if {$jtype!="Elastic"} {
	uniaxialMaterial Hysteretic 3${index} [expr 1.0*[lindex $MjX 0]] [lindex $gamm 0] [expr 1.0*[lindex $MjX 1]] [expr 1.0*[lindex $gamm 1]] [expr 1.0*[lindex $MjX 2]] [expr 1.0*[lindex $gamm 2]] [expr -1.0*[lindex $MjX 3]] [expr -1.0*[lindex $gamm 3]] [expr -1.0*[lindex $MjX 4]] [expr -1.0*[lindex $gamm 4]] [expr -1.0*[lindex $MjX 5]] [expr -1.0*[lindex $gamm 5]] [lindex $hyst 0] [lindex $hyst 1] [lindex $hyst 2] [lindex $hyst 3] [lindex $hyst 4]
	uniaxialMaterial Hysteretic 4${index} [expr 1.0*[lindex $MjY 0]] [lindex $gamm 0] [expr 1.0*[lindex $MjY 1]] [expr 1.0*[lindex $gamm 1]] [expr 1.0*[lindex $MjY 2]] [expr 1.0*[lindex $gamm 2]] [expr -1.0*[lindex $MjY 3]] [expr -1.0*[lindex $gamm 3]] [expr -1.0*[lindex $MjY 4]] [expr -1.0*[lindex $gamm 4]] [expr -1.0*[lindex $MjY 5]] [expr -1.0*[lindex $gamm 5]] [lindex $hyst 0] [lindex $hyst 1] [lindex $hyst 2] [lindex $hyst 3] [lindex $hyst 4]
} elseif {$jtype=="Elastic"} {
	uniaxialMaterial Elastic 3${index} [expr [lindex $MjX 0]/[lindex $gamm 0]]
	uniaxialMaterial Elastic 4${index} [expr [lindex $MjY 0]/[lindex $gamm 0]]
}

# ----------------------------------------------------------------------------------------------
# -- Implement the MaxMin Limits  -----------
# ----------------------------------------------------------------------------------------------
set gamm_max 0.100; # Use a higher limit for now, needs to be updated later
uniaxialMaterial MinMax 5${index} 3${index} -min -$gamm_max -max $gamm_max
uniaxialMaterial MinMax 6${index} 4${index} -min -$gamm_max -max $gamm_max

# ----------------------------------------------------------------------------------------------
# -- Create the ZL elements  -----------
# ----------------------------------------------------------------------------------------------
set rigM 	1${index}
set axM 	2${index}
set flXM	5${index}
set flYM	6${index}
set ET	9${index}
element zeroLength $ET 1${index} 6${index} -mat $rigM  $rigM  $axM  $flYM $flXM $rigM  -dir 1 2 3 4 5 6 -doRayleigh 1
# ----------------------------------------------------------------------------------------------
# -- Create the Print Output  ----------
# ----------------------------------------------------------------------------------------------
if {$pflag==1} {
	puts [format "Created connection at grid (XYZ): %d" ${index}]
	puts [format "Coords: %.3f %.3f %.3f m" $X $Y $Z]
	puts [format "Element: %d"  17${index}]
	puts [format "Mass: %.1f tonnes" $M]
	puts [format "P: %.1f kN" $P]
	puts [format "Concrete: fc: %.1fMPa Ec: %.1fMPa" $fc $Ec]
	puts [format "Joint: bjX: %.3fm bjY: %.3fm" $bjX $bjY]
	puts [format "Kspr: %.1f kN/m" $Kspr]
	puts [format "MjX: %.2f %.2f %.2f %.2f %.2f %.2f kNm" [lindex $MjX 0] [lindex $MjX 1] [lindex $MjX 2] -[lindex $MjX 3] -[lindex $MjX 4] -[lindex $MjX 5]]
	puts [format "MjY: %.2f %.2f %.2f %.2f %.2f %.2f kNm" [lindex $MjY 0] [lindex $MjY 1] [lindex $MjY 2] -[lindex $MjY 3] -[lindex $MjY 4] -[lindex $MjY 5]]
	puts [format "gamma: %.4f %.4f %.4f rad" [lindex $gamm 0] [lindex $gamm 1] [lindex $gamm 2]]
}

puts $pfile [format "Element %d MjX:%.2f %.2f %.2f %.2f %.2f %.2f MjY: %.2f %.2f %.2f %.2f %.2f %.2f gamma: %.4f %.4f %.4f" $ET [lindex $MjY 0] [lindex $MjY 1] [lindex $MjY 2] -[lindex $MjY 3] -[lindex $MjY 4] -[lindex $MjY 5] [lindex $MjX 0] [lindex $MjX 1] [lindex $MjX 2] -[lindex $MjX 3] -[lindex $MjX 4] -[lindex $MjY 5] [lindex $gamm 0] [lindex $gamm 1] [lindex $gamm 2]];

}

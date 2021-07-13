# -----------------------------------------------------------------------------------------
# -- Script to Perform Moment-Curvature Analysis to Extract the Yield Moment 				 ------
# -----------------------------------------------------------------------------------------
proc MomentCurvature {index h b cv dbL dbV fc Ec P fyL Es rho1 rho2 rho3 {pflag 0}} {
# --------------------------------------------------------
# -- Set some stuff that makes My available above   ------
# --------------------------------------------------------
upvar Myp${index} Mp
upvar Myn${index} Mn
# --------------------------------------
# -- Compute Some General Stuff   ------
# --------------------------------------
set n_c		[expr 0.8+$fc/18];					# n term for concrete
set e_c		[expr 1.0*$fc/$Ec*($n_c/($n_c-1))]; 	# epsilon_c' for concrete
set e_s		[expr $fyL/$Es];					# Steel yield strain

# --------------------------------------
# -- Compute the Yield Curvature -------
# --------------------------------------
set phiY [expr 2.1*$fyL/$Es/$h]; # Yield Curvature (rad/m)

# --------------------------------------
# -- Compute the Yield Moment ----------
# --------------------------------------
# Do a Moment Curvature Analysis
set d1 		[expr $cv+$dbV+$dbL/2];		# Depth to Top Bars (m)
set d2 		[expr $h/2];				# Depth to Middle Bars (m)
set d3 		[expr $h-$cv-$dbV-$dbL/2];	# Depth to Bottom Bars (m)

# Positive Bending
set c 		[expr $h/2]; 				# initial trial of NA depth (m)
set count 	0;
set err		0.5;
while {$err > 0.001 && $count < 1000 } {
	if {$pflag>=2} {
		puts "Iteration $count c:$c  Error: $err kN";
	}
	# Compute the strains at each level
	set e_s1	[expr ($c-$d1)*$phiY]; 	# Strain in top steel (in strains)
	set e_s2	[expr ($d2-$c)*$phiY]; 	# Strain in middle steel
	set e_s3	[expr ($d3-$c)*$phiY]; 	# Strain in middle steel
	set e_top	[expr $c*$phiY];		# Strain in top of section

	# Compute the steel stuff
	if {$e_s1 < $e_s} {set f_s1 [expr $e_s1*$Es]} else {set f_s1 $fyL}; # 	in MPa
	if {$e_s2 < $e_s} {set f_s2 [expr $e_s2*$Es]} else {set f_s2 $fyL}; # 	in MPa
	if {$e_s3 < $e_s} {set f_s3 [expr $e_s3*$Es]} else {set f_s3 $fyL}; # 	in MPa

	set Fs1		[expr $f_s1*$rho1*$b*$d3*1000]; # (kN)
	set Fs2		[expr $f_s2*$rho2*$b*$d3*1000]; # (kN)
	set Fs3		[expr $f_s3*$rho3*$b*$d3*1000]; # (kN)

	# Compute concrete stuff
	set a1b1	[expr ($e_top/$e_c)-pow($e_top/$e_c,2)/3];		# alpha1beta1 term
	set b1		[expr (4-($e_top/$e_c))/(6-2*($e_top/$e_c))];	# beta1
	set Fc 		[expr $a1b1*$c*$fc*$b*1000];					# Concrete block force (kN)

	# Section force
	set Psec 	[expr $P+$Fs2+$Fs3-$Fc-$Fs1];					# Section Force (kN)

	# Adjust NA depth to balance section forces
	if {$Psec < 0} {
		set c0 $c
		set c [expr $c-0.001];
	} elseif {$Psec > 0} {
		set c0 $c
		set c [expr $c+0.001];
	}
	set err [expr abs($Psec)];

	if {$err < 5} {
	break
	}
	incr count 1
}
# Compute the moment
set Mp [expr $P*(0.5*$h-$c)+$Fs1*($c-$d1)+$Fs3*($d3-$c)+$Fs2*($d2-$c)+$Fc*$c*(1-$b1/2)];


# Negative Bending
set c 		[expr $h/2]; 				# initial trial of NA depth (m)
set count 	0;
set err		0.5;
while {$err > 0.001 && $count < 1000 } {
	if {$pflag>=2} {
		puts "Iteration $count c:$c  Error: $err kN";
	}
	# Compute the strains at each level
	set e_s1	[expr ($c-$d1)*$phiY]; 	# Strain in top steel (in strains)
	set e_s2	[expr ($d2-$c)*$phiY]; 	# Strain in middle steel
	set e_s3	[expr ($d3-$c)*$phiY]; 	# Strain in middle steel
	set e_top	[expr $c*$phiY];		# Strain in top of section

	# Compute the steel stuff
	if {$e_s1 < $e_s} {set f_s1 [expr $e_s1*$Es]} else {set f_s1 $fyL}; # 	in MPa
	if {$e_s2 < $e_s} {set f_s2 [expr $e_s2*$Es]} else {set f_s2 $fyL}; # 	in MPa
	if {$e_s3 < $e_s} {set f_s3 [expr $e_s3*$Es]} else {set f_s3 $fyL}; # 	in MPa

	set Fs1		[expr $f_s1*$rho3*$b*$d3*1000]; # (kN)
	set Fs2		[expr $f_s2*$rho2*$b*$d3*1000]; # (kN)
	set Fs3		[expr $f_s3*$rho1*$b*$d3*1000]; # (kN)

	# Compute concrete stuff
	set a1b1	[expr ($e_top/$e_c)-pow($e_top/$e_c,2)/3];		# alpha1beta1 term
	set b1		[expr (4-($e_top/$e_c))/(6-2*($e_top/$e_c))];	# beta1
	set Fc 		[expr $a1b1*$c*$fc*$b*1000];					# Concrete block force (kN)

	# Section force
	set Psec 	[expr $P+$Fs2+$Fs3-$Fc-$Fs1];					# Section Force (kN)

	# Adjust NA depth to balance section forces
	if {$Psec < 0} {
		set c0 $c
		set c [expr $c-0.001];
	} elseif {$Psec > 0} {
		set c0 $c
		set c [expr $c+0.001];
	}
	set err [expr abs($Psec)];

	if {$err < 5} {
	break
	}
	incr count 1
}
# Compute the moment
set Mn [expr $P*(0.5*$h-$c)+$Fs1*($c-$d1)+$Fs3*($d3-$c)+$Fs2*($d2-$c)+$Fc*$c*(1-$b1/2)];

# set Myp${index} $Mp
# set Myn${index} $Mn

if {$pflag>=1} {
	puts "Myp${index}: $Mp kNm"
	puts "Myn${index}: $Mn kNm"
}

}

# -----------------------------------------------------------------------------------------
# -- Script to Aggregate Pinching4 Material Model Parameters with Ease 							 ------
# -----------------------------------------------------------------------------------------
# Create a function that creates a Pinching4 material in a single line
proc procUniaxialPinching {materialTag pEnvelopeStress nEnvelopeStress pEnvelopeStrain nEnvelopeStrain rDisp rForce uForce gammaK gammaD gammaF gammaE damage} {
# Function to create a pinching4 material model simply
uniaxialMaterial Pinching4 $materialTag [lindex $pEnvelopeStress 0] [lindex $pEnvelopeStrain 0] [lindex $pEnvelopeStress 1] [lindex $pEnvelopeStrain 1] [lindex $pEnvelopeStress 2] [lindex $pEnvelopeStrain 2] [lindex $pEnvelopeStress 3] [lindex $pEnvelopeStrain 3] [lindex $nEnvelopeStress 0] [lindex $nEnvelopeStrain 0] [lindex $nEnvelopeStress 1] [lindex $nEnvelopeStrain 1] [lindex $nEnvelopeStress 2] [lindex $nEnvelopeStrain 2] [lindex $nEnvelopeStress 3] [lindex $nEnvelopeStrain 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage
}

# -----------------------------------------------------------------------------------------
# -- Script to Create a Lumped Plasticity Element for RC Columns w/ plain bars ------
# -----------------------------------------------------------------------------------------
# Al Mouayed Bellah Nafeh
# Affiliation: IUSS Pavia (Ph.D Student)
# Created: April 2021
# Last Updated:
#
# Description:
# This script contains is a function that create a 3D beam column element with lumped plasticity
# calibrated based on the recommendations of Haselton.
# The model is calibrated based on the experimental campaign conducted by Domenico et al and
# summarised in [1]
#
# In summary, the details that need to be submitted to the procedure are basic parameters such as column
# dimensions and material properties, along with details about the reinforcement. Currently, the model accepts
# the input of reinforcement content in terms of percentages, where three levels of reinforcement are considered:
# Top level, middle level and bottom level. This applies for both axes of bending, which are termed the local y and
# local y axes. This means that the flexural capacity of the section can be specified as being different in either
# direction. In addition to the flexural behaviour, an uncoupled shear hinge has been aggregated into the element. This means
# that a shear failure in the element can also be accounted for by introduction of such an hinge. The parameters used
# to determine the shear behaviour are outlined in O'Reilly et al. [2] also. In short, the shear capacity of the section
# is determined using the USCD shear model, as opposed to the Modified Compression Field Theory, which is noted in
# O'Reilly et al. [2] to be still not well understood under reverse cyclic loading conditions.
#
# The two types of model that are the inclusion of a shear behaviour or not, through the two commands specified below.
# This means that in cases where the shear behaviour of the element is not considered to be an issue, it can be
# omitted to save on computational time.

# [1] Di Domenico, M., Ricco, P., Verderame, G. Empirical calibration of hysteretic parameters for modelling the seismic response of
# reinforced concrete columns with plain bars. Engineering Structures 2021. DOI: https://doi.org/10.1016/j.engstruct.2021.112120
# [2] O’Reilly GJ, Sullivan TJ. Modelling Techniques for the Seismic Assessment of Existing Italian RC Frame Structures.
# Journal of Earthquake Engineering 2017. DOI: 10.1080/13632469.2017.1360224.
#
proc rcBC_nonDuctCol {ST ET GT iNode jNode fyL fyV Es fc Ec b h s cv dbL dbV P Ls rho_shr rho_top1zz rho_mid1zz rho_bot1zz rho_top2zz rho_mid2zz rho_bot2zz rho_top1yy rho_mid1yy rho_bot1yy rho_top2yy rho_mid2yy rho_bot2yy pfile {pflag 1}} {
global MPa
global mm
# --------------------------------------
# -- Description of the Parameters -----
# --------------------------------------
# ST			    # Shear Hinge Tag (1 for shear hinge, 0 for none)
# ET			    # Element Tag
# GT			    # Geometric Transf Tag
# iNode		    # i Node
# jNode		    # j Node
# fyL 		    # Steel yield strength long. bars (MPa)
# fyV 		    # Steel yield strength shear. bars (MPa)
# Es 			    # Steel elastic modulus (MPa)
# fc			    # Concrete compressive strength (MPa)
# Ec			    # Concrete elastic modulus (MPa)
# b				    # Section width (m)
# h				    # Section height (m)
# s				    # Shear rft spacing
# cv			    # Cover (m)
# dbL			    # Long. bar diameter (m)
# dbV			    # Shear bar diameter (m)
# P				    # Axial force (kN) (+ Compression, - Tension)
# Ls			    # Shear span
# lo          # Longitudinal reinforcement splice length (in m)
# Lba         # Longitudinal rebars anchorage length (in m)
# wsw         # Mechanical reinforcement ratio
# rho_shr		  # Ratio of shear rft =Ash/bs
# rho_top1zz	# Ratio of top rft = Astop/bd (END 1 about zz axis)
# rho_mid1zz	# Ratio of web rft =Asmid/bd (END 1 about zz axis)
# rho_bot1zz	# Ratio of bottom rft = Asbot/bd (END 1 about zz axis)
# rho_top2zz	# Ratio of top rft = Astop/bd (END 2 about zz axis)
# rho_mid2zz	# Ratio of web rft =Asmid/bd (END 2 about zz axis)
# rho_bot2zz	# Ratio of bottom rft = Asbot/bd (END 2 about zz axis)
# rho_top1yy	# Ratio of top rft = Astop/bd (END 1 about yy axis)
# rho_mid1yy	# Ratio of web rft =Asmid/bd (END 1 about yy axis)
# rho_bot1yy	# Ratio of bottom rft = Asbot/bd (END 1 about yy axis)
# rho_top2yy	# Ratio of top rft = Astop/bd (END 2 about yy axis)
# rho_mid2yy	# Ratio of web rft =Asmid/bd (END 2 about yy axis)
# rho_bot2yy	# Ratio of bottom rft = Asbot/bd (END 2 about yy axis)
# pflag		# Print flag (optional - 1: details about hinge are printed)
# pfile		Print file -  prints the backbone properties to a specified file

# The parameters can be introduced as variables in the function.
set lo 0.0;
set Lba 0.0;
# --------------------------------------
# -- Compute Some General Stuff   ------
# --------------------------------------
set fc 		[expr $fc*1.0]; 			# Change to real number incase it is integer
set nu 		[expr $P/($b*$h*$fc*$MPa)];	# Normalised Axial Load Ratio (-)
set Ag    [expr $b*$h];
set dyy		[expr $h-$dbV-$cv-$dbL/2];	# Depth to bottom bars zz (m)
set dzz		[expr $b-$dbV-$cv-$dbL/2];	# Depth to bottom bars zz (m)
set d1		[expr $dbV-$cv-$dbL/2];	    # Depth to top bars zz (m)
set Izz 	[expr $b*pow($h,3)/12]; 	# I about local zz axis (mm4)
set Iyy 	[expr $h*pow($b,3)/12]; 	# I about local yy axis (mm4)
set EA		[expr $Ec*$MPa*$Ag];		# EA (kN)
set Gc		[expr 0.4*$Ec*$MPa];		# Shear Modulus of Concrete (kN/m2)
set Kshear	[expr $Gc*$Ag];				# Shear Stiffness of Section
set n_c		[expr 0.8+$fc/18];					# n term for concrete
set e_c		[expr 1.0*$fc/$Ec*($n_c/($n_c-1))]; 	# epsilon_c' for concrete
set e_s		[expr $fyL/$Es];					# Steel yield strain
set wswzz   [expr (($rho_top1zz+$rho_mid1zz+$rho_bot1zz)*$b*$dzz*$fyL)/($b*$h*$fc)]
set wswyy   [expr (($rho_top1yy+$rho_mid1yy+$rho_bot1yy)*$b*$dyy*$fyL)/($b*$h*$fc)]

# --------------------------------------
# -- Compute Member Length   -----------
# --------------------------------------
set x1 [nodeCoord $iNode 1];
set y1 [nodeCoord $iNode 2];
set z1 [nodeCoord $iNode 3];
set x2 [nodeCoord $jNode 1];
set y2 [nodeCoord $jNode 2];
set z2 [nodeCoord $jNode 3];
set L [expr sqrt(pow($x2-$x1,2)+pow($y2-$y1,2)+pow($z2-$z1,2))];

# --------------------------------------
# -- Compute the Plastic Hinge Length --
# --------------------------------------
set Lp 	[expr 0.08*$Ls+0.022*$fyL*$dbL]; # Priestley + Park (1992)

# --------------------------------------
# -- Compute the Yield Moment ----------
# --------------------------------------

# Moment-Curvature Analysis for Yield Moment
MomentCurvature 1zz $h $b $cv $dbL $dbV $fc $Ec $P $fyL $Es $rho_top1zz $rho_mid1zz $rho_bot1zz
MomentCurvature 2zz $h $b $cv $dbL $dbV $fc $Ec $P $fyL $Es $rho_top2zz $rho_mid2zz $rho_bot2zz
MomentCurvature 1yy $b $h $cv $dbL $dbV $fc $Ec $P $fyL $Es $rho_top1yy $rho_mid1yy $rho_bot1yy
MomentCurvature 2yy $b $h $cv $dbL $dbV $fc $Ec $P $fyL $Es $rho_top2yy $rho_mid2yy $rho_bot2yy

set EIratiozz   [expr 0.074*pow(8.1,$nu)*(1+0.30*$Ls/$dzz)]
set EIzz	[expr $Ec*$MPa*$Izz];		# EI about zz (kNm2)
set EIeffzz [expr $EIratiozz*$EIzz]
set EIyzz [expr 3*$EIeffzz*$Ls];  # 3EI_eff/Ls

set EIratioyy   [expr 0.074*pow(8.1,$nu)*(1+0.30*$Ls/$dyy)]
set EIyy	[expr $Ec*$MPa*$Iyy];		# EI about yy (kNm2)
set EIeffyy [expr $EIratioyy*$EIyy]
set EIyyy [expr 3*$EIeffyy*$Ls];  # 3EI_eff/Ls

# --------------------------------------
# -- Compute the Yield Curvature -------
# --------------------------------------
set phiYzz [expr 2.1*$fyL/$Es/$h]; # Yield Curvature (rad/m)
set phiYyy [expr 2.1*$fyL/$Es/$b]; # Yield Curvature (rad/m)
set Kizz		[expr $Myp1zz/$phiYzz];
set Kiyy		[expr $Myp1yy/$phiYyy];
set EIrzz 		[expr $Kizz/$EIzz];		# % of gross EI to get cracked section EI
set EIryy 		[expr $Kiyy/$EIyy];		# % of gross EI to get cracked section EI
set EIzze		[expr $EIrzz*$EIzz];	# Cracked EI about zz
set EIyye		[expr $EIryy*$EIyy];	# Cracked EI about yy
set Izze		[expr $EIrzz*$Izz];		# Cracked I about zz
set Iyye		[expr $EIryy*$Iyy];		# Cracked I about yy

# Yield Rotation
set thetaY1zz [expr $Myp1zz/$EIyzz];
set thetaY2zz [expr $Myp2zz/$EIyzz];
set thetaY1yy [expr $Myp1yy/$EIyyy];
set thetaY2yy [expr $Myp2yy/$EIyyy];

# ---------------------------------------------
# -- Compute the Capping Moment Mmax = 1.14*My
# ---------------------------------------------
set Mcp1zz 		[expr 1.14*$Myp1zz];
set Mcn1zz 		[expr 1.14*$Myn1zz];
set Mcp2zz 		[expr 1.14*$Myp2zz];
set Mcn2zz 		[expr 1.14*$Myn2zz];

set Mcp1yy 		[expr 1.14*$Myp1yy];
set Mcn1yy 		[expr 1.14*$Myn1yy];
set Mcp2yy 		[expr 1.14*$Myp2yy];
set Mcn2yy 		[expr 1.14*$Myn2yy];

# with fixed-end rotation coefficient (Equation 2)
set thetaPlmax1zz [expr 0.0026*pow(0.106,$nu)*(1+1.20*$Lba*$dbL/($dzz*sqrt($fc)))*(0.49+0.51*min($lo/$dbL,50)/50)];
set thetaPlmax2zz [expr 0.0026*pow(0.106,$nu)*(1+1.20*$Lba*$dbL/($dzz*sqrt($fc)))*(0.49+0.51*min($lo/$dbL,50)/50)];
set thetaPlmax1yy [expr 0.0026*pow(0.106,$nu)*(1+1.20*$Lba*$dbL/($dyy*sqrt($fc)))*(0.49+0.51*min($lo/$dbL,50)/50)];
set thetaPlmax2yy [expr 0.0026*pow(0.106,$nu)*(1+1.20*$Lba*$dbL/($dyy*sqrt($fc)))*(0.49+0.51*min($lo/$dbL,50)/50)];

# without fixed-end rotation coefficient (Equation 3)
set thetaPlmax1zz [expr 0.0062*pow(0.17,$nu)*(1+0.28*$Ls/$dzz)*(0.49+0.51*min($lo/$dbL,50)/50)];
set thetaPlmax2zz [expr 0.0062*pow(0.17,$nu)*(1+0.28*$Ls/$dzz)*(0.49+0.51*min($lo/$dbL,50)/50)];
set thetaPlmax1yy [expr 0.0062*pow(0.17,$nu)*(1+0.28*$Ls/$dyy)*(0.49+0.51*min($lo/$dbL,50)/50)];
set thetaPlmax2yy [expr 0.0062*pow(0.17,$nu)*(1+0.28*$Ls/$dyy)*(0.49+0.51*min($lo/$dbL,50)/50)];

# ----------------------------------------------
# -- Compute the Ultimate Moment Mult = 0.80*My
# ----------------------------------------------
set Mup1zz [expr 0.8*$Mcp1zz];
set Mun1zz [expr 0.8*$Mcn1zz];
set Mup2zz [expr 0.8*$Mcp2zz];
set Mun2zz [expr 0.8*$Mcn2zz];

set Mup1yy [expr 0.8*$Mcp1yy];
set Mun1yy [expr 0.8*$Mcn1yy];
set Mup2yy [expr 0.8*$Mcp2yy];
set Mun2yy [expr 0.8*$Mcn2yy];

# with fixed-end rotation coefficient (Equation 4)
set thetaPcult1zz [expr 0.033*pow(0.0013,$nu)*pow($wswzz,0.51)*(pow($Lba*$dbL/$dzz/sqrt($fc),1.61))];
set thetaPcult2zz [expr 0.033*pow(0.0013,$nu)*pow($wswzz,0.51)*(pow($Lba*$dbL/$dzz/sqrt($fc),1.61))];
set thetaPcult1yy [expr 0.033*pow(0.0013,$nu)*pow($wswyy,0.51)*(pow($Lba*$dbL/$dyy/sqrt($fc),1.61))];
set thetaPcult2yy [expr 0.033*pow(0.0013,$nu)*pow($wswyy,0.51)*(pow($Lba*$dbL/$dyy/sqrt($fc),1.61))];

# without fixed-end rotation coefficient (Equation 5)
set thetaPcult1zz [expr 0.0082*pow(0.0034,$nu)*pow($wswzz,0.63)*(1+10.4*$Ls/$dzz)];
set thetaPcult2zz [expr 0.0082*pow(0.0034,$nu)*pow($wswzz,0.63)*(1+10.4*$Ls/$dzz)];
set thetaPcult1yy [expr 0.0082*pow(0.0034,$nu)*pow($wswyy,0.63)*(1+10.4*$Ls/$dyy)];
set thetaPcult2yy [expr 0.0082*pow(0.0034,$nu)*pow($wswyy,0.63)*(1+10.4*$Ls/$dyy)];

# ----------------------------------------------
# -- Compute the Post-Ultimate Rotation
# ----------------------------------------------
# with fixed-end rotation coefficient (Equation 6)
set thetaPuzero1zz [expr min(0.0022*pow(0.0050,$nu)*pow(227,($rho_shr*100))*(1+3.74*$Lba*$dbL/$dzz/sqrt($fc)),0.11)];
set thetaPuzero2zz [expr min(0.0022*pow(0.0050,$nu)*pow(227,($rho_shr*100))*(1+3.74*$Lba*$dbL/$dzz/sqrt($fc)),0.11)];
set thetaPuzero1yy [expr min(0.0022*pow(0.0050,$nu)*pow(227,($rho_shr*100))*(1+3.74*$Lba*$dbL/$dyy/sqrt($fc)),0.11)];
set thetaPuzero2yy [expr min(0.0022*pow(0.0050,$nu)*pow(227,($rho_shr*100))*(1+3.74*$Lba*$dbL/$dyy/sqrt($fc)),0.11)];

# without fixed-end rotation coefficient (Equation 7)
set thetaPuzero1zz [expr min(0.031*pow(0.015,$nu)*pow(243,($rho_shr*100)),0.11)];
set thetaPuzero2zz [expr min(0.031*pow(0.015,$nu)*pow(243,($rho_shr*100)),0.11)];
set thetaPuzero1yy [expr min(0.031*pow(0.015,$nu)*pow(243,($rho_shr*100)),0.11)];
set thetaPuzero2yy [expr min(0.031*pow(0.015,$nu)*pow(243,($rho_shr*100)),0.11)];

# Check condition on Equation 8
if {$thetaPuzero1zz > [expr 4*$thetaPcult1zz]} {
  set thetaPuzero1zz [expr 4*$thetaPcult1zz]
}
if {$thetaPuzero2zz > [expr 4*$thetaPcult2zz]} {
  set thetaPuzero2zz [expr 4*$thetaPcult2zz]
}
if {$thetaPuzero1yy > [expr 4*$thetaPcult1yy]} {
  set thetaPuzero1yy [expr 4*$thetaPcult1yy]
}
if {$thetaPuzero2yy > [expr 4*$thetaPcult2yy]} {
  set thetaPuzero2yy [expr 4*$thetaPcult2yy]
}

# ----------------------------------------------
# -- Compute the Softening Stiffness K0
# ----------------------------------------------
set K01zz [expr max(29*pow(407,$nu)*pow($rho_shr*100,-1.65), 700)];
set K02zz [expr max(29*pow(407,$nu)*pow($rho_shr*100,-1.65), 700)];
set K01yy [expr max(29*pow(407,$nu)*pow($rho_shr*100,-1.65), 700)];
set K02yy [expr max(29*pow(407,$nu)*pow($rho_shr*100,-1.65), 700)];

if {$K01zz < [expr 0.80*$Mcp1zz/$thetaPuzero1zz]} {
  set K01zz [expr 0.80*$Mcp1zz/$thetaPuzero1zz]
}

if {$K02zz < [expr 0.80*$Mcp2zz/$thetaPuzero2zz]} {
  set K01zz [expr 0.80*$Mcp2zz/$thetaPuzero2zz]
}

if {$K01yy < [expr 0.80*$Mcp1yy/$thetaPuzero1yy]} {
  set K01zz [expr 0.80*$Mcp1yy/$thetaPuzero1yy]
}

if {$K02yy < [expr 0.80*$Mcp2yy/$thetaPuzero2yy]} {
  set K01zz [expr 0.80*$Mcp2yy/$thetaPuzero2yy]
}

# ----------------------------------------------
# -- Compute the Intersection Point
# ----------------------------------------------
# Equation 11
set thetaInt1zz [expr (($K01zz*($thetaY1zz+$thetaPlmax1zz+$thetaPcult1zz+$thetaPuzero1zz)) - (1+(0.20*($thetaY1zz+$thetaPlmax1zz)/$thetaPcult1zz))*$Mcp1zz)/($K01zz-0.20*($Mcp1zz/$thetaPcult1zz))];
set thetaInt2zz [expr (($K02zz*($thetaY2zz+$thetaPlmax2zz+$thetaPcult2zz+$thetaPuzero2zz)) - (1+(0.20*($thetaY2zz+$thetaPlmax2zz)/$thetaPcult2zz))*$Mcp2zz)/($K02zz-0.20*($Mcp1zz/$thetaPcult2zz))];
set thetaInt1yy [expr (($K01yy*($thetaY1yy+$thetaPlmax1yy+$thetaPcult1yy+$thetaPuzero1yy)) - (1+(0.20*($thetaY1yy+$thetaPlmax1yy)/$thetaPcult1yy))*$Mcp1yy)/($K01yy-0.20*($Mcp1yy/$thetaPcult1yy))];
set thetaInt2yy [expr (($K02yy*($thetaY2yy+$thetaPlmax2yy+$thetaPcult2yy+$thetaPuzero2yy)) - (1+(0.20*($thetaY2yy+$thetaPlmax2yy)/$thetaPcult2yy))*$Mcp2yy)/($K02yy-0.20*($Mcp1yy/$thetaPcult2yy))];

# Equation 12
set Mintp1zz [expr 1-0.20*($thetaInt1zz-($thetaY1zz+$thetaPlmax1zz)/$thetaPcult1zz*$Mcp1zz)];
set Mintp2zz [expr 1-0.20*($thetaInt2zz-($thetaY2zz+$thetaPlmax2zz)/$thetaPcult2zz*$Mcp2zz)];
set Mintp1yy [expr 1-0.20*($thetaInt1yy-($thetaY1yy+$thetaPlmax1yy)/$thetaPcult1yy*$Mcp1yy)];
set Mintp2yy [expr 1-0.20*($thetaInt2yy-($thetaY1yy+$thetaPlmax2yy)/$thetaPcult2yy*$Mcp2yy)];

# --------------------------------------
# -- Compute Shear Response ------------
# --------------------------------------
if {$ST>0} {
	# This is as per Mergos & Kappos [2008,2012] and Zimos et al. [2015]
	# Elastic Reponse
	set Gc [expr 0.42*$Ec]; # Shear Modulus of Concrete (in MPa)
	set GA0 [expr 0.8*$b*$h*$Gc*$MPa]; # (in kN)
	set ft [expr sqrt($fc)/3*$MPa]; # Tensile Strength fo concrete from Collins and Mitchell (in kN/m2)
	set V_cryy [expr $ft*$h/$Ls*sqrt(1+$P/$ft/$b/$h)*0.8*$b*$h]; # Cracking Shear as per Sezen & Moehle [2004] (in kN)
	set V_crzz [expr $ft*$b/$Ls*sqrt(1+$P/$ft/$h/$b)*0.8*$h*$b]; # Cracking Shear as per Sezen & Moehle [2004] (in kN)
	set gamm_cryy [expr $V_cryy/$GA0];
	set gamm_crzz [expr $V_crzz/$GA0];

	# Cracked Response
	set V_cyy [expr 0.29*sqrt($fc)*0.8*$b*$h*1e3+$P*tan($h/2/$Ls)+$rho_shr*$b*$fyV*$MPa*($dyy-$d1)]; #  Shear Capacity from Priestley et al [1993] (Assume k=0.29, theta=45°) (in kN)
	set V_czz [expr 0.29*sqrt($fc)*0.8*$h*$b*1e3+$P*tan($b/2/$Ls)+$rho_shr*$h*$fyV*$MPa*($dzz-$d1)]; #  Shear Capacity from Priestley et al [1993] (Assume k=0.29, theta=45°) (in kN)
	set GA1yy [expr ($Es*$MPa*$b*($dyy-$d1)*$rho_shr)/(1+4*$Es/$Ec*$rho_shr)]; # Cracked Stiffness from Mergos and Kappos with theta assumed to be 45° (in kN)
	set GA1zz [expr ($Es*$MPa*$h*($dzz-$d1)*$rho_shr)/(1+4*$Es/$Ec*$rho_shr)]; # Cracked Stiffness from Mergos and Kappos with theta assumed to be 45° (in kN)
	if {[expr $Ls/$h]<=2.5} {set paramV1yy [expr $Ls/$h]} else {set paramV1yy 2.5}
	if {[expr $Ls/$b]<=2.5} {set paramV1zz [expr $Ls/$b]} else {set paramV1zz 2.5}
	set gamm_pkyy [expr ($gamm_cryy+($V_cyy-$V_cryy)/$GA1yy)*(1-1.07*$nu)*(5.37-1.59*$paramV1yy)]; # Cracking strain with correction factors from Mergos and Kappos
	set gamm_pkzz [expr ($gamm_crzz+($V_czz-$V_crzz)/$GA1zz)*(1-1.07*$nu)*(5.37-1.59*$paramV1zz)]; # Cracking strain with correction factors from Mergos and Kappos
	set V_ccyy [expr $V_cyy*0.9]; # Opensees gets knarky with 0 stiffness
	set V_cczz [expr $V_czz*0.9]; # Opensees gets knarky with 0 stiffness

	# Failure
	if {$nu < 0.4} {set paramV2 $nu} else {set paramV2 0.4}
	set omega_k [expr $rho_shr*$fyV/$fc];
	if {$omega_k <=0.08} {set paramV3 $omega_k} else {set paramV3 0.08}
	set gamm_u1yy [expr (1-2.5*$paramV2)*pow($paramV1yy,2)*(0.31+17.8*$paramV3)*$gamm_pkyy];
	set gamm_u1zz [expr (1-2.5*$paramV2)*pow($paramV1zz,2)*(0.31+17.8*$paramV3)*$gamm_pkzz];
	if {$gamm_u1yy <=$gamm_pkyy} {set gamm_uyy $gamm_pkyy; set V_ccyy $V_cyy;} else {set gamm_uyy $gamm_u1yy}
	if {$gamm_u1zz <=$gamm_pkzz} {set gamm_uzz $gamm_pkzz; set V_cczz $V_czz;} else {set gamm_uzz $gamm_u1zz}
	#
	# Descending Branch
	set nu_lyy [expr $P*1e3/($rho_top1zz+$rho_bot1zz)/$fyL/($b/$mm)/($dyy/$mm)];
	set nu_lzz [expr $P*1e3/($rho_top1yy+$rho_bot1yy)/$fyL/($h/$mm)/($dzz/$mm)];
	set tau_aveyy [expr $V_cyy/$b/$dyy/1e3];
	set tau_avezz [expr $V_czz/$h/$dzz/1e3];
	set A_confpcyy [expr ($dyy-$d1)*($b-2*($cv+$dbV+$dbL))/$b/$h];
	set A_confpczz [expr ($dzz-$d1)*($h-2*($cv+$dbV+$dbL))/$h/$b];
	set gamm_tppyy [expr 0.65*pow(($rho_top1zz+$rho_bot1zz)/$A_confpcyy,1.2)*sqrt($rho_shr*$fyV/$nu_lyy/($s/$dyy)/($tau_aveyy/sqrt($fc)))];
	set gamm_tppzz [expr 0.65*pow(($rho_top1yy+$rho_bot1yy)/$A_confpczz,1.2)*sqrt($rho_shr*$fyV/$nu_lzz/($s/$dzz)/($tau_avezz/sqrt($fc)))];
	set Sppyy [expr 7.36+0.28*sqrt($nu+0.02)/($rho_shr+0.0011)/(($rho_top1zz+$rho_bot1zz)*$fyL*$dbL/$A_confpcyy/$dyy+0.06)];
	set Sppzz [expr 7.36+0.28*sqrt($nu+0.02)/($rho_shr+0.0011)/(($rho_top1yy+$rho_bot1yy)*$fyL*$dbL/$A_confpczz/$dzz+0.06)];
	set gamm_myy [expr $gamm_uyy+$gamm_tppyy];
	set gamm_mzz [expr $gamm_uzz+$gamm_tppzz];
	set V_resyy [expr $V_cyy*(1-$Sppyy*$gamm_tppyy)];
	set V_reszz [expr $V_czz*(1-$Sppzz*$gamm_tppzz)];
	if {$V_resyy <=0} {set V_resyy [expr 0.1*$V_cyy]; set gamm_tppyy [expr 1/$Sppyy]; set gamm_myy [expr $gamm_uyy+$gamm_tppyy];}; # Put 10% residual strength since OpenSees can't handle zero strength (Get error about not being able to invert section flexibility)
	if {$V_reszz <=0} {set V_reszz [expr 0.1*$V_czz]; set gamm_tppzz [expr 1/$Sppzz]; set gamm_mzz [expr $gamm_uzz+$gamm_tppzz];}
}

# --------------------------------------
# -- Print Some Output  ----------------
# --------------------------------------
if {$pflag==1} {
	puts "Element $ET between nodes $iNode and $jNode"
	puts [format "Yielding Moment about ZZ: %.1f" $Myp1zz];
	puts [format "Maximum Moment about ZZ: %.1f" $Mcp1zz];
	puts [format "Ultimate Moment about ZZ: %.1f" $Mup1zz];
	puts [format "Moment at Intersection about ZZ: %.1f" $Mintp1zz];

	puts [format "Yielding Moment about YY: %.1f" $Myp1yy];
	puts [format "Maximum Moment about YY: %.1f" $Mcp1yy];
	puts [format "Ultimate Moment about YY: %.1f" $Mup1yy];
	puts [format "Moment at Intersection about YY: %.1f" $Mintp1yy];

	puts [format "Yield Rotation about ZZ: %.4f" $thetaY1zz];
	puts [format "Post-Capping Plastic Chord Rotation about ZZ: %.4f"  [expr $thetaY1zz+$thetaPlmax1zz]];
	puts [format "Post-Capping Ultimate Chord Rotation about ZZ: %.4f" [expr $thetaY1zz+$thetaPlmax1zz+$thetaPcult1zz]];
	puts [format "Rotation at Intersection about ZZ: %.4f" $thetaInt1zz];
	puts [format "Maximum Rotation about ZZ: %.4f" [expr $thetaY1zz+$thetaPlmax1zz+$thetaPcult1zz+$thetaPuzero1zz]]

	puts [format "Yield Rotation about YY: %.4f" $thetaY1yy];
	puts [format "Post-Capping Plastic Chord Rotation about YY: %.4f"  [expr $thetaY1zz+$thetaPlmax1yy]];
	puts [format "Post-Capping Ultimate Chord Rotation about YY: %.4f" [expr $thetaY1zz+$thetaPlmax1yy+$thetaPcult1yy]];
	puts [format "Rotation at Intersection about YY: %.4f" $thetaInt1yy];
	puts [format "Maximum Rotation about YY: %.4f" [expr $thetaY1yy+$thetaPlmax1yy+$thetaPcult1yy+$thetaPuzero1yy]]

	puts [format "Lp: %.3fm   nu: %.3f  L:%.3fm" $Lp $nu $L];
	puts [format "b: %.3fm   h: %.3fm" $b $h];
	if {$ST>1} {
		puts [format "V_cryy:%.1fkN V_ccyy:%.1fkN V_cyy:%.1fkN V_resyy:%.1fkN V_crzz:%.1fkN V_cczz:%.1fkN V_czz:%.1fkN V_reszz:%.1fkN" $V_cryy $V_ccyy $V_cyy $V_resyy $V_crzz $V_cczz $V_czz $V_reszz];
		puts [format "gamm_cryy:%.4f gamm_pkyy:%.4f gamm_uyy:%.4f gamm_myy:%.4f gamm_crzz:%.4f gamm_pkzz:%.4f gamm_uzz:%.4f gamm_mzz:%.4f" $gamm_cryy $gamm_pkyy $gamm_uyy $gamm_myy $gamm_crzz $gamm_pkzz $gamm_uzz $gamm_mzz];
	}
}

# -----------------------------------------------
# -- Create the Flexural Material Model ---------
# -----------------------------------------------

##### Positive/Negative envelope Moment
set pMom1zz [list $Myp1zz $Mcp1zz $Mup1zz $Mintp1zz]; # stress1 stress2 stress3 stress4
set pMom2zz [list $Myp2zz $Mcp2zz $Mup2zz $Mintp2zz]; # stress1 stress2 stress3 stress4
set nMom1zz [list -$Myn1zz -$Mcn1zz -$Mun1zz -$Mintp1zz]; # stress1 stress2 stress3 stress4
set nMom2zz [list -$Myn2zz -$Mcn2zz -$Mun2zz -$Mintp2zz]; # stress1 stress2 stress3 stress4
set pMom1yy [list $Myp1yy $Mcp1yy $Mup1yy $Mintp1yy]; # stress1 stress2 stress3 stress4
set pMom2yy [list $Myp2yy $Mcp2yy $Mup2yy $Mintp2yy]; # stress1 stress2 stress3 stress4
set nMom1yy [list -$Myn1yy -$Mcn1yy -$Mun1yy -$Mintp1yy]; # stress1 stress2 stress3 stress4
set nMom2yy [list -$Myn2yy -$Mcn2yy -$Mun2yy -$Mintp2yy]; # stress1 stress2 stress3 stress4

##### Positive/Negative envelope Curvature
set pRot1zz [list  $thetaY1zz  [expr $thetaY1zz+$thetaPlmax1zz]     [expr $thetaY1zz+$thetaPlmax1zz+$thetaPcult1zz]     $thetaInt1zz]; # strain1 strain2 strain3 strain4
set pRot2zz [list  $thetaY2zz  [expr $thetaY2zz+$thetaPlmax2zz]     [expr $thetaY2zz+$thetaPlmax2zz+$thetaPcult2zz]     $thetaInt2zz]; # strain1 strain2 strain3 strain4
set nRot1zz [list -$thetaY1zz  [expr -($thetaY1zz+$thetaPlmax1zz)]  [expr -($thetaY1zz+$thetaPlmax1zz+$thetaPcult1zz)] -$thetaInt1zz]; # strain1 strain2 strain3 strain4
set nRot2zz [list -$thetaY2zz  [expr -($thetaY2zz+$thetaPlmax2zz)]  [expr -($thetaY2zz+$thetaPlmax2zz+$thetaPcult2zz)] -$thetaInt2zz]; # strain1 strain2 strain3 strain4
set pRot1yy [list  $thetaY1yy  [expr $thetaY1yy+$thetaPlmax1yy]     [expr $thetaY1yy+$thetaPlmax1yy+$thetaPcult1yy]     $thetaInt1yy]; # strain1 strain2 strain3 strain4
set pRot2yy [list  $thetaY2yy  [expr $thetaY2yy+$thetaPlmax2yy]     [expr $thetaY2yy+$thetaPlmax2yy+$thetaPcult2yy]     $thetaInt2yy]; # strain1 strain2 strain3 strain4
set nRot1yy [list -$thetaY1yy  [expr -($thetaY1yy+$thetaPlmax1yy)]  [expr -($thetaY1yy+$thetaPlmax1yy+$thetaPcult1yy)] -$thetaInt1yy]; # strain1 strain2 strain3 strain4
set nRot2yy [list -$thetaY2yy  [expr -($thetaY2yy+$thetaPlmax2yy)]  [expr -($thetaY2yy+$thetaPlmax2yy+$thetaPcult2yy)] -$thetaInt2yy]; # strain1 strain2 strain3 strain4

set rDispM  [list 0.87 0.87]; # Pos_env. Neg_env.##### Ratio of maximum deformation at which reloading begins
set rForceM [list 0.80 0.80]; # Pos_env. Neg_env.##### Ratio of envelope force (corresponding to maximum deformation) at which reloading begins
set uForceM [list -0.14 -0.14]; # Pos_env. Neg_env.##### Ratio of monotonic strength developed upon unloading
set gammaKM [list 0.26 0.10 0.79 0.62 1.0]; # gammaK1 gammaK2 gammaK3 gammaK4 gammaKLimit
set gammaDM [list 0.08 0.17 0.40 0.47 1.0]; # gammaD1 gammaD2 gammaD3 gammaD4 gammaDLimit
set gammaFM [list 0.0 0.0 0.0 0.0 1.0]; # gammaF1 gammaF2 gammaF3 gammaF4 gammaFLimit
set gammaEM 100
# damage type (option: "energy", "cycle")
set damM "energy"
# add the material to domain through the use of a procedure
set ohingeMTag1zz 101${ET}; # Create an nonlinear material for the flexural hinge to be aggregated to the actual PH
set ohingeMTag2zz 102${ET}; # Create an nonlinear material for the flexural hinge to be aggregated to the actual PH
set ohingeMTag1yy 103${ET}; # Create an nonlinear material for the flexural hinge to be aggregated to the actual PH
set ohingeMTag2yy 104${ET}; # Create an nonlinear material for the flexural hinge to be aggregated to the actual PH
procUniaxialPinching $ohingeMTag1zz $pMom1zz $nMom1zz $pRot1zz $nRot1zz $rDispM $rForceM $uForceM $gammaKM $gammaDM $gammaFM $gammaEM $damM
procUniaxialPinching $ohingeMTag2zz $pMom2zz $nMom2zz $pRot2zz $nRot2zz $rDispM $rForceM $uForceM $gammaKM $gammaDM $gammaFM $gammaEM $damM
procUniaxialPinching $ohingeMTag1yy $pMom1yy $nMom1yy $pRot1yy $nRot1yy $rDispM $rForceM $uForceM $gammaKM $gammaDM $gammaFM $gammaEM $damM
procUniaxialPinching $ohingeMTag2yy $pMom2yy $nMom2yy $pRot2yy $nRot2yy $rDispM $rForceM $uForceM $gammaKM $gammaDM $gammaFM $gammaEM $damM

set hingeMTag1zz 105${ET}; # Apply the max and minimum limits on the material
set hingeMTag2zz 106${ET}; #
set hingeMTag1yy 107${ET}; #
set hingeMTag2yy 108${ET}; #
uniaxialMaterial MinMax $hingeMTag1zz $ohingeMTag1zz -min [expr -($thetaY1zz+$thetaPlmax1zz+$thetaPcult1zz+$thetaPuzero1zz)] -max [expr ($thetaY1zz+$thetaPlmax1zz+$thetaPcult1zz+$thetaPuzero1zz)]
uniaxialMaterial MinMax $hingeMTag2zz $ohingeMTag2zz -min [expr -($thetaY2zz+$thetaPlmax2zz+$thetaPcult2zz+$thetaPuzero2zz)] -max [expr ($thetaY2zz+$thetaPlmax2zz+$thetaPcult2zz+$thetaPuzero2zz)]
uniaxialMaterial MinMax $hingeMTag1yy $ohingeMTag1yy -min [expr -($thetaY1yy+$thetaPlmax1yy+$thetaPcult1yy+$thetaPuzero1yy)] -max [expr ($thetaY1yy+$thetaPlmax1yy+$thetaPcult1yy+$thetaPuzero1yy)]
uniaxialMaterial MinMax $hingeMTag2yy $ohingeMTag2yy -min [expr -($thetaY2yy+$thetaPlmax2yy+$thetaPcult2yy+$thetaPuzero2yy)] -max [expr ($thetaY2yy+$thetaPlmax2yy+$thetaPcult2yy+$thetaPuzero2yy)]

# -----------------------------------------------
# -- Create the Shear Material Model ------------
# -----------------------------------------------
if {$ST>0} {
	##### Positive/Negative envelope Moment
	set pV1yy [list $V_cryy $V_ccyy $V_cyy $V_resyy]; # stress1 stress2 stress3 stress4
	set pV1zz [list $V_crzz $V_cczz $V_czz $V_reszz]; # stress1 stress2 stress3 stress4
	set nV1yy [list -$V_cryy -$V_ccyy -$V_cyy -$V_resyy]; # stress1 stress2 stress3 stress4
	set nV1zz [list -$V_crzz -$V_cczz -$V_czz -$V_reszz]; # stress1 stress2 stress3 stress4
	##### Positive/Negative envelope Curvature
	set pShr1yy [list $gamm_cryy $gamm_pkyy $gamm_uyy $gamm_myy]; # strain1 strain2 strain3 strain4
	set pShr1zz [list $gamm_crzz $gamm_pkzz $gamm_uzz $gamm_mzz]; # strain1 strain2 strain3 strain4
	set nShr1yy [list -$gamm_cryy -$gamm_pkyy -$gamm_uyy -$gamm_myy]; # strain1 strain2 strain3 strain4
	set nShr1zz [list -$gamm_crzz -$gamm_pkzz -$gamm_uzz -$gamm_mzz]; # strain1 strain2 strain3 strain4
	set rDispV [list 0.4 0.4]; # Pos_env. Neg_env.##### Ratio of maximum deformation at which reloading begins
	set rForceV [list 0.2 0.2]; # Pos_env. Neg_env.##### Ratio of envelope force (corresponding to maximum deformation) at which reloading begins
	set uForceV [list 0.0 0.0]; # Pos_env. Neg_env.##### Ratio of monotonic strength developed upon unloading
	set gammaKV [list 0.0 0.0 0.0 0.0 0.0]; # gammaK1 gammaK2 gammaK3 gammaK4 gammaKLimit
	set gammaDV [list 0.0 0.0 0.0 0.0 0.0]; # gammaD1 gammaD2 gammaD3 gammaD4 gammaDLimit
	set gammaFV [list 0.0 0.0 0.0 0.0 0.0]; # gammaF1 gammaF2 gammaF3 gammaF4 gammaFLimit
	set gammaEV 0.0
	set damV "energy"
	# add the material to domain through the use of a procedure
	set hingeShTagyy 109${ET}; # Create an nonlinear material for the shear hinge to be aggregated to the actual PH
	set hingeShTagzz 110${ET}; # Create an nonlinear material for the shear hinge to be aggregated to the actual PH

	procUniaxialPinching $hingeShTagyy $pV1yy $nV1yy $pShr1yy $nShr1yy $rDispV $rForceV $uForceV $gammaKV $gammaDV $gammaFV $gammaEV $damV
	procUniaxialPinching $hingeShTagzz $pV1zz $nV1zz $pShr1zz $nShr1zz $rDispV $rForceV $uForceV $gammaKV $gammaDV $gammaFV $gammaEV $damV
	# uniaxialMaterial Elastic $hingeShTag $GA0
}
# --------------------------------------
# -- Create the Element  ---------------
# --------------------------------------
set intTag 		111${ET};	# Internal elastic section tag
set fTag1zz 	112${ET}; 	# Section tag Mz 1
set fTag2zz 	113${ET}; 	# Section tag Mz 2
set fTag1yy 	114${ET}; 	# Section tag My 1
set fTag2yy 	115${ET}; 	# Section tag My 2
set phTag1  	116${ET}; 	# Create an aggregated section with this tag for the actual element
set phTag2  	117${ET}; 	# Create an aggregated section with this tag for the actual element
set tempTag		118${ET};	# temporary section tag to be used in creating bidirectional response

# Create the internal elastic element behaviour with cracked section properties
section Elastic $intTag [expr $Ec*$MPa] $Ag $Izze $Iyye $Gc 0.01

# Create the plastic hinge section
section Uniaxial $fTag1zz $hingeMTag1zz Mz; 							# Create the PH flexural section about zz
section Uniaxial $fTag2zz $hingeMTag2zz Mz; 							# Create the PH flexural section about zz

if {$ST==1} {
	section Aggregator $phTag1 $hingeShTagyy Vy $hingeShTagzz Vz $hingeMTag1yy My -section $fTag1zz;		# Aggregate Vyy, Vzz and Myy behaviour to Mzz behaviour
	section Aggregator $phTag2 $hingeShTagyy Vy $hingeShTagzz Vz $hingeMTag2yy My -section $fTag2zz;		# Aggregate Vyy, Vzz and Myy behaviour to Mzz behaviour
} else {
	section Aggregator $phTag1 $hingeMTag1yy My -section $fTag1zz;		# Aggregate Myy behaviour to Mzz behaviour
	section Aggregator $phTag2 $hingeMTag2yy My -section $fTag2zz;		# Aggregate Myy behaviour to Mzz behaviour
}

if {$ST<2} {
	# Set the integration scheme (Read through Scott & Fenves (2006) JStructE Paper)
	# set integration "HingeMidpoint $phTag1 $Lp $phTag2 $Lp $intTag"
	set integration "HingeEndpoint $phTag1 $Lp $phTag2 $Lp $intTag"
	# set integration "HingeRadauTwo $phTag1 $Lp $phTag2 $Lp $intTag"
	# set integration "HingeRadau $phTag1 $Lp $phTag2 $Lp $intTag"; # This scheme satisfies all 3 criteria by Scott & Fenves

	# Create the whole element
	# element forceBeamColumn $eleTag $iNode $jNode $transfTag $integration <-mass $massDens> <-iter $maxIters $tol>
	element forceBeamColumn $ET $iNode $jNode $GT $integration -iter 100 1e-12

	# element elasticBeamColumn $ET $iNode $jNode $Ag [expr $Ec*$MPa] $Gc 0.01 $Iyye $Izze $GT

	# element beamWithHinges $ET $iNode $jNode $phTag1 $Lp $phTag2 $Lp [expr $Ec*$MPa] $Ag $Izze $Iyye $Gc 0.01 $GT
} elseif {$ST==2} {
	# Get the current location of the end nodes
	set iNodeX [nodeCoord $iNode 1]; set iNodeY [nodeCoord $iNode 2]; set iNodeZ [nodeCoord $iNode 3];
	set jNodeX [nodeCoord $jNode 1]; set jNodeY [nodeCoord $jNode 2]; set jNodeZ [nodeCoord $jNode 3];

	# Create two dummy nodes in their place
	node 11${iNode} $iNodeX $iNodeY $iNodeZ -mass 0.0 0.0 0.0 0.0 0.0 0.0
	node 12${jNode} $jNodeX $jNodeY $jNodeZ -mass 0.0 0.0 0.0 0.0 0.0 0.0

	# Create the rigid material
	set rigM 100${ET};
	uniaxialMaterial Elastic $rigM 1e10

	# Create the shear hinges
	element zeroLength 1${ET} 11${iNode} $iNode -mat $hingeShTagzz  $hingeShTagyy  $rigM  	$rigM $rigM $rigM  -dir 1 2 3 4 5 6 -doRayleigh 1
	element zeroLength 2${ET} 12${jNode} $jNode -mat $hingeShTagzz  $hingeShTagyy  $rigM  	$rigM $rigM $rigM  -dir 1 2 3 4 5 6 -doRayleigh 1

# 	element zeroLength 1${ET} 10${iNode} $iNode -mat $rigM $rigM  $rigM  	$rigM $rigM $rigM  -dir 1 2 3 4 5 6 -doRayleigh 1
# 	element zeroLength 2${ET} 10${jNode} $jNode -mat $rigM $rigM  $rigM  	$rigM $rigM $rigM  -dir 1 2 3 4 5 6 -doRayleigh 1

	# Create the actual beam-column element
	# Set the integration scheme (Read through Scott & Fenves (2006) JStructE Paper)
	# set integration "HingeMidpoint $phTag1 $Lp $phTag2 $Lp $intTag"
	set integration "HingeEndpoint $phTag1 $Lp $phTag2 $Lp $intTag"
	# set integration "HingeRadauTwo $phTag1 $Lp $phTag2 $Lp $intTag"
	# set integration "HingeRadau $phTag1 $Lp $phTag2 $Lp $intTag"; # This scheme satisfies all 3 criteria by Scott & Fenves

	# Create the whole element
	# element forceBeamColumn $eleTag $iNode $jNode $transfTag $integration <-mass $massDens> <-iter $maxIters $tol>
	element forceBeamColumn $ET 11$iNode 12$jNode $GT $integration -iter 100 1e-12

	# element elasticBeamColumn $ET $iNode $jNode $Ag [expr $Ec*$MPa] $Gc 0.01 $Iyye $Izze $GT

	# element beamWithHinges $ET $iNode $jNode $phTag1 $Lp $phTag2 $Lp [expr $Ec*$MPa] $Ag $Izze $Iyye $Gc 0.01 $GT
}


}

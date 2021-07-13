# --------------------------------------
# DEFINE RECORDERS
# --------------------------------------

#source /Users/moayadnafeaa/Desktop/casestudyOS/OSproc/arch_recorders.tcl

# Only take the envelope of some recorders for dynamic analysis
set NRtype "Node"; # Node Recorder type
set ERtype "Element"; # Element Recorder type

# Displacements
eval "recorder Node	-file $outsdir/dispX.${AType}.${nst}st_${mtype}.$run.txt 	-node $node_recorder -dof 1 disp"
eval "recorder Node	-file $outsdir/dispY.${AType}.${nst}st_${mtype}.$run.txt 	-node $node_recorder -dof 2 disp"

# Storey Drifts
eval "recorder Drift -file $outsdir/drftX.${AType}.${nst}st_${mtype}.$run.txt -iNode $bNode -jNode $tNode -dof 1 -perpDirn 3"
eval "recorder Drift -file $outsdir/drftY.${AType}.${nst}st_${mtype}.$run.txt -iNode $bNode -jNode $tNode -dof 2 -perpDirn 3"

# Floor Accelerations (if no timeseries given, records relative accel)
# eval "recorder Node	-file $outsdir/accelX.${AType}.${nst}st_${mtype}.$run.txt -time -timeSeries $tsTag -node $node_recorder -dof 1 accel"

# Base Reaction
recorder Node	-file $outsdir/rxnX.${AType}.${nst}st_${mtype}.$run.txt 	-node 1110 1210 1310 1410 1510 1610 1710 1120 1220 1320 1420 1520 1620 1720 1130 1230 1330 1430 1530 1630 1730 1140 1240 1340 1440 1540 1640 1740 -dof 1 reaction
recorder Node	-file $outsdir/rxnY.${AType}.${nst}st_${mtype}.$run.txt 	-node 1110 1210 1310 1410 1510 1610 1710 1120 1220 1320 1420 1520 1620 1720 1130 1230 1330 1430 1530 1630 1730 1140 1240 1340 1440 1540 1640 1740 -dof 2 reaction

# --------------------------------------
# DEFINE LATERAL LOAD PATTERN
# --------------------------------------
set tsTag 1;
timeSeries Linear $tsTag -factor 1
pattern Plain 1 $tsTag {
	for {set i 1} {$i <= $nst} {incr i 1} {
		if {$push_dir=="X"} {

			load 111${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 121${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 131${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 141${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 151${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 161${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 171${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0

			load 112${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 122${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 132${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 142${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 152${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 162${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 172${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0

			load 113${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 123${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 133${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 143${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 153${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 163${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 173${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0

			load 114${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 124${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 134${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 144${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 154${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 164${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0
			load 174${i} [expr 0.14*$i] 0.0 0.0	0.0	0.0	0.0

		} elseif {$push_dir=="Y"} {

			load 111${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 121${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 131${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 141${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 151${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 161${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 171${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0

			load 112${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 122${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 132${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 142${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 152${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 162${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 172${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0

			load 113${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 123${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 133${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 143${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 153${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 163${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 173${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0

			load 114${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 124${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 134${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 144${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 154${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 164${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
			load 174${i} 0.0 [expr 0.14*$i] 0.0	0.0	0.0	0.0
		}
	}
}

# --------------------------------------
# PUSHOVER ANALYSIS
# --------------------------------------
constraints Transformation
numberer RCM
system UmfPack
source $procdir/singlePush.tcl
source $procdir/cyclicPush.tcl

if {$AType=="SPO"} {
	if {$push_dir=="X"} {
		puts "Pushing in X"
		singlePush 0.001 $tDisp $roofNode 1 $nSteps 2
		} elseif {$push_dir=="Y"} {
			puts "Pushing in Y"
			singlePush 0.001 $tDisp $roofNode 2 $nSteps 2
		}
	}

	if {$AType=="CPO"} {
		if {$push_dir=="X"} {
			puts "Pushing in X"
			set ctrlN $roofNode
			#cyclicPush $dref mu nCyc 	ctrlN  drn  nSteps pflag
			cyclicPush 0.005 5    3 	$ctrlN 1 $nSteps 1 1
			cyclicPush 0.005 10   3 	$ctrlN 1 $nSteps 1 1
			cyclicPush 0.005 15   3 	$ctrlN 1 $nSteps 1 1
			cyclicPush 0.005 20   3  	$ctrlN 1 $nSteps 1 1


			} elseif {$push_dir=="Y"} {
				puts "Pushing in Y"
				set ctrlN $roofNode
				#cyclicPush $dref mu nCyc 	ctrlN  drn  nSteps pflag
				cyclicPush 0.005 5    3 	$ctrlN 2 $nSteps 1 1
				cyclicPush 0.005 10   3 	$ctrlN 2 $nSteps 1 1
				cyclicPush 0.005 15   3 	$ctrlN 2 $nSteps 1 1
				cyclicPush 0.005 20   3  	$ctrlN 2 $nSteps 1 1


			}
		}

puts " # -------------------------------------------------- "
puts " # Master file for MSA analyses on archetypes			    "
puts " # -------------------------------------------------- "
puts " # Created by: Al Mouayed Bellah Nafeh"
puts " # Affiliation: IUSS Pavia (PhD Student)"
puts " # April 2020"
puts " # -------------------------------------------------- "

wipe;
# --------------------------------------------------
# Start the clock
# --------------------------------------------------
set startTime [clock clicks -milliseconds];

# --------------------------------------------------
# Define initial analysis parameters
# --------------------------------------------------
set AType "NRHA";                # analysis type (NRHA for MSA, IDA for IDA); keep this to "NRHA" in this script because IDA has its own script
set ConstEra "GLD";              # construction era (GLD: gravity load design, SSD: sub-standard design, HSD: high seismic design)
set arch    [list 1];            # archetype ID
set stories		[list 2 3 4];      # number of stories
set dCap		0.10;	               # Define a drift capacity (10%)
set xi		  0.05;	               # Elastic damping (5%)
set tpad		0.00;	               # Additional time to run at end of each record
set Tstar   [list 0.2 0.3];      # conditioning period (the first period corresponds to X, the second in Y)
set pflag 		1;
set SaT 	[list 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.5 3.0]; # List of stripe intensity measure levels

# --------------------------------------------------
# Define initial directories
# --------------------------------------------------
set procdir "";  # paste the directory path of the opensees procedures folder (not the procedure itself)
set modeldir ""; # paste the directory path of the opensees model folder (not the model itself)

# Source the necessary files
source $procdir/Units.tcl
source $procdir/runNRHA3D.tcl
source $procdir/getSaT.tcl

# --------------------------------------
# NRHA with Selected Ground Motions
# --------------------------------------
#Loop over archetypes and storey numbers
for {set jj 1} {$jj<=[llength $arch]} {incr jj 1} {
  set arch_curr [lindex $arch $jj-1];
  for {set ii 1} {$ii<=[llength $stories]} {incr ii 1} {
    set nst	[lindex $stories $ii-1];

    #Set model
    set cmodel 		"arch_${arch_curr}_${nst}st";
    set outsdir		"[EDIT THIS PART]/${cmodel}_${ConstEra}" ; #add the output directory

    # Source the directories of the ground motions (IN THIS SCRIPT, I HAVE USED THE FEMAP695 Far-Field Record Set. The user is free to select his own record suite, but keep the file format as is)
    # Remember to fix broken links (...)
    set nmsfile_P		".../FEMA_P695_unscaled_names.txt"
    set nmsfile_S		".../FEMA_P695_unscaled_names.txt"
    set dtsfile		  ".../FEMA_P695_unscaled_dts.txt"
    set dursfile  	".../FEMA_P695_unscaled_durs.txt"

    set eqnms_P_list 		[read [open $nmsfile_P "r"]];
    set eqnms_S_list 		[read [open $nmsfile_S "r"]];
    set dts_list 		    [read [open $dtsfile "r"]];
    set durs_list 		  [read [open $dursfile "r"]];
    set neqs 			      [llength $dts_list];

    # Source the necessary files
    source $procdir/Units.tcl
    source $procdir/runNRHA3D.tcl
    source $procdir/getSaT.tcl

      puts "Analyzing ${ConstEra} Case Study Building $arch_curr with $nst Stories"

      # Loop through each of the intensities
      for {set i 1} {$i<=[llength $SaT]} {incr i 1} {

        # Loop through each of the ground motions
        for {set q 1} {$q<=$neqs} {incr q 1} {

          # Determine the required scale factor
          set Sa_curr [lindex $SaT $i-1]

          # Load the ground motion
          set EQnameX 	[lindex $eqnms_P_list $q-1]; # Get the name of the record
          set EQnameY 	[lindex $eqnms_S_list $q-1]; # Get the name of the record
          set dtX		    [lindex $dts_list $q-1];	# Current dt
          set dtY		    [lindex $dts_list $q-1];	# Current dt
          set Tmax		  [lindex $durs_list $q-1];	# Current duration
          set Tx        [lindex $cperiod 0];
          set Ty        [lindex $cperiod 1];
          puts "Conditioning Period in X is $Tx s"
          puts "Conditioning Period in Y is $Ty s"
          getSaT $EQnameX 	[lindex $dts_list $q-1] $Tx $xi; # Get the Sa(T1,5%) of the record
          set sfX 	        [expr $Sa_curr/$Sa*$g];
          getSaT $EQnameY 	[lindex $dts_list $q-1] $Ty $xi; # Get the Sa(T1,5%) of the record
          set sfY 	        [expr $Sa_curr/$Sa*$g];

          set run		${Sa_curr}_${q}

          # Source the model
          source "${modeldir}/${cmodel}.tcl"
          set log [open $outsdir/log_${AType}_${run}.txt "w"];
          # runNRHA3D Dt 	Tmax 	Dc 	tNode bNode log {pflag 0}
          runNRHA3D 	0.01 	$Tmax 10.0 $tNode $bNode $log 1
          close $log
          wipe;
      }
    }
  }
}




# --------------------------------------------------
# Stop the clock
# --------------------------------------------------
set totalTimeSEC [expr ([clock clicks -milliseconds]-$startTime)/1000];
set totalTimeMIN [expr $totalTimeSEC/60];
set totalTimeHR [expr $totalTimeMIN/60];
puts [format "Total runtime was %.3f seconds" $totalTimeSEC];
puts [format "Total runtime was %.3f minutes" $totalTimeMIN];
puts [format "Total runtime was %.3f hours" $totalTimeHR];
wipe;

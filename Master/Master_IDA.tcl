puts " # -------------------------------------------------- "
puts " # Master file for IDA analyses on archetypes			    "
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
set AType "IDA";               # analysis type (NRHA for MSA, IDA for IDA); keep this to "IDA" in this script because NRHA has its own script
set ConstEra "HSD";            # construction era (GLD: gravity load design, SSD: sub-standard design, HSD: high seismic design)
set arch    [list 1];          # archetype ID
set stories		[list 2];        # number of stories
set xi 0.05;                   # elastic damping
set Tstar [list 0.19 0.20];    # conditioning period (the first period corresponds to X, the second in Y)

# --------------------------------------------------
# Define initial directories
# --------------------------------------------------
set procdir "..." ; # paste the directory path of the opensees procedures folder (not the procedure itself)
set modeldir "..."; # paste the directory path of the opensees model folder (not the model itself)

# Source the necessary files
source $procdir/Units.tcl
source $procdir/runNRHA3D.tcl
source $procdir/getSaT.tcl
source $procdir/IDA_HTF_3D.tcl

# --------------------------------------------------
# IDA with INNOSEIS Medium Seismicity Ground Motions
# --------------------------------------------------
#Loop over archetypes and storey numbers
for {set jj 1} {$jj<=[llength $arch]} {incr jj 1} {
  set arch_curr [lindex $arch $jj-1];
  for {set ii 1} {$ii<=[llength $stories]} {incr ii 1} {
    set nst	[lindex $stories $ii-1];

    #Set model and output directory
    set cmodel 		"arch_${arch_curr}_${nst}st"; # Dont edit this
    set outsdir		"/...";                       # add the output directory

    # Source the directories of the ground motions (IN THIS SCRIPT, I HAVE USED THE FEMAP695 Far-Field Record Set. The user is free to select his own record suite, but keep the file format as is)
    # Remember to fix broken links (...)
    set nmsfile_P		".../FEMA_P695_unscaled_names.txt"
    set nmsfile_S		".../FEMA_P695_unscaled_names.txt"
    set dtsfile		  ".../FEMA_P695_unscaled_dts.txt"
    set dursfile  	".../FEMA_P695_unscaled_durs.txt"

    set eqnms_P_list 		[read [open $nmsfile_P "r"]];
    set eqnms_S_list 		[read [open $nmsfile_S "r"]];
    set dts_list 		    [read [open $dtsfile "r"]];
    set durs_list 	    [read [open $dursfile "r"]];
    set neqs 			      [llength $dts_list];

    #Display analysis items for sanity check
    puts "Analyzing ${ConstEra} Case Study Building $arch_curr with $nst Stories"
    puts "Conditoning Period is set to: $Tstar s"

    # Source the model
    set mdlfile "${modeldir}/${cmodel}.tcl"
    #source $mdlfile

    #IDA_HTF  firstInt incrStep maxRuns IMtype Tinfo    xi     Dt    dCap  nmsfileX   nmsfileY   dtsfile  dursfile  outsdir  mdlfile
    IDA_HTF 	  0.05    0.10 	    15      2    $Tstar  $xi   0.01 	 10.0   $nmsfile_P $nmsfile_S $dtsfile $dursfile $outsdir $mdlfile 1
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

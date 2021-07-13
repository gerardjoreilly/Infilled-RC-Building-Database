puts " # -------------------------------------------------- "
puts " # Master file for PO analyses on archetypes			    "
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
# Define Analysis Options
# --------------------------------------------------
set AType "CPO";  # analysis type: SPO, CPO
set push_dir "X"; # direction of analysis: X, Y
set run 	1;      # ID of run
set tDisp 500;    # target displacement (in mm)
set nSteps 100;   # number of steps
# --------------------------------------------------
# Define Building Options
# --------------------------------------------------
set Typ "IF";                   # building typology (IF, BF, PF)
set ConstEra "GLD";             # construction era (GLD: gravity load design, SSD: sub-standard design, HSD: high seismic design)
set arch    [list 2 3 4 5 6 7]; # archetype ID
set stories		[list 2 3 4 5 6]; # number of storeys
# --------------------------------------------------
# Define initial directories
# --------------------------------------------------
set procdir "";  # paste the directory path of the opensees procedures folder (not the procedure itself)
set modeldir ""; # paste the directory path of the opensees model folder (not the model itself)

# --------------------------------------------------
# Perform Analysis
# --------------------------------------------------
for {set jj 1} {$jj<=[llength $arch]} {incr jj 1} {
  set arch_curr [lindex $arch $jj-1];
  for {set ii 1} {$ii<=[llength $stories]} {incr ii 1} {
    set nst	[lindex $stories $ii-1];
    set outsdir "[EDIT THIS PART]/${AType}/${ConstEra}/${AType}_${push_dir}_Arch_${Typ}_${arch_curr}_${nst}"; #add the output directory, some automisation for folder naming is offered depending on the loops running.

    if {$AType=="SPO"} {
      puts "Performing Static Pushover Analysis on ${ConstEra} ${nst}-Storey ${Typ} Archetype # ${arch_curr} in ${push_dir}-Direction"
      # Load the building model
      source $modeldir/arch_${arch_curr}_${nst}st.tcl

      # Execute analysis
      source $procdir/arch_${arch_curr}_push.tcl
      wipe;
    }

    if {$AType=="CPO"} {
      puts "Performing Cyclic Pushover Analysis on ${ConstEra} ${nst}-Storey ${Typ} Archetype # ${arch_curr} in ${push_dir}-Direction"
      # Load the building model
      source $modeldir/arch_${arch_curr}_${nst}st.tcl

      # Execute analysis
      source $procdir/arch_${arch_curr}_push.tcl
      wipe;
    }
  }
}

# --------------------------------------------------
# Stop the clock
# --------------------------------------------------
puts " # -------------------------------------------------- "
puts " # ANALYSIS CONCLUDED			                            "
puts " # Ciao!"
puts " # -------------------------------------------------- "
set totalTimeSEC [expr ([clock clicks -milliseconds]-$startTime)/1000];
set totalTimeMIN [expr $totalTimeSEC/60];
set totalTimeHR [expr $totalTimeMIN/60];
puts [format "Total runtime was %.3f seconds" $totalTimeSEC];
puts [format "Total runtime was %.3f minutes" $totalTimeMIN];
puts [format "Total runtime was %.3f hours" $totalTimeHR];
wipe;

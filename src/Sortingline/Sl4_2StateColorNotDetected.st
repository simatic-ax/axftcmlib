USING Simatic.Ax.StateFramework;

//element is thrown out of the Sortingline by the conveyor
NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlColorNotDetected EXTENDS State1Transition
        VAR PUBLIC //Reset 
          UsedSortingline : ISortingline;
        END_VAR        
        METHOD PUBLIC OVERRIDE  OnEntry
            USedSOrtingline.SlClearConveyor();
        END_METHOD
    END_CLASS

END_NAMESPACE


// SlAxis : AXIS;
// SlVelocity : LREAL;
// Activetime : PULSE := (duration := LT#5.0s);//TODO Duration 
// METHOD PUBLIC OVERRIDE  OnEntry
//     VAR
//         dir : INT := 0;
//         Trigger : BOOL;
//     END_VAR
//  Trigger := TRUE; 
//  IF ActiveTime.output THEN
//  SlAxis.MoveVelocity(SlVelocity,dir);
//  ELSE
// SlAxis.HALT();
//  END_IF;
// END_METHOD
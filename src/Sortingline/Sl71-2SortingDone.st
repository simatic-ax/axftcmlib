USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlSortingDone EXTENDS State1Transition
        VAR PUBLIC //Reset 
           SlAxis : AXIS;
        END_VAR        
        METHOD PUBLIC OVERRIDE  OnEntry
               SlAxis.Halt();
        END_METHOD
    END_CLASS

END_NAMESPACE
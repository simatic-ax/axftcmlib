USING Simatic.Ax.StateFramework;
//SOrtingline is ready for the next Element to be sorted
NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlStateIdle EXTENDS State1Transition
        VAR PUBLIC //Reset 
           UsedSortingline : Sortingline;
        END_VAR        
        METHOD PUBLIC OVERRIDE  OnEntry
          ;
        END_METHOD
    END_CLASS

END_NAMESPACE
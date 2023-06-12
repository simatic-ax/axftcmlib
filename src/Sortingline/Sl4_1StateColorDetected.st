USING Simatic.Ax.StateFramework;
//Valid element is transported to the next sensor
NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlColorDetected EXTENDS State1Transition
        VAR PUBLIC //Reset 
          UsedSortingline : ISortingline;
        END_VAR        
        METHOD PUBLIC OVERRIDE  OnEntry
            UsedSortingline.SlMoveToSensor();
        END_METHOD
    END_CLASS

END_NAMESPACE
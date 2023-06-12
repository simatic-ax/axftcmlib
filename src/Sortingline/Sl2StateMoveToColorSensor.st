USING Simatic.Ax.StateFramework;
//If an element is placed infront of the first sensor, the Axis moves to the colorsensor
NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlStateMoveToColorSensor EXTENDS State1Transition
        VAR PUBLIC 
          Sortingline : ISortingline;
        END_VAR        
        METHOD PUBLIC OVERRIDE  OnEntry
            Sortingline.SlMoveToColorsensor();
        END_METHOD
    END_CLASS

END_NAMESPACE
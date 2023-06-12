USING Simatic.Ax.StateFramework;
//if the axis is done, the sensor detects the color and puts it oput
    //->Color valid PArt will be sorted by pusher -> Path 1
    //->color invalid (=#Unknown) ->Path 2
NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlStateDetectColor EXTENDS State2Transition
    VAR
        UsedSortingline : ISortingline;
    END_VAR
        METHOD PUBLIC OVERRIDE OnEntry
            UsedSortingline.SlDetectColor();
        END_METHOD
    END_CLASS

END_NAMESPACE
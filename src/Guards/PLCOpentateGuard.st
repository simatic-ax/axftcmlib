USING Simatic.Ax.StateFramework;
NAMESPACE Simatic.Ax.axftcmlib   

    ///This guard is used to check the activity of an axis
    ///An Axis will return a PLCOpenSTate#Done if a movement is finished
    /// This is sed for state transitions 
    CLASS PLCOpenstateGuard IMPLEMENTS IGuard
        VAR PUBLIC
            Axis : REF_TO Axis;
        END_VAR
    
        METHOD PUBLIC Check : BOOL
            Check := (Axis^.GetPlcOpenState() = PlcOpenState#Done);
        END_METHOD
    
        METHOD PUBLIC Reset
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE


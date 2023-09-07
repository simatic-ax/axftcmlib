USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.axftcmlib
    ///Guard used to start the actual statemachine
    /// Is used in the pneumatic cylinder class
    CLASS StartGuard IMPLEMENTS IGuard
        
        VAR 
            IsStarted : BOOL;
        END_VAR
    
        METHOD PUBLIC Check : BOOL
            Check := IsStarted;
        END_METHOD

        METHOD PUBLIC Reset
            IsStarted := FALSE;
        END_METHOD

        METHOD PUBLIC Start   
            IsStarted := TRUE;
        END_METHOD
    END_CLASS

END_NAMESPACE

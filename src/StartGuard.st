USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.Cylinder
    
    CLASS StartGuard IMPLEMENTS IGuard
        
        VAR 
            _isStarted : BOOL;
        END_VAR
    
        METHOD PUBLIC Check : BOOL
            Check := _isStarted;
        END_METHOD

        METHOD PUBLIC Reset
            _isStarted := FALSE;
        END_METHOD

        METHOD PUBLIC Start   
            _isStarted := TRUE;
        END_METHOD
    END_CLASS

END_NAMESPACE

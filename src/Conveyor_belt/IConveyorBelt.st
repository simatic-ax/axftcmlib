NAMESPACE Simatic.Ax.axftcmlib
    INTERFACE IConveyorBelt
        METHOD MoveDuration
            VAR_INPUT
                ActiveTime : TIME;
            END_VAR
        END_METHOD
        METHOD MoveAbsolute
            VAR_INPUT
                TargetPosition : INT;
            END_VAR
        END_METHOD
        METHOD MoveRelative
            VAR_INPUT
                TargetPosition : INT;
            END_VAR
        END_METHOD
     END_INTERFACE
END_NAMESPACE


 

    
     
    //  METHOD MoveVelocity
    //  END_METHOD
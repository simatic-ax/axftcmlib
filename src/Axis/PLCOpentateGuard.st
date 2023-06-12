USING Simatic.Ax.StateFramework;
NAMESPACE Simatic.Ax.axftcmlib   
    CLASS PLCOpenstateGuard IMPLEMENTS IGuard

        VAR PUBLIC
            UsedAxis : REF_TO AXIS;
        END_VAR

        VAR 
            CurrentState : PlcOpenState;
        END_VAR

        
        METHOD PUBLIC Check : BOOL
            CurrentState := UsedAxis^.GetPlcOpenState();
           IF CurrentState = PlcOpenState#DONE THEN
            CHECK := TRUE;
           ELSE
            CHECK := FALSE;
           END_IF;
        END_METHOD

        METHOD PUBLIC Reset
            ;
        END_METHOD

    END_CLASS
END_NAMESPACE


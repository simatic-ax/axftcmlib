USING System.Timer;
NAMESPACE Simatic.Ax.axftcmlib

CLASS ConveyorBelt IMPLEMENTS IConveyorBelt

    VAR PUBLIC
        ConveyorIdle : BOOL;
        ConveyorBeltMototor : BOOL;
        IsHomed : BOOL;
        tOff : OffDelay;
        HomingPoint : BOOL;
    END_VAR

    METHOD PUBLIC MoveDuration //MoveRelative
        VAR_INPUT
            ActiveTime : TIME;
        END_VAR
        tOff(signal := TRUE, duration := ActiveTime);
        IF(tOff.output) THEN
        ConveyorBeltMototor := TRUE;
        ConveyorIdle := TRUE;
        IsHomed := FALSE;
        ELSE
            ConveyorBeltMototor := FALSE;
            ConveyorIdle := FALSE;   
        END_IF;
        ;
    END_METHOD

    METHOD PROTECTED Homing //"Basic Idea"
        IF IsHomed = FALSE THEN
            WHILE HomingPoint = FALSE DO
                 ConveyorBeltMototor := TRUE;
                 ConveyorIdle := TRUE;
            END_WHILE;
        END_IF;
        IsHomed := TRUE;
        ConveyorIdle := FALSE;
    END_METHOD

    METHOD PUBLIC MoveAbsolute //"Basic Idea"
        VAR_INPUT
            TargetPosition : INT;
        END_VAR
        VAR 
            TickCounter : INT;
        END_VAR;
        IF IsHomed = FALSE THEN
            THIS.Homing();
        END_IF;
        
        FOR TickCounter := 0 TO TargetPosition DO
            ConveyorBeltMototor := TRUE;
            ConveyorIdle := TRUE;
        END_FOR;

        ConveyorBeltMototor := FALSE;
        ConveyorIdle := FALSE;
        IsHomed := FALSE;
    END_METHOD

    METHOD PUBLIC MoveRelative //"Basic Idea"
        VAR_INPUT
            TargetPosition : INT;
        END_VAR
        VAR 
            TickCounter : INT;
        END_VAR;
        
        FOR TickCounter := 0 TO TargetPosition DO
            ConveyorBeltMototor := TRUE;
            ConveyorIdle := TRUE;
        END_FOR;

        ConveyorBeltMototor := FALSE;
        ConveyorIdle := FALSE;
        IsHomed := FALSE;
    END_METHOD

END_CLASS
    
END_NAMESPACE
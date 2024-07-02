USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    INTERFACE itfPosAxis EXTENDS itfSpeedAxis
    
    METHOD MoveAbsolute  : itfCommand 
        VAR_INPUT
            Position : LREAL; // Absolute target position
            Velocity : LReal := 100.0;
        END_VAR
    END_METHOD

    METHOD MoveRelative  : itfCommand 
        VAR_INPUT
            Distance : LREAL; // Distance for the positioning process (negative or positive)
            Velocity : LReal := 100.0;
        END_VAR
    END_METHOD

    METHOD HomeDirect  : itfCommand 
        VAR_INPUT
            Position : LREAL; // Distance for the positioning process (negative or positive)
        END_VAR
    END_METHOD


END_INTERFACE

END_NAMESPACE
USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    INTERFACE itfSpeedAxis EXTENDS itfAxis
    
    METHOD MoveVelocity : itfCommand 
        VAR_INPUT
            Velocity : LReal := 100.0;
            Direction : Direction := Direction#Forward;
        END_VAR
    END_METHOD

    METHOD Stop : itfCommand 
    END_METHOD

END_INTERFACE

END_NAMESPACE
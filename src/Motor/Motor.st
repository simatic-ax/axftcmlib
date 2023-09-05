USING Simatic.Ax.IO.Output;
USING Simatic.Ax.axftcmlib;

NAMESPACE Simatic.Ax.axftcmlib

    ///Class for creating a basic Motor 
    /// It supports two directions 
    /// It is used to power the axis
    CLASS MotorFT IMPLEMENTS IMotor
        VAR PUBLIC
            Forward : IBinOutput;
            Reverse : IBinOutput;
        END_VAR
        VAR PROTECTED
        END_VAR
        ///Starts the Motor with a given direction and velocity
        METHOD PUBLIC Move
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            IF (direction = Direction#Forward) THEN
                Forward.SetOn();
                Reverse.SetOff();
            ELSE
                Reverse.SetOn();
                Forward.SetOff();
            END_IF;
            ;
        END_METHOD
        ///Stops every movement of the Motor
        METHOD PUBLIC Halt
            Reverse.SetOff();
            Forward.SetOff();
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE
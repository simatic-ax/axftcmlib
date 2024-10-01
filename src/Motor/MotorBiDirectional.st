USING Simatic.Ax.IO.Output;
USING Simatic.Ax.axftcmlib;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    ///Class for creating a basic Motor 
    /// It supports two directions 
    /// It is used to power the axis
    CLASS MotorFT
        IMPLEMENTS IMotorBiDiretional
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
            IF (direction = Direction#PositiveDirection) THEN
                IF (Forward <> NULL) THEN
                    Forward.SetOn();
                END_IF;
                IF (Reverse <> NULL) THEN
                    Reverse.SetOff();
                END_IF;
            ELSE
                IF (Forward <> NULL) THEN
                    Forward.SetOff();
                END_IF;
                IF (Reverse <> NULL) THEN
                    Reverse.SetOn();
                END_IF;
            END_IF;
            ;
        END_METHOD
        ///Stops every movement of the Motor

        METHOD PUBLIC Halt
              IF (Forward <> NULL) THEN
                    Forward.SetOff();
                END_IF;
                IF (Reverse <> NULL) THEN
                    Reverse.SetOff();
                END_IF;
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE

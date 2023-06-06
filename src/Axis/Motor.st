USING Simatic.Ax.IO.Output;
USING Simatic.Ax.axftcmlib;

NAMESPACE Simatic.Ax.axftcmlib

    CLASS MotorFT
        IMPLEMENTS IMotor
        VAR PUBLIC
            Forward : IBinOutput;
            Reverse : IBinOutput;
        END_VAR
        VAR PROTECTED
        END_VAR
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
        METHOD PUBLIC Halt
            Reverse.SetOff();
            Forward.SetOff();
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE
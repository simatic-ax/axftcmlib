
NAMESPACE Simatic.Ax.axftcmlib
    INTERFACE IMotor
        METHOD Move
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
        END_METHOD
        METHOD Halt
        END_METHOD
    END_INTERFACE
END_NAMESPACE
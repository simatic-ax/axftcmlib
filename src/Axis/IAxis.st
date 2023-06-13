NAMESPACE Simatic.Ax.axftcmlib

    TYPE
        Direction : (Forward, Reverse, Undefined) := Forward;
    END_TYPE

    INTERFACE IAxis
        METHOD MoveVelocity
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
        END_METHOD
        METHOD MoveRelative : BOOL
            VAR_INPUT
                velocity : LREAL;
                distance : LINT;
            END_VAR
        END_METHOD
        METHOD MoveAbsolute : BOOL
            VAR_INPUT
                velocity : LREAL;
                position : LINT;
            END_VAR
        END_METHOD
        METHOD Halt
        END_METHOD
        METHOD Homing : BOOL
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
        END_METHOD
        METHOD Homing : BOOL
            VAR_INPUT
                Position : LINT;
            END_VAR
        END_METHOD
        METHOD IsHomed : BOOL
        END_METHOD
        METHOD IsRunning : BOOL
        END_METHOD
    END_INTERFACE

END_NAMESPACE
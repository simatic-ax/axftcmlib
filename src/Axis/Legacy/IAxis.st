NAMESPACE Simatic.Ax.axftcmlib

    TYPE
        Direction : (Forward, Reverse, Undefined) := Forward;
    END_TYPE

    ///Interface for implementing an axis 
    ///Contains basic functions needed for realising an axis
    INTERFACE IAxis
        ///Moves axis wit given velcity in a given direction
        METHOD MoveVelocity
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
        END_METHOD
        ///Moves axis to destination based on current position
        METHOD MoveRelative : BOOL
            VAR_INPUT
                velocity : LREAL;
                distance : LINT;
            END_VAR
        END_METHOD
        ///Moves axis to a new position based on the default position 
        METHOD MoveAbsolute : BOOL
            VAR_INPUT
                velocity : LREAL;
                position : LINT;
            END_VAR
        END_METHOD
        ///Stops axis
        METHOD Halt
        END_METHOD
        ///Moves axis into the default position
        METHOD Homing : BOOL
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
        END_METHOD
        ///Resets current position to deafult value without actual movement 
        METHOD Homing : BOOL
            VAR_INPUT
                Position : LINT;
            END_VAR
        END_METHOD
        ///Returns whether the defaultposition is set
        METHOD IsHomed : BOOL
        END_METHOD
        ///Returns whether the axis is busy with a movement command
        METHOD IsRunning : BOOL
        END_METHOD
    END_INTERFACE

END_NAMESPACE

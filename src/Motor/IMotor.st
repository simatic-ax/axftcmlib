
NAMESPACE Simatic.Ax.axftcmlib.Motion
    // This interface provides methods to control a unidirectional  motor.
    INTERFACE IMotor
        ///Starts the Motor with a given direction and velocity
        METHOD Move
            VAR_INPUT
                velocity : LREAL;
            END_VAR
        END_METHOD
        ///Stops every movement of the Motor
        METHOD Halt
        END_METHOD
    END_INTERFACE
    
    // This interface provides methods to control a bidirectional  motor.
    INTERFACE IMotorBiDiretional EXTENDS IMotor
        ///Starts the Motor with a given direction and velocity
        METHOD Move
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
        END_METHOD
        ///Stops every movement of the Motor
    END_INTERFACE
END_NAMESPACE
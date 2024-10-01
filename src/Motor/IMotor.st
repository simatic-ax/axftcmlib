
NAMESPACE Simatic.Ax.axftcmlib.Motion    
    // This interface provides methods to control a bidirectional  motor.
    INTERFACE IMotorBiDiretional
        ///Starts the Motor with a given direction and velocity
        METHOD Move
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
        END_METHOD
        ///Stops every movement of the Motor
        METHOD Halt
        END_METHOD
    END_INTERFACE
END_NAMESPACE
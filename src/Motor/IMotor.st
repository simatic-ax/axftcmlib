
NAMESPACE Simatic.Ax.axftcmlib.Motion
    ///This interface can be used to implement a motor for the axis
    /// It contains basic functions that are needed for the axis 
    INTERFACE IMotor
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
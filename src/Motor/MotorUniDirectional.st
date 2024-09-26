USING Simatic.Ax.IO.Output;
USING Simatic.Ax.axftcmlib;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    ///Class for creating a basic Motor 
    /// It supports two directions 
    /// It is used to power the axis
    CLASS MotorUniDirectional IMPLEMENTS IMotor
        VAR PUBLIC
            Forward : IBinOutput;
        END_VAR
        VAR PROTECTED
        END_VAR
        ///Starts the Motor with a given direction and velocity
        METHOD PUBLIC Move
            VAR_INPUT
                velocity : LREAL;
            END_VAR
            Forward.SetOn();
            ;
        END_METHOD
        ///Stops every movement of the Motor
        METHOD PUBLIC Halt
            Forward.SetOff();
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE
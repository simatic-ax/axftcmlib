NAMESPACE Simatic.Ax.axftcmlib
    INTERFACE IActuator
        METHOD Enable END_METHOD
        METHOD Disable END_METHOD
        METHOD GetState : ActuatorState
        END_METHOD
    END_INTERFACE
END_NAMESPACE
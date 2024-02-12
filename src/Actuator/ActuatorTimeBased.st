USING System.Timer;
USING Simatic.Ax.Io.Output;

NAMESPACE Simatic.Ax.axftcmlib

    CLASS ActuatorTimeBased
        EXTENDS ControlModuleAbstract
        IMPLEMENTS IActuator
        VAR PUBLIC
            ControlPush : IBinOutput;
            OnDuration : TIME;
        END_VAR
        VAR
            _tonOnDuration : OnDelay;
            _state : ActuatorState;
        END_VAR

        METHOD PROTECTED OVERRIDE _constructor
            ;
        END_METHOD

        METHOD PROTECTED OVERRIDE _runCyclicCustom
            IF (ControlPush = NULL) THEN 
                THIS.SetError(WORD#16#8101);
                RETURN;
            ELSE
                THIS.SetError(FALSE);
            END_IF;
            _tonOnDuration(signal := ControlPush.IsOn(), Duration := OnDuration);
            CASE _state OF
                ActuatorState#Retracted:
                    // IF () 
                    ControlPush.SetOff();
                ActuatorState#Activating:
                    ControlPush.SetOn();
                    _state := ActuatorState#Activated;
                ActuatorState#Activated:
                    IF (_tonOnDuration.output) THEN
                        _state := ActuatorState#Retracting;
                        ControlPush.SetOff();
                    END_IF;
                ActuatorState#Retracting:
                    ControlPush.SetOff();
                    _state := ActuatorState#Retracted;
            END_CASE;
        END_METHOD

        METHOD PUBLIC Enable
            _state := ActuatorState#Activating;
        END_METHOD

        METHOD PUBLIC Disable
            _state := ActuatorState#Retracted;
        END_METHOD

        METHOD PUBLIC GetState : ActuatorState
            GetState := _state;
        END_METHOD
    END_CLASS

END_NAMESPACE

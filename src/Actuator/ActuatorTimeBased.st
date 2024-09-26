USING Simatic.Ax.Commands;
USING System.Timer;
USING Simatic.Ax.Io.Output;

NAMESPACE Simatic.Ax.axftcmlib
    CLASS ActuatorTimeBased
        EXTENDS ExecuteControlModuleAbstract
        IMPLEMENTS IActuator
        VAR PUBLIC
            QControl : IBinOutput;
            OnDuration : TIME;
        END_VAR
        VAR
            _tonOnDuration : OnDelay;
            _state : ActuatorState;
        END_VAR

        METHOD PROTECTED OVERRIDE _initmethod
            ;
        END_METHOD

        METHOD PROTECTED OVERRIDE _executeCustom
            IF (QControl = NULL) THEN 
                THIS.SetError(WORD#16#8101);
                RETURN;
            ELSE
                THIS.SetError(FALSE);
            END_IF;
            _tonOnDuration(signal := QControl.IsOn(), Duration := OnDuration);
            CASE _state OF
                ActuatorState#Retracted:
                    // IF () 
                    QControl.SetOff();
                ActuatorState#Activating:
                    QControl.SetOn();
                    _state := ActuatorState#Activated;
                ActuatorState#Activated:
                    IF (_tonOnDuration.output) THEN
                        _state := ActuatorState#Retracting;
                        QControl.SetOff();
                    END_IF;
                ActuatorState#Retracting:
                    QControl.SetOff();
                    _state := ActuatorState#Retracted;
                    THIS.SetDone();
            END_CASE;
        END_METHOD

        METHOD PUBLIC Start : itfCommand
            THIS.InitState();
            _state := ActuatorState#Activating;
            Start := THIS;
        END_METHOD

        METHOD PUBLIC GetState : ActuatorState
            GetState := _state;
        END_METHOD
    
    END_CLASS

END_NAMESPACE

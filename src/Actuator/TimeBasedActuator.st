USING Simatic.Ax.Commands;
USING System.Timer;
USING Simatic.Ax.Io.Output;

NAMESPACE Simatic.Ax.axftcmlib
    CLASS TimeBasedActuator
        EXTENDS ExecuteControlModuleAbstract
        IMPLEMENTS itfActuator
        VAR PUBLIC
            Q_ToWorkPosition : IBinOutput;
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
            IF (Q_ToWorkPosition = NULL) THEN 
                THIS.SetError(WORD#16#8101);
                RETURN;
            ELSE
                THIS.SetError(FALSE);
            END_IF;
            _tonOnDuration(signal := Q_ToWorkPosition.IsOn(), Duration := OnDuration);
            CASE _state OF
                // Switch all outputs off, when actuator is idle in home position
                ActuatorState#InHomePosition:
                    Q_ToWorkPosition.SetOff();
                
                // Received the command GoToWorkPosition switch on ToWorkPosition
                ActuatorState#MoveToWorkPosition:
                    Q_ToWorkPosition.SetOn();
                    _state := ActuatorState#InWorkPosition;
                // After Timeout switch off "ToWorkPosition"
                ActuatorState#InWorkPosition:
                    IF (_tonOnDuration.output) THEN
                        _state := ActuatorState#MoveToHomePosition;
                        Q_ToWorkPosition.SetOff();
                    END_IF;
                // Send done
                ActuatorState#MoveToHomePosition:
                    Q_ToWorkPosition.SetOff();
                    _state := ActuatorState#InHomePosition;
                    THIS.SetDone();
            END_CASE;
        END_METHOD

        METHOD PUBLIC GoToWorkPosition : itfCommand
            THIS.InitState();
            _state := ActuatorState#MoveToWorkPosition;
            GoToWorkPosition := THIS;
        END_METHOD

        METHOD PUBLIC GetState : ActuatorState
            GetState := _state;
        END_METHOD
    
    END_CLASS

END_NAMESPACE

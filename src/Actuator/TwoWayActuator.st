USING Simatic.Ax.IO.Input;
USING Simatic.Ax.Commands;
USING System.Timer;
USING Simatic.Ax.Io.Output;

NAMESPACE Simatic.Ax.axftcmlib

    CLASS TwoWayActuator
        EXTENDS ExecuteControlModuleAbstract
        IMPLEMENTS itfTwoWayActuator
        VAR PUBLIC
            I_InHomePosition : IBinSignal;
            I_InWorkPosition : IBinSignal;
            Q_ToWorkPosition : IBinOutput;
            Q_ToHomePosition : IBinOutput;
        END_VAR
        VAR
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
            CASE _state OF
                // Switch all outputs off, when actuator is idle in home position
                ActuatorState#InHomePosition:
                    Q_ToWorkPosition.SetOff();
                    Q_ToHomePosition.SetOff();
                // Received the command GoToWorkPosition switch on ToWorkPosition
                ActuatorState#MoveToWorkPosition:
                    Q_ToWorkPosition.SetOn();
                    IF (I_InWorkPosition.Q()) THEN
                        Q_ToWorkPosition.SetOff();
                        THIS.SetDone();
                        _state := ActuatorState#InWorkPosition;
                    END_IF;
                ActuatorState#InWorkPosition:
                    Q_ToWorkPosition.SetOff();
                    Q_ToHomePosition.SetOff();
                ActuatorState#MoveToHomePosition:
                    Q_ToHomePosition.SetOn();
                    IF (I_InHomePosition.Q()) THEN
                        Q_ToHomePosition.SetOff();
                        THIS.SetDone();
                        _state := ActuatorState#InHomePosition;
                        THIS.SetDone();
                    END_IF;
            END_CASE;
        END_METHOD

        METHOD PUBLIC GoToWorkPosition : itfCommand
            THIS.InitState();
            _state := ActuatorState#MoveToWorkPosition;
            GoToWorkPosition := THIS;
        END_METHOD

        METHOD PUBLIC GoToHomePosition : itfCommand
            THIS.InitState();
            _state := ActuatorState#MoveToHomePosition;
            GoToHomePosition := THIS;
        END_METHOD

        METHOD PUBLIC GetState : ActuatorState
            GetState := _state;
        END_METHOD
    END_CLASS

END_NAMESPACE

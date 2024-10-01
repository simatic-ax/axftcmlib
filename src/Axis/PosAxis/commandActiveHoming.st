USING Simatic.Ax.IO.Input;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.Commands;
USING Simatic.Ax.IO.Input;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL commandActiveHoming
        EXTENDS ExecuteCommand
        VAR
            _AxisRef : REF_TO TO_PosAxis;
            _velocity : LREAL;
            _direction : Direction;
            _position : LREAL;
            _iRefSensor : IBinSignal;
            _exec : BOOL;
        END_VAR

        METHOD PUBLIC Start : itfCommand
            VAR_INPUT
                AxisRef : REF_TO TO_PosAxis;
                Velocity : LREAL := 100.0;
                Direction : Direction;
                Position : LREAL := 0.0;
                RefSensor : IBinSignal;
            END_VAR
            _AxisRef := AxisRef;
            _velocity := Velocity;
            _direction := Direction;
            _position := Position;
            _iRefSensor := RefSensor;
            THIS.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            IF NOT(_exec) THEN
                RETURN;
            END_IF;
            IF (NOT _AxisRef^.isPowerdOn) THEN
                THIS.SetError(WORD#16#8001);
            ELSE
                _AxisRef^.Run(TRUE);
                IF (_iRefSensor.QRis()) THEN
                    _AxisRef^.Run(FALSE);
                    _Done := _AxisRef^.SetPosition(value := _position);
                    ;
                END_IF;
            END_IF;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            _exec := exec;
            IF (exec) THEN
                THIS.InitState();
                IF (_AxisRef = NULL) THEN
                    THIS.SetError(WORD#16#8003);
                    RETURN;
                ELSIF (_iRefSensor = NULL) THEN
                    THIS.SetError(WORD#16#8004);
                    RETURN;
                END_IF;
                IF (NOT _AxisRef^.isPowerdOn) THEN
                    THIS.SetError(WORD#16#8001);
                ELSIF (_AxisRef^.IsRunning()) THEN
                    THIS.SetError(WORD#16#8002); // Can not be homed because axis is not stillstanding
                END_IF;
            END_IF;
        END_METHOD
    END_CLASS

END_NAMESPACE

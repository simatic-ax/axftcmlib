USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL commandMoveAbsolute
        EXTENDS ExecuteCommand
        VAR
            _AxisRef : REF_TO TO_PosAxis;
            _velocity : LREAL;
            _position : LREAL;
        END_VAR
        VAR PRIVATE
            _execute : BOOL;
        END_VAR

        METHOD PUBLIC Start : itfCommand
            VAR_INPUT
                AxisRef : REF_TO TO_PosAxis;
                Velocity : LREAL := LREAL#100.0;
                Position : LREAL := 0.0;
            END_VAR
            _AxisRef := AxisRef;
            _velocity := Velocity;
            _position := Position;
            // Determine Direction
            IF (_position < THIS._AxisRef^.GetPosition()) THEN
                _AxisRef^.Direction := Direction#NegativeDirection;
            ELSIF (_position > THIS._AxisRef^.GetPosition()) THEN
                _AxisRef^.Direction := Direction#PositiveDirection;
            ELSE // distance = 0 --> do nothing
                THIS.SetDone();
                RETURN;
            END_IF;
            THIS.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            VAR_TEMP
                _x : LREAL;
            END_VAR
            IF NOT (_execute) THEN
                THIS._Done := FALSE;
                THIS._Error := FALSE;
                RETURN;
            END_IF;
            
            // Axis must be powerd on and homed
            IF (NOT _AxisRef^.isPowerdOn) THEN
                THIS.SetError(WORD#16#8001);
                RETURN;
            ELSIF (NOT _AxisRef^.IsHomed()) THEN
                THIS.SetError(WORD#16#8003);
                RETURN;
            END_IF;
            _AxisRef^.Velocity := _velocity;
            _AxisRef^.Run(TRUE);
            _x := _AxisRef^.GetPosition();
            IF (_AxisRef^.Direction = Direction#NegativeDirection) THEN
                IF (_AxisRef^.GetPosition() <= _position) THEN
                    THIS.SetDone();
                    _AxisRef^.Run(FALSE);
                END_IF;
            ELSE
                IF (_AxisRef^.GetPosition() >= _position) THEN
                    THIS.SetDone();
                    _AxisRef^.Run(FALSE);
                END_IF;
            END_IF;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            _execute := exec;
        END_METHOD
    END_CLASS

END_NAMESPACE

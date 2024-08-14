USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL commandMoveAbsolute
        EXTENDS ExecuteCommand
        VAR
            _AxisRef : REF_TO TO_PosAxis;
            _velocity : LReal;
            _position : LREAL;
        END_VAR


        METHOD PUBLIC Start : itfCommand
            VAR_INPUT
                AxisRef : REF_TO TO_PosAxis;
                Velocity : LReal  := LReal#100.0;
                Position : LREAL := 0.0;
            END_VAR
            _AxisRef := AxisRef;
            _velocity := Velocity;
            _position := Position;
            THIS.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            IF (NOT _AxisRef^.isPowerdOn) THEN
                THIS.SetError(WORD#16#8001);
            ELSE
                IF (_AxisRef^.GetRelativePosition() >= _position) THEN
                    THIS.SetDone();
                END_IF;
            END_IF;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            IF (NOT _AxisRef^.isPowerdOn) THEN
                THIS.SetError(WORD#16#8001);
            ELSE
                IF (_position = _AxisRef^.GetPosition()) THEN
                    THIS.SetDone();
                    RETURN;
                END_IF;
                _AxisRef^.Run(TRUE);
                _AxisRef^.Velocity := _velocity;
            END_IF;
            
        END_METHOD
    END_CLASS

END_NAMESPACE

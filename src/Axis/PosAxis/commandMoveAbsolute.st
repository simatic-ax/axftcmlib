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
            _AxisRef^.Encoder.ResetRelative();
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            IF (NOT THIS._Error) THEN
                IF (_position < THIS._AxisRef^.GetPosition()) THEN
                    _AxisRef^.Direction := Direction#PositiveDirection;
                ELSIF (_position > THIS._AxisRef^.GetPosition()) THEN
                    _AxisRef^.Direction := Direction#NegativeDirection;
                ELSE  // distance = 0 --> do nothing
                    THIS.SetDone();
                    RETURN;
                END_IF;
                
                _AxisRef^.Velocity := _velocity;
                _AxisRef^.Run(TRUE);
            
                IF (_AxisRef^.GetPosition() >= _position) THEN
                    THIS.SetDone();
                END_IF;
            END_IF;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            THIS._Error := FALSE;
            IF (NOT _AxisRef^.isPowerdOn) THEN
                THIS.SetError(WORD#16#8001);
                RETURN;
            ELSIF (NOT _AxisRef^.IsHomed()) THEN
                THIS.SetError(WORD#16#8003);
                RETURN;
            END_IF;
        END_METHOD
    END_CLASS

END_NAMESPACE
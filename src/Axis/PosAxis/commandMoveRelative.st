USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL commandMoveRelative
        EXTENDS ExecuteCommand
        VAR
            _AxisRef : REF_TO TO_PosAxis;
            _velocity : LReal;
            _distance : LREAL;
        END_VAR


        METHOD PUBLIC Start : itfCommand
            VAR_INPUT
                AxisRef : REF_TO TO_PosAxis;
                Velocity : LReal  := LReal#100.0;
                Distance : LREAL := 0.0;
            END_VAR
            _AxisRef := AxisRef;
            _velocity := Velocity;
            _distance := Distance;
            THIS.ExecuteWithRisingEdge();
            Start := THIS;
            _AxisRef^.Encoder.ResetRelative();
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            IF (NOT THIS._Error) THEN
                IF (_distance > 0) THEN
                    _AxisRef^.Direction := Direction#PositiveDirection;
                ELSIF (_distance < 0) THEN
                    _AxisRef^.Direction := Direction#NegativeDirection;
                ELSE  // distance = 0 --> do nothing
                    THIS.SetDone();
                    RETURN;
                END_IF;
                
                _AxisRef^.Velocity := _velocity;
                _AxisRef^.Run(TRUE);
            
                IF (_AxisRef^.GetRelativePosition() >= _distance) THEN
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
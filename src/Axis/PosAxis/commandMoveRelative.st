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
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            IF (NOT _AxisRef^.isPowerdOn) THEN
                THIS.SetError(WORD#16#8001);
            ELSE
                ;
            END_IF;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            IF (NOT _AxisRef^.isPowerdOn) THEN
                THIS.SetError(WORD#16#8001);
            ELSE
                _AxisRef^.Run(TRUE);
                _AxisRef^.Velocity := _velocity;
            END_IF;
            
        END_METHOD
    END_CLASS

END_NAMESPACE

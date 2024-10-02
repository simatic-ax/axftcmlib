USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL commandMoveVelovity
        EXTENDS ExecuteCommand
        VAR
            _AxisRef : REF_TO TO_SpeedAxis;
            _velocity : LReal;
            _direction : Direction;
        END_VAR


        METHOD PUBLIC Start : itfCommand
            VAR_INPUT
                AxisRef : REF_TO TO_SpeedAxis;
                Velocity : LReal  := LReal#100.0;
                Direction : Direction := Direction#PositiveDirection;
            END_VAR
            _AxisRef := AxisRef;
            _velocity := Velocity;
            _direction := Direction;
            THIS.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            IF (NOT _AxisRef^.IsPoweredOn()) THEN
                THIS.SetError(WORD#16#8001);
            ELSE
                ;
            END_IF;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            IF (NOT _AxisRef^.IsPoweredOn()) THEN
                THIS.SetError(WORD#16#8001);
            ELSE
                _AxisRef^.Run(TRUE);
                _AxisRef^.Velocity := _velocity;
                _AxisRef^.Direction := _direction;
            END_IF;
            
        END_METHOD
    END_CLASS

END_NAMESPACE

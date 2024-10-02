USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL commandHomeDirect
        EXTENDS ExecuteCommand
        VAR
            _AxisRef : REF_TO TO_PosAxis;
            _position : LReal;
        END_VAR


        METHOD PUBLIC Start : itfCommand
            VAR_INPUT
                AxisRef : REF_TO TO_PosAxis;
                Position : LREAL := 0.0;
            END_VAR
            _AxisRef := AxisRef;
            _position := Position;
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
            IF (_AxisRef = NULL) THEN
                RETURN;
            END_IF;
            IF (NOT _AxisRef^.IsPoweredOn()) THEN
                THIS.SetError(WORD#16#8001);
            ELSIF (_AxisRef^.IsRunning()) THEN
                THIS.SetError(WORD#16#8002);  // Con not be homed because axis is not stillstanding
            ELSE
                _Done := _AxisRef^.SetPosition(value := _position);

            END_IF;
            
        END_METHOD
    END_CLASS

END_NAMESPACE

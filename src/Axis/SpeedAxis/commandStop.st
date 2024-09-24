USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL commandStop
        EXTENDS ExecuteCommand
        VAR
            _AxisRef : REF_TO TO_SpeedAxis;
        END_VAR


        METHOD PUBLIC Start : itfCommand
            VAR_INPUT
                AxisRef : REF_TO TO_SpeedAxis;
            END_VAR
            _AxisRef := AxisRef;
            THIS.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            ;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR

            _AxisRef^.Run(FALSE);
            THIS.SetDone();
            
        END_METHOD
    END_CLASS

END_NAMESPACE

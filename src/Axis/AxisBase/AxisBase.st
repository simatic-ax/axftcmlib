USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL ABSTRACT AxisBase IMPLEMENTS itfAxis
        VAR PROTECTED
            _AxisRef : REF_TO TO_Axis;     
        END_VAR

        METHOD PROTECTED ABSTRACT MakeAxisAbstract END_METHOD

        METHOD PUBLIC Attach
            VAR_INPUT
                axis : REF_TO TO_Axis;
            END_VAR
            _AxisRef := axis;
        END_METHOD

        METHOD PROTECTED IsAttached : BOOL
            IsAttached := _AxisRef <> NULL; 
        END_METHOD
        
        METHOD PUBLIC PowerOn
            _AxisRef^.isPowerdOn := TRUE; 
        END_METHOD

        METHOD PUBLIC PowerOff
            _AxisRef^.isPowerdOn := FALSE; 
        END_METHOD

    END_CLASS

END_NAMESPACE
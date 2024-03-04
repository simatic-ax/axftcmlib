USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS TO_Axis
        VAR PUBLIC
            isPowerdOn : BOOL; // Axis is powered on
        END_VAR        
    END_CLASS

    CLASS TO_SpeedAxis EXTENDS TO_Axis
        VAR PUBLIC
            Velocity : LReal  := LReal#100.0;
            Direction : Direction := Direction#Forward;
        END_VAR        
        VAR PROTECTED
            _isRuning : BOOL;
        END_VAR
        METHOD PUBLIC Run
            VAR_INPUT
                exec : BOOL;
            END_VAR
            
            _isRuning := exec;
        END_METHOD
        METHOD PUBLIC IsRunning : BOOL
            IsRunning := _isRuning;
        END_METHOD
    END_CLASS

END_NAMESPACE
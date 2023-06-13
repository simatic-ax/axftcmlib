USING Simatic.Ax.IO.Input;
USING System.Timer;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.axftcmlib
    CLASS Axis_Mock
        IMPLEMENTS IAxis
        VAR PUBLIC
            State : PlcOpenState;
        END_VAR
        VAR PROTECTED
        
        END_VAR

      
        //-----------------------------------------
        // interface implementation
        METHOD PUBLIC MoveVelocity
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            ;
        END_METHOD
        METHOD PUBLIC MoveRelative : BOOL
            VAR_INPUT
                velocity : LREAL;
                distance : LINT;
            END_VAR
;
        END_METHOD
        METHOD PUBLIC MoveAbsolute : BOOL
            VAR_INPUT
                velocity : LREAL;
                position : LINT;
            END_VAR
;
        END_METHOD
        METHOD PUBLIC Homing : BOOL
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            ;
        END_METHOD

        METHOD PUBLIC Homing : BOOL
            VAR_INPUT
                Position : LINT;
            END_VAR
            ;
        END_METHOD

        METHOD PUBLIC Halt
            ;
        END_METHOD
        METHOD PUBLIC IsHomed : BOOL
            ;
        END_METHOD
      
     
        //-------------------------------------------------------------------------------
        // Section for private methods
      

        METHOD PUBLIC IsRunning : BOOL
            IsRunning := State = PlcOpenstate#Busy;
        END_METHOD

END_CLASS

END_NAMESPACE
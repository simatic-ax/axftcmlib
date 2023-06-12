USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlChoseCylinder EXTENDS State1Transition
        VAR PUBLIC //Reset 
           SlAxis : AXIS;
           SlVelocity : LREAL;
           Sensor : BOOL;
           Color : INT;
           PosWHITE : LINT;
           PosRED : LINT;
           PosBLUE : LINT;
           
           
        END_VAR        
        METHOD PUBLIC OVERRIDE  OnEntry
            
            VAR
                value : LINT := 0;
            END_VAR
            
            IF Sensor = TRUE THEN
                SlAxis.Halt();
                SlAxis.Homing(value);
                IF Color = Colors#WHITE THEN
                    SlAxis.MoveRelative(SlVelocity,PosWHITE);
                ELSIF Color = Colors#RED THEN
                    SlAxis.MoveRelative(SlVelocity, PosRED);
                ELSE 
                    SlAxis.MoveRelative(SlVelocity, PosBLUE);
                END_IF;
            END_IF;

        END_METHOD
    END_CLASS

END_NAMESPACE
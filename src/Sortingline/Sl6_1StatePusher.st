USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL SlActivateCylinder EXTENDS State1Transition
        VAR PUBLIC //Reset 
            CylinderWhite : PneumaticCylinder;
            CylinderRed : PneumaticCylinder;
            CylinderBlue :  PneumaticCylinder;
           Color : INT;
        END_VAR        
        METHOD PUBLIC OVERRIDE  OnEntry
                IF Color = Colors#WHITE THEN
                    CylinderWhite.start();
                ELSIF Color = Colors#RED THEN
                    CylinderRed.start();
                ELSE 
                    CylinderBlue.start();
                END_IF;
        END_METHOD
    END_CLASS

END_NAMESPACE
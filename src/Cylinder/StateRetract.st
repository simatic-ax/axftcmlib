USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL StateRetracting EXTENDS State1Transition
        VAR PUBLIC
            Cylinder : IPneumaticCylinder;
        END_VAR        
        METHOD PUBLIC OVERRIDE OnEntry
            Cylinder.PneumaticCylinderRetract();
        END_METHOD
    END_CLASS

END_NAMESPACE
USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.Cylinder
    
    CLASS INTERNAL StatePushing EXTENDS State1Transition
        VAR PUBLIC
            Cylinder : IPneumaticCylinder;
        END_VAR        

        METHOD PUBLIC OVERRIDE OnEntry
            Cylinder.PneumaticCylinderPush();          
        END_METHOD

    END_CLASS

END_NAMESPACE
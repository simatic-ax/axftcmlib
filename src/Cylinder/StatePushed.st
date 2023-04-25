USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.Cylinder
    
    CLASS INTERNAL StatePushed EXTENDS State1Transition
        VAR PUBLIC
            Cylinder : IPneumaticCylinder;
        END_VAR        
    END_CLASS

END_NAMESPACE
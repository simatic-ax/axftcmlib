USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.axftcmlib
    
    CLASS INTERNAL StateRetracted EXTENDS State1Transition
        VAR PUBLIC
            Cylinder : IPneumaticCylinder;
        END_VAR
    END_CLASS

END_NAMESPACE
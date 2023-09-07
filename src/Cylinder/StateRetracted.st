USING Simatic.Ax.StateFramework;

NAMESPACE Simatic.Ax.axftcmlib
    ///Coil is fully retracted, Start/ default state
    CLASS INTERNAL StateRetracted EXTENDS State1Transition
        VAR PUBLIC
            Cylinder : IPneumaticCylinder;
        END_VAR
    END_CLASS

END_NAMESPACE
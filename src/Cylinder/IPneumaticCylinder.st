NAMESPACE Simatic.Ax.axftcmlib
    ///Interface for implementing a pneumatic cylinder
    ///Contains basic functions needed for realising a cylinder
    INTERFACE IPneumaticCylinder
    //Activates valve to push the coil
        METHOD PneumaticCylinderPush
        END_METHOD
    //deactivates the valve to retract the cylinder
        METHOD PneumaticCylinderRetract
        END_METHOD
    END_INTERFACE
END_NAMESPACE
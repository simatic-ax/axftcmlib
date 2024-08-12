///Interface for a class compressor
///contains the basic functions neede for the Fischertechnik models  
/// Is used to power a pneumatic cylinder 
NAMESPACE Simatic.Ax.axftcmlib

    INTERFACE itfPowerableDevice
        ///turns the device on
        METHOD PowerOn
        END_METHOD
        ///turns the device off
        METHOD PowerOff
        END_METHOD
        /// Is powered On
        METHOD IsPoweredOn : BOOL
        END_METHOD
    END_INTERFACE

END_NAMESPACE

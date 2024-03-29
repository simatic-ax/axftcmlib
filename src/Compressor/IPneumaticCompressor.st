///Interface for a class compressor
///contains the basic functions neede for the Fischertechnik models  
/// Is used to power a pneumatic cylinder 
NAMESPACE Simatic.Ax.axftcmlib
INTERFACE IPneumaticCompressor
        ///turns the compressor on
        METHOD PneumaticCompressorOn
        END_METHOD

        ///turns the compressor off
        METHOD PneumaticCompressorOff
        END_METHOD
    END_INTERFACE

END_NAMESPACE
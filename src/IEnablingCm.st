///Interface for a class compressor
///contains the basic functions neede for the Fischertechnik models  
/// Is used to power a pneumatic cylinder 
USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib
INTERFACE IEnablingCm
        ///turns the compressor on
        METHOD Enable : itfCommand
        END_METHOD

        ///turns the compressor off
        METHOD Disable : itfCommand
        END_METHOD
    END_INTERFACE

END_NAMESPACE
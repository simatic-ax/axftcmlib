USING Simatic.Ax.IO.Input;
USING Simatic.Ax.IO.Output;

NAMESPACE Simatic.Ax.axftcmlib
    ///Implementation of the Compressor interface
    /// needs an IBinOutout that is used to write on the PLC-Variables
    CLASS  PneumaticCompressor IMPLEMENTS  IPneumaticCompressor

        VAR PUBLIC
             ActiveCompressor : IBinOutput;
        END_VAR
        
        ///turns the compressor on
        METHOD PUBLIC PneumaticCompressorOn
           ActiveCompressor.SetOn() ;
        END_METHOD

        ///turns the compressor off
        METHOD PUBLIC PneumaticCompressorOff
            ActiveCompressor.SetOff();
        END_METHOD
    END_CLASS

END_NAMESPACE
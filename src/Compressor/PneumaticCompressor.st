USING Simatic.Ax.IO.Input;

USING Simatic.Ax.IO.Output;
NAMESPACE Simatic.Ax.axftcmlib

    CLASS  PneumaticCompressor IMPLEMENTS  IPneumaticCompressor

        VAR PUBLIC
             ActiveCompressor : IBinOutput;
        END_VAR

        METHOD PUBLIC PneumaticCompressorOn
           ActiveCompressor.SetOn() ;
        END_METHOD

        METHOD PUBLIC PneumaticCompressorOff
            ActiveCompressor.SetOff();
        END_METHOD
    END_CLASS


//     class BinSignalGuard implements IGuard

//     var PUBLIC signal : IBinSignal;
//     end_var
//     METHOD PUBLIC Check : BOOL
//         Check := signal.Q();
//     END_METHOD

//     METHOD PUBLIC Reset
//         ;
//     END_METHOD
// END_CLASS

END_NAMESPACE
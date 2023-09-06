USING Simatic.Ax.StateFramework;
USING Simatic.Ax.IO.Input;
NAMESPACE Simatic.Ax.axftcmlib   
   
    CLASS BinSignalRiseGuard IMPLEMENTS IGuard
        VAR PUBLIC
           BinSignal : IBinSignal;
        END_VAR
    
        METHOD PUBLIC Check : BOOL
            Check := (BinSignal.QRis());
        END_METHOD
    
        METHOD PUBLIC Reset
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE
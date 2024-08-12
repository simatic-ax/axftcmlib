USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;

NAMESPACE Simatic.Ax.axftcmlib

    ///Implementation of the Compressor interface
    /// needs an IBinOutout that is used to write on the PLC-Variables
    CLASS Compressor
        EXTENDS ControlModuleAbstract
        IMPLEMENTS itfPowerableDevice
        VAR PUBLIC
            ControlQ : IBinOutput;
        END_VAR
        VAR PROTECTED
            _compressor : IBinOutput;
        END_VAR
        ///turns the compressor on

        METHOD PUBLIC PowerOn
            IF (_compressor <> NULL) THEN
                ControlQ.SetOn();
            END_IF;
        END_METHOD
        ///turns the compressor off

        METHOD PUBLIC PowerOff
            IF (_compressor <> NULL) THEN
                ControlQ.SetOff();
            END_IF;
        END_METHOD

        METHOD PUBLIC IsPoweredOn : BOOL
            IF (_compressor <> NULL) THEN
                IsPoweredOn := ControlQ.IsOn();
            ELSE
                IsPoweredOn := FALSE;
            END_IF;
        END_METHOD

        METHOD PROTECTED OVERRIDE _runCyclicCustom
            ;
        END_METHOD

        METHOD PROTECTED OVERRIDE _constructor
            ;
        END_METHOD
    

    END_CLASS

END_NAMESPACE

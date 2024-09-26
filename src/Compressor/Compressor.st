USING Simatic.Ax.IO.Input;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib

    ///Implementation of the Compressor interface
    /// needs an IBinOutout that is used to write on the PLC-Variables
    CLASS Compressor
        EXTENDS EnablingControlModuleAbstract
        IMPLEMENTS IEnablingCm
        VAR PUBLIC
            QControl : IBinOutput;
        END_VAR
        ///turns the compressor on

        METHOD PUBLIC Enable : itfCommand
            IF QControl = NULL THEN
                Enable := THIS;
                RETURN;
            END_IF;
            QControl.SetOn();
            THIS.InitState();
            Enable := THIS;
        END_METHOD
        ///turns the compressor off

        METHOD PUBLIC Disable : itfCommand
            Disable := THIS;
            IF THIS._Error THEN
                RETURN;
            END_IF;
            QControl.SetOff();
            THIS.SetDone();
        END_METHOD

        METHOD PROTECTED OVERRIDE _executeCustom
            IF THIS._Error THEN
                RETURN;
            END_IF;
            QControl.SetOn();
        END_METHOD

        METHOD PROTECTED OVERRIDE _initmethod
            IF (QControl = NULL) THEN
                THIS.SetError(WORD#16#8001);
            END_IF;
        END_METHOD
    END_CLASS

END_NAMESPACE

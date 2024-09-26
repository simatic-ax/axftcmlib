USING Simatic.Ax.SimpleControlModules;
USING Siemens.Simatic.S71500.TechnologyObjects;

NAMESPACE Simatic.Ax.axftcmlib
CLASS TmCountEncoder implements IEncoder
    VAR PUBLIC
        HWID : WORD;
        ChannelNo : INT;
    END_VAR
    VAR PRIVATE
        hsc: HighSpeedCounter;
        hwConfig : HSC_Configuration;
        ParmIn : PRAM_IN;
        PramOut : PRAM_OUT;
        _relativeCount : LINT;
        _actualValue : LINT;
        _actualValueOld : LINT := 0;
    END_VAR
    

    METHOD PUBLIC Evaluate
        hwConfig.HWID := HWID;
        hwConfig.ChannelNo := ChannelNo;
        ParmIn.SwGate := TRUE;
        hsc.Process(hwConfig,ParmIn,PramOut);
        _actualValue := PramOut.CapturedValue;
        IF _actualValueOld <> 0 THEN  
            // Berechnung der relativen Änderung  
            _relativeCount := (_actualValue - _actualValueOld);  
        ELSE  
            // Initiale Bedingung, wenn PreviousValue 0 ist, um Division durch 0 zu vermeiden  
            _relativeCount := 0;  
        END_IF;
        _actualValueOld := _actualValue;
    END_METHOD

    METHOD PUBLIC Reset
        ParmIn.SetCountValue := TRUE;
        hwConfig.Values.StartValue := 0;
        hsc.Process(hwConfig,ParmIn,PramOut);
        ParmIn.SetCountValue := FALSE;
    END_METHOD

    METHOD PUBLIC SetValue
        VAR_INPUT
            value : LINT;
        END_VAR
        ParmIn.SetCountValue := TRUE;
        hwConfig.Values.StartValue := TO_DINT(value);
        hsc.Process(hwConfig,ParmIn,PramOut);
        ParmIn.SetCountValue := FALSE;
        _actualValue := value;
        _actualValueOld := value;
        ;
    END_METHOD

    METHOD PUBLIC GetValue : LINT
        GetValue := _actualValue;
        ;
    END_METHOD

    METHOD PUBLIC SetDirection
        VAR_INPUT
            mode : CountMode;
        END_VAR

        ;
    END_METHOD

    METHOD PUBLIC RelativeCount : LINT
        RelativeCount := _relativeCount;
    END_METHOD

    METHOD PUBLIC ResetRelative
        _relativeCount := 0;
        _actualValueOld := _actualValue;
    END_METHOD

    METHOD PUBLIC GetModulo : LINT
        ;
    END_METHOD
END_CLASS

END_NAMESPACE

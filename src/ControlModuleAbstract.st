NAMESPACE Simatic.Ax.axftcmlib
    ///Provides basic functionality for programming on a plc
    /// has acces to the protected Methods and "Contructors" of the classes
    CLASS ABSTRACT ControlModuleAbstract
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            _init : BOOL;
            _hasError : BOOL;
            _errorState : WORD;
        END_VAR
        
        METHOD PUBLIC RunCyclic
            IF (NOT _init) THEN
                THIS._constructor();
                _init := TRUE;
            END_IF;
           THIS._runCyclicCustom();
            ;
        END_METHOD

        METHOD PROTECTED ABSTRACT _runCyclicCustom
            
        END_METHOD

        METHOD PROTECTED ABSTRACT _constructor
            
        END_METHOD

        METHOD PROTECTED SetError
            VAR_INPUT
                ErrorCode : WORD;
            END_VAR
            _errorState := ErrorCode;
            _hasError := TRUE;
            ;
        END_METHOD

        METHOD PROTECTED SetError
            VAR_INPUT
                Set : BOOL;
            END_VAR
            _hasError := Set;
            ;
        END_METHOD

        // control module has an error
        METHOD PUBLIC HasError : BOOL;
            HasError := _hasError;
        END_METHOD

        METHOD PUBLIC GetErrorStatus : WORD
            GetErrorStatus := _errorState;
        END_METHOD

    END_CLASS
    
END_NAMESPACE
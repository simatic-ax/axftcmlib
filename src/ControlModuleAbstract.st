USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib
    ///Provides basic functionality for programming on a plc
    /// has acces to the protected Methods and "Contructors" of the classes
    CLASS ABSTRACT ControlModuleAbstract EXTENDS ExecuteCommand
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            _init : BOOL;
            _hasError : BOOL;
            _errorState : WORD;
            _exec : BOOL;
        END_VAR
        
        METHOD PROTECTED OVERRIDE Execute
            IF (NOT _init) THEN
                THIS._initmethod();
                _init := TRUE;
            END_IF;
           THIS._executeCustom();
            ;
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            _exec := exec;
            IF (_exec) THEN
                THIS.InitState();
            END_IF;
            ;
        END_METHOD

        METHOD PROTECTED ABSTRACT _executeCustom
            
        END_METHOD

        METHOD PROTECTED ABSTRACT _initmethod
            
        END_METHOD


        METHOD PUBLIC GetErrorStatus : WORD
            GetErrorStatus := _errorState;
        END_METHOD

    END_CLASS
    
END_NAMESPACE
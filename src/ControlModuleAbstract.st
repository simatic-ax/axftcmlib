NAMESPACE Simatic.Ax.axftcmlib
    ///Provides basic functionality for programming on a plc
    /// has acces to the protected Methods and "Contructors" of the classes
    CLASS ABSTRACT ControlModuleAbstract
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            _init : BOOL;
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
    END_CLASS
    
END_NAMESPACE
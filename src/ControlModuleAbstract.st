NAMESPACE Simatic.Ax.axftcmlib
    CLASS ABSTRACT ControlModuleAbstract
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            _init : BOOL;
        END_VAR
        
        METHOD PUBLIC RunCyclic
            IF (NOT _init) THEN
                THIS.Constructor();
                _init := TRUE;
            END_IF;
           THIS.RunCyclicCustom();
            ;
        END_METHOD

        METHOD PROTECTED ABSTRACT RunCyclicCustom
            
        END_METHOD

        METHOD PROTECTED ABSTRACT Constructor
            
        END_METHOD
    END_CLASS
    
END_NAMESPACE
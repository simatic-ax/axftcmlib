USING Siemens.Simatic.S71500.Clocks;
NAMESPACE Simatic.Ax.axftcmlib

    INTERFACE ITimeprovider
        Method GetElapsedSeconds :LREAL
        END_METHOD
    END_INTERFACE


    CLASS TimeProvider Implements ITimeprovider

    VAR
     _measurement : RuntimeMeasurement;
     _timeOfOperations : LTIME;
    END_VAR 

    METHOD PUBLIC GetElapsedSeconds : LREAL
            _timeOfOperations := _measurement.Stop();
            GetElapsedSeconds := _measurement.GetElapsedSeconds();//time passed in seconds
            _measurement.Start();
    END_METHOD

    END_CLASS

    CLASS TimeProviderMOCK_100ms_const Implements ITimeprovider

        VAR
         _measurement : RuntimeMeasurement;
         _timeOfOperations : LTIME;
        END_VAR 
    
        METHOD PUBLIC GetElapsedSeconds : LREAL
              GetElapsedSeconds := 0.1;
        END_METHOD
    
        END_CLASS

END_NAMESPACE



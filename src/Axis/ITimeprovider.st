USING Siemens.Simatic.S71500.Clocks;

NAMESPACE Simatic.Ax.axftcmlib

    INTERFACE ITimeprovider
        METHOD GetElapsedSeconds : LREAL
        END_METHOD
    END_INTERFACE

    /// Timeprovider based on RuntimeMeasurement
    CLASS TimeProvider
        IMPLEMENTS ITimeprovider
        VAR
            _measurement : RuntimeMeasurement;
            _elapsedTimeInSeconds : LREAL;
        END_VAR

        // mus be called in every cycle
        METHOD PUBLIC Evaluate
            _measurement.Stop();
            _elapsedTimeInSeconds := _measurement.GetElapsedSeconds(); //time passed in seconds
            _measurement.Start();
        END_METHOD

        METHOD PUBLIC GetElapsedSeconds : LREAL
            GetElapsedSeconds := _elapsedTimeInSeconds;
        END_METHOD
    END_CLASS

    /// Mock for a ITimePrivider wich returns always 100ms.
    CLASS TimeProviderMOCK_100ms_const
        IMPLEMENTS ITimeprovider

        METHOD PUBLIC GetElapsedSeconds : LREAL
            GetElapsedSeconds := 0.1;
        END_METHOD
    END_CLASS

END_NAMESPACE

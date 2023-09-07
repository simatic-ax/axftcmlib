NAMESPACE Simatic.Ax.axftcmlib
/// Mock for a ITimePrivider wich returns always 100ms.
    CLASS TimeProviderMOCK_100ms_const
        IMPLEMENTS ITimeprovider

        METHOD PUBLIC GetElapsedSeconds : LREAL
         GetElapsedSeconds := 0.1;
        END_METHOD
    END_CLASS

END_NAMESPACE
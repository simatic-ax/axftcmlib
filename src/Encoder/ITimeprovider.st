USING Siemens.Simatic.S71500.Clocks;
NAMESPACE Simatic.Ax.axftcmlib
    ///Interface to implement a Timeprovider
    /// is used to generate the cycletime of the cpu 
    /// is needed for the TimeBasedEncoder
    INTERFACE ITimeprovider
        ///Measures the current cycletime
        METHOD GetElapsedSeconds : LREAL
        END_METHOD
    END_INTERFACE

END_NAMESPACE

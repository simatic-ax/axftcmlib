USING Siemens.Simatic.S71500.Clocks;
 NAMESPACE Simatic.Ax.axftcmlib   
    
    /// Timeprovider based on RuntimeMeasurement
    CLASS TimeProvider IMPLEMENTS ITimeprovider
        VAR
            Measurement : RuntimeMeasurement;
            ElapsedTimeInSeconds : LREAL;
        END_VAR

        /// Measures the current cycle time of the cpu
        // must be called in every cycle
        METHOD PUBLIC Evaluate
            Measurement.Stop();
            ElapsedTimeInSeconds := Measurement.GetElapsedSeconds(); //time passed in seconds
            Measurement.Start();
        END_METHOD

        //Outputs the current time that was measured 
        METHOD PUBLIC GetElapsedSeconds : LREAL
            GetElapsedSeconds := ElapsedTimeInSeconds;
        END_METHOD
    END_CLASS

  
END_NAMESPACE
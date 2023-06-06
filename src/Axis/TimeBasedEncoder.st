USING Simatic.Ax.SimpleControlModules;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;
USING System.Timer;

NAMESPACE Simatic.Ax.axftcmlib

    CLASS TimeBasedEncoder
        IMPLEMENTS IEncoder
        VAR PUBLIC
            Velocity : LREAL; // m/s
            EncoderAxis : IAxis;
            TimeProvider : ITimeprovider;
        END_VAR
        VAR PROTECTED
            _position : LREAL; // pos in [m]eter
        END_VAR
        /// Reset encoder position to zero

        METHOD PUBLIC Reset
            _position := 0.0;
        END_METHOD
        /// Set encoder to specific position
        /// value : Position which is set

        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LINT;
            END_VAR
            _position := TO_LREAL(value);
        END_METHOD
        /// Returns the actual encoder position
        /// Actual encoder position

        METHOD PUBLIC GetValue : LINT  // [mm]
            GetValue := TO_LINT(_position * 1000.0); // Convert m to mm 
        END_METHOD
        /// Evaluate encoder signals

        METHOD PUBLIC Evaluate
            VAR_TEMP
                ds : LREAL;
                dt : LREAL;
            END_VAR
            dt := TimeProvider.GetElapsedSeconds(); //time passed in seconds
            ds := Velocity * dt;
            IF (EncoderAxis <> NULL) THEN
                IF (EncoderAxis.IsRunning()) THEN //If Axis is running
                    _position := _position + ds;
                END_IF;
            END_IF;
        END_METHOD
        //=========================================================
        /// Returns if the encoder has moved
        /// Encoder has moved

        METHOD PUBLIC HasMoved : BOOL
            // HasMoved := _encoderHasMoved;
            // _encoderHasMoved := FALSE;
            ;
        END_METHOD
        /// Counts the relative pulses since the last Reset or ResetRelative command

        METHOD PUBLIC RelativeCount : LINT
            //RelativeCount := _encoderRelativeCounter.CounterValue() MOD Modulo;
            ;
        END_METHOD
        /// Reset the relative counter

        METHOD PUBLIC ResetRelative
            //_encoderRelativeCounter.SetCounterValue(LINT#0);
            ;
        END_METHOD

        METHOD PUBLIC SetDirection
            VAR_INPUT
                mode : CountMode;
            END_VAR
            ;
        END_METHOD

        METHOD PUBLIC GetModulo : LINT
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE

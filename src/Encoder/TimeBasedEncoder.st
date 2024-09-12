USING Simatic.Ax.axftcmlib.Motion;
USING Simatic.Ax.SimpleControlModules;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;
USING System.Timer;
USING Simatic.Ax.axftcmlib.Motion;

NAMESPACE Simatic.Ax.axftcmlib
    ///Used to track the Position of the axis based on time
    ///Encoder used to mimic the regular encoder featured in the Fischertechnik modell
    /// Needs to have acces to the status of the used axis 
    CLASS TimeBasedEncoder IMPLEMENTS IEncoder
        VAR PUBLIC
            Velocity : LREAL; // m/s
            TO_Axis : REF_TO TO_PosAxis;
            TimeProvider : ITimeprovider;
        END_VAR
        VAR PROTECTED
            _position : LREAL; // pos in [m]eter
            _positionRelative : LREAL;
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
        METHOD PUBLIC GetValue : LINT  // [mm]
            GetValue := TO_LINT(_position * 1000.0); // Convert m to mm 
        END_METHOD

        //Calculates the change in position based on the passed time and the velocity
        METHOD PUBLIC Evaluate
            VAR_TEMP
                ds : LREAL;
                dt : LREAL;
            END_VAR
            dt := TimeProvider.GetElapsedSeconds(); //time passed in seconds
            ds := Velocity * dt;
            
            IF (TO_Axis^.Direction = Motion.Direction#NegativeDirection) THEN
                ds := ds * -1.0;
            END_IF;
            IF (TO_Axis <> NULL) THEN
                IF (TO_Axis^.IsRunning()) THEN //If Axis is running
                    _position := _position + ds;
                END_IF;
            END_IF;
        END_METHOD

        ///The following methods are implemented because of the Interface 
        /// currently they serve no other purpose 
        METHOD PUBLIC HasMoved : BOOL
            ;
        END_METHOD

        METHOD PUBLIC RelativeCount : LINT
            RelativeCount := TO_LINT(_positionRelative * 1000.0);;
        END_METHOD

        METHOD PUBLIC ResetRelative
            _positionRelative := 0.0;
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

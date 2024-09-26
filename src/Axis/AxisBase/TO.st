USING Simatic.Ax.SimpleControlModules;
USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS INTERNAL TO_Axis
        VAR PUBLIC
            isPowerdOn : BOOL; // Axis is powered on
        END_VAR        
    END_CLASS

    CLASS TO_SpeedAxis EXTENDS TO_Axis
        VAR PUBLIC
            Velocity : LReal  := LReal#100.0;
            Direction : Direction := Direction#PositiveDirection;
            Motor : IMotorBiDiretional;
        END_VAR        
        VAR PROTECTED
            _isRuning : BOOL;
        END_VAR
        METHOD PUBLIC Run
            VAR_INPUT
                exec : BOOL;
            END_VAR
            
            _isRuning := exec;

            IF (Motor <> NULL) THEN                
                IF (_isRuning) THEN
                    // Motor.Move(direction := Direction, velocity := Velocity);
                    Motor.Move(velocity := Velocity, direction := Direction);
                ELSE
                    Motor.Halt();
                END_IF;
            END_IF;

        END_METHOD
        METHOD PUBLIC IsRunning : BOOL
            IsRunning := _isRuning;
        END_METHOD
    END_CLASS

    CLASS TO_PosAxis EXTENDS TO_SpeedAxis
        VAR PUBLIC
            Encoder : IEncoder;
            EncoderResolution : LREAL := 1.0; //mm / pulse
        END_VAR        
        VAR PRIVATE
            _position : LREAL;
            _isHomed : BOOL;
        END_VAR
        VAR PROTECTED
        END_VAR

        METHOD PUBLIC SetPosition : BOOL
            VAR_INPUT
                value : LREAL;
            END_VAR
            
            VAR_TEMP
                _pulses : LINT;
            END_VAR
            
            IF (Encoder <> NULL) THEN
                IF EncoderResolution = 0.0 THEN
                    SetPosition := FALSE;
                    RETURN;
                END_IF;      
                _pulses := TO_LINT(value / EncoderResolution);
                Encoder.SetValue(value := _pulses);
                SetPosition := TRUE;
                _isHomed := TRUE;
            END_IF;
        END_METHOD


        METHOD PUBLIC GetRelativePosition : LREAL
            VAR_TEMP
                _pulses : LINT;
            END_VAR
            
            IF (Encoder <> NULL) THEN
                _pulses := Encoder.RelativeCount();
                GetRelativePosition := EncoderResolution * TO_LREAL(_pulses);
            END_IF;
        END_METHOD

        METHOD PUBLIC GetPosition : LREAL
            VAR_TEMP
                _pulses : LINT;
            END_VAR
            
            IF (Encoder <> NULL) THEN
                _pulses := Encoder.GetValue();
                GetPosition := EncoderResolution * TO_LREAL(_pulses);
            END_IF;
        END_METHOD
        METHOD PUBLIC IsHomed : BOOL
            IsHomed := _isHomed;
        END_METHOD
    END_CLASS
END_NAMESPACE
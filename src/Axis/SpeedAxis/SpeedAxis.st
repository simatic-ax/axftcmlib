USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS SpeedAxis
        EXTENDS SpeedAxisImpl

        METHOD PUBLIC Attach : BOOL
            VAR_INPUT
                axis : REF_TO TO_SpeedAxis;
            END_VAR
            _SpeedAxisRef := axis;
            SUPER.Attach(axis);
            Attach := THIS.IsAttached();
        END_METHOD
    END_CLASS

    CLASS INTERNAL SpeedAxisImpl
        EXTENDS AxisBase
        IMPLEMENTS itfSpeedAxis
        VAR PROTECTED
            _SpeedAxisRef : REF_TO TO_SpeedAxis;
            _commandMoveVelocity : commandMoveVelovity;
            _commandStop : commandStop;
        END_VAR

        METHOD PUBLIC MoveVelocity : itfCommand
            VAR_INPUT
                Velocity : LREAL := 100.0;
                Direction : Direction := Direction#PositiveDirection;
            END_VAR
            MoveVelocity := _commandMoveVelocity.Start(AxisRef := _SpeedAxisRef, Velocity := Velocity, Direction := Direction);
        END_METHOD

        METHOD PUBLIC Stop : itfCommand
            Stop := _commandStop.Start(AxisRef := _SpeedAxisRef);
        END_METHOD

        METHOD PROTECTED OVERRIDE MakeAxisAbstract
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE

USING Simatic.Ax.IO.Input;
USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS PosAxis
        EXTENDS PosAxisImpl

        METHOD PUBLIC Attach : BOOL
            VAR_INPUT
                axis : REF_TO TO_PosAxis;
            END_VAR
            ;
            _PosAxisRef := axis;
            _SpeedAxisRef := axis;
            SUPER.Attach(axis);
            Attach := THIS.IsAttached();
        END_METHOD
    END_CLASS

    CLASS INTERNAL PosAxisImpl
        EXTENDS SpeedAxisImpl
        IMPLEMENTS itfPosAxis
        VAR PROTECTED
            _PosAxisRef : REF_TO TO_PosAxis;
            _commandMoveRelative : commandMoveRelative;
            _commandMoveAbsolute : commandMoveAbsolute;
            _commandHomeDirect : commandHomeDirect;
            _commandActiveHoming : commandActiveHoming;
        END_VAR

        METHOD PROTECTED OVERRIDE MakeAxisAbstract
            ;
        END_METHOD

        METHOD PUBLIC MoveAbsolute : itfCommand
            VAR_INPUT
                Position : LREAL;
                Velocity : LREAL := 100.0;
            END_VAR
            MoveAbsolute := _commandMoveAbsolute.Start(AxisRef := _PosAxisRef, Position := Position, Velocity := Velocity);
            ;
        END_METHOD

        METHOD PUBLIC MoveRelative : itfCommand
            VAR_INPUT
                Distance : LREAL := 0.0;
                Velocity : LREAL := 100.0;
            END_VAR
            MoveRelative := _commandMoveRelative.Start(AxisRef := _PosAxisRef, Distance := Distance, Velocity := Velocity);
            ;
        END_METHOD

        METHOD PUBLIC HomeDirect : itfCommand
            VAR_INPUT
                Position : LREAL;
            END_VAR
            HomeDirect := _commandHomeDirect.Start(AxisRef := _PosAxisRef, Position := Position);
        END_METHOD

        METHOD PUBLIC ActiveHoming : itfCommand
            VAR_INPUT
                Position : LREAL;
                Direction : Direction;
                RefSensor : IBinSignal;
            END_VAR
            ActiveHoming := _commandActiveHoming.Start(AxisRef := _PosAxisRef, Direction := Direction, Position := Position, RefSensor := RefSensor);
        END_METHOD
    END_CLASS

END_NAMESPACE

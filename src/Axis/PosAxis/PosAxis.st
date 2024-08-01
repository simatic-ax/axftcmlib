USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    CLASS PosAxis
        EXTENDS PosAxisImpl

        METHOD INTERNAL Attach : BOOL
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
            _commandHomeDirect : commandHomeDirect;
        END_VAR

        METHOD PROTECTED OVERRIDE MakeAxisAbstract
            ;
        END_METHOD

        METHOD PUBLIC MoveAbsolute : itfCommand
            VAR_INPUT
                Position : LREAL;
                Velocity : LREAL := 100.0;
            END_VAR
            MoveAbsolute := NULL;
            ;
        END_METHOD

        METHOD PUBLIC MoveRelative : itfCommand
            VAR_INPUT
                Distance : LREAL := 0.0;
                Velocity : LREAL := 100.0;
            END_VAR
            MoveRelative := _commandMoveRelative.Start(AxisRef := _PosAxisRef);
            ;
        END_METHOD

        METHOD PUBLIC HomeDirect : itfCommand
            VAR_INPUT
                Position : LREAL;
            END_VAR
            HomeDirect := _commandHomeDirect.Start(AxisRef := _PosAxisRef, Position := Position);
            
        END_METHOD
    END_CLASS

END_NAMESPACE

USING Simatic.Ax.IO.Output;
USING Simatic.Ax.axftcmlib;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    ///Class for creating a basic Motor 
    /// It supports two directions 
    /// It is used to power the axis
    CLASS MotorBiDirectional
        IMPLEMENTS IMotorBiDiretional
        VAR PUBLIC
            QForward : IBinOutput;
            QReverse : IBinOutput;
        END_VAR
        VAR PROTECTED
        END_VAR
        ///Starts the Motor with a given direction and velocity

        METHOD PUBLIC Move
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            IF (direction = Direction#PositiveDirection) THEN
                IF (QForward <> NULL) THEN
                    QForward.SetOn();
                END_IF;
                IF (QReverse <> NULL) THEN
                    QReverse.SetOff();
                END_IF;
            ELSE
                IF (QForward <> NULL) THEN
                    QForward.SetOff();
                END_IF;
                IF (QReverse <> NULL) THEN
                    QReverse.SetOn();
                END_IF;
            END_IF;
            ;
        END_METHOD
        ///Stops every movement of the Motor

        METHOD PUBLIC Halt
              IF (QForward <> NULL) THEN
                    QForward.SetOff();
                END_IF;
                IF (QReverse <> NULL) THEN
                    QReverse.SetOff();
                END_IF;
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE

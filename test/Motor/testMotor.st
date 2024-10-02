USING AxUnit.Assert;
USING Simatic.Ax.IO.Output;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    {TestFixture}
    CLASS TestMotor
        VAR
            o : MotorBiDirectional;
            oStateless : MotorBiDirectional;
            QPos : BinOutput;
            QNeg : BinOutput;
            QStateless : BinOutput;
        END_VAR
        
        {TestSetup}
        METHOD PUBLIC TestSetup
            o := oStateLess;
            o.QForward := QPos;
            o.QReverse := QNeg;
            QPos := QStateless;
            QNeg := QStateless;
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC StartMotorPos
            o.Move(direction := Direction#PositiveDirection);
            Equal(expected := TRUE, actual := QPos.IsOn());
            Equal(expected := FALSE, actual := QNeg.IsOn());
            o.Halt();
            Equal(expected := FALSE, actual := QPos.IsOn());
            Equal(expected := FALSE, actual := QNeg.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC StartMotorNeg
            o.Move(direction := Direction#NegativeDirection);
            Equal(expected := FALSE, actual := QPos.IsOn());
            Equal(expected := TRUE, actual := QNeg.IsOn());
            o.Halt();
            Equal(expected := FALSE, actual := QPos.IsOn());
            Equal(expected := FALSE, actual := QNeg.IsOn());
        END_METHOD

    END_CLASS
END_NAMESPACE

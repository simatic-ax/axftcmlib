USING Simatic.Ax.Commands;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.axftcmlib

    {TestFixture}
    CLASS TwoWayActuatorTest
        VAR PROTECTED
            _actuator : TimeBasedActuator;
            _actuatorStateLess : TimeBasedActuator;
            _output : BinOutput;
            cmd : itfCommand;
            busy : BOOL;
        END_VAR

        {TestSetup}
        METHOD PUBLIC SetUp
            _actuator := _actuatorStateLess;
            _actuator.Q_ToWorkPosition := _output;
        END_METHOD

                {Test}
        METHOD PUBLIC TestTurnPneumaticCylinderPush_Expect_state_is_On
            cmd := _actuator.GoToWorkPosition();
            busy := cmd.Busy();
            AxUnit.Assert.Equal(expected := TRUE, actual := busy);
            AxUnit.Assert.Equal(expected := TRUE, actual := _output.IsOn());
            Equal(expected := TRUE, actual := _actuator.GetState() = ActuatorState#InWorkPosition);
        END_METHOD

        {Test}
        METHOD PUBLIC TestZylinderNotAsigned_Expected_ErrorFound_is_True
            VAR 
                Test : BOOL;
            END_VAR
            _actuator.Q_ToWorkPosition := NULL;
            _actuator.Busy();
            AxUnit.Assert.Equal(Expected := TRUE, actual := _actuator.Error());
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC TestPneumaticCylinderError_Expected_ErrorFound_TRUE
            VAR 
                Test : BOOL;
            END_VAR

            Test := _actuator.Error();
            AxUnit.Assert.Equal(Expected := FALSE, actual := Test);
            ;
        END_METHOD

    END_CLASS

END_NAMESPACE

//USING Simatic.Ax.Cylinder;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.axftcmlib

    {TestFixture}
    CLASS MyCylinderTest
        VAR PROTECTED
            _actuator : ActuatorTimeBased;
            _actuatorStateLess : ActuatorTimeBased;
            _output : BinOutput;
        END_VAR

        {TestSetup}
        METHOD PUBLIC SetUp
            _actuator := _actuatorStateLess;
            _actuator.ControlPush := _output;
        END_METHOD

                {Test}
        METHOD PUBLIC TestTurnPneumaticCylinderPush_Expect_state_is_On
            THIS.SetUp();
            _actuator.Enable();
            _actuator.Busy();
            AxUnit.Assert.Equal(expected := TRUE, actual := _output.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnPneumaticCylinderRetract_Expect_state_is_Off
            THIS.SetUp();
            THIS.TestTurnPneumaticCylinderPush_Expect_state_is_On();
            _actuator.Disable();
            _actuator.Busy();
            AxUnit.Assert.Equal(expected := FALSE, actual := _output.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC TestZylinderNotAsigned_Expected_ErrorFound_is_True
            VAR 
                Test : BOOL;
            END_VAR
            _actuator.ControlPush := NULL;
            _actuator.Busy();
            AxUnit.Assert.Equal(Expected := TRUE, actual := _actuator.Error());
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC TestPneumaticCylinderError_Expected_ErrorFound_TRUE
            VAR 
                Test : BOOL;
            END_VAR

            THIS.SetUp();
            Test := _actuator.Error();
            AxUnit.Assert.Equal(Expected := FALSE, actual := Test);
            ;
        END_METHOD

    END_CLASS

END_NAMESPACE

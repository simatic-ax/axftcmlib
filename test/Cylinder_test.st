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
            AxUnit.Assert.Equal(expected := TRUE, actual := _output.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnPneumaticCylinderRetract_Expect_state_is_Off
            THIS.SetUp();
            _actuator.Disable();
            AxUnit.Assert.Equal(expected := FALSE, actual := _output.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC TestZylinderNotAsigned_Expected_ErrorFound_is_True
            VAR 
                Test : BOOL;
            END_VAR
            Test := _actuator.HasError();
            IF Test <> TRUE THEN 
                _actuator.Disable();
            END_IF;

            AxUnit.Assert.Equal(Expected := TRUE, actual := Test);
         
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC TestPneumaticCylinderError_Expected_ErrorFound_TRUE
            VAR 
                Test : BOOL;
            END_VAR

            THIS.SetUp();
            Test := _actuator.HasError();
            AxUnit.Assert.Equal(Expected := FALSE, actual := Test);
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC TestPneumaticCylinderNullReferenceExpected_ErrorFoundTRUE
            VAR 
                Test : BOOL;
            END_VAR

            _actuator.Disable();
            Test := _actuator.HasError();
            AxUnit.Assert.Equal(Expected := TRUE, actual := Test);
            ;
        END_METHOD

    END_CLASS

END_NAMESPACE

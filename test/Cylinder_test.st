//USING Simatic.Ax.Cylinder;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.axftcmlib

    {TestFixture}
    CLASS MyCylinderTest
        VAR PROTECTED
            _testPneumaticCylinder : PneumaticCylinder;
            _testSubject : BinOutput;
        END_VAR

        METHOD PUBLIC SetUp
            _testPneumaticCylinder.CoilPushing := _testSubject;
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnPneumaticCylinderPush_Expect_state_is_On
            THIS.SetUp();
            _testPneumaticCylinder.PneumaticCylinderPush();
            AxUnit.Assert.Equal(expected := TRUE, actual := _testSubject.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnPneumaticCylinderRetract_Expect_state_is_Off
            THIS.SetUp();
            _testPneumaticCylinder.PneumaticCylinderRetract();
            AxUnit.Assert.Equal(expected := FALSE, actual := _testSubject.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC TestZylinderNotAsigned_Expected_ErrorFound_is_True
            VAR 
                Test : BOOL;
            END_VAR
            _testPneumaticCylinder.ErrorFound();
            Test := _testPneumaticCylinder.ErrorState;

            IF Test <> TRUE THEN 
                _testPneumaticCylinder.PneumaticCylinderRetract();
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
            _testPneumaticCylinder.ErrorFound();
            Test := _testPneumaticCylinder.ErrorState;
            AxUnit.Assert.Equal(Expected := FALSE, actual := Test);
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC TestPneumaticCylinderNullReferenceExpected_ErrorFoundTRUE
            VAR 
                Test : BOOL;
            END_VAR

            _testPneumaticCylinder.PneumaticCylinderRetract();
            _testPneumaticCylinder.ErrorFound();
            Test := _testPneumaticCylinder.ErrorState;
            AxUnit.Assert.Equal(Expected := TRUE, actual := Test);
            ;
        END_METHOD

    END_CLASS

END_NAMESPACE

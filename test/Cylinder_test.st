USING Simatic.Ax.Cylinder;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.Cylinder

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
        METHOD PUBLIC TestNull //TODO
            //Cylinder ohne zugewiesenem BInoutput
            //CPU darf keinen Fehler Werfen bei Seton()/ SetOff()
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE

USING Simatic.Ax.Cylinder;
USING AxUnit.Assert;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;

NAMESPACE Simatic.Ax.axftcmlib
    {TestFixture}
    CLASS MyCompressorTest
        VAR PROTECTED
            _testCompressor : PneumaticCompressor; 
            _testSubject : BinOutput;
        END_VAR
        METHOD PUBLIC  SetUp
            _testCompressor.ActiveCompressor := _testSubject;
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnCompressorOn_Expect_state_is_On
            THIS.SetUp();
            _testCompressor.PneumaticCompressorOn();
            AxUnit.Assert.Equal(expected := TRUE, actual :=_testSubject.IsOn()); // _testCompressor.ActiveCompressor.IsOn()); 
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnCompressorOff_Expect_state_is_Off
            THIS.SetUp();
            _testCompressor.PneumaticCompressorOff();
            AxUnit.Assert.Equal(expected := FALSE, actual := _testSubject.IsOn()); 
            END_METHOD

    END_CLASS
END_NAMESPACE
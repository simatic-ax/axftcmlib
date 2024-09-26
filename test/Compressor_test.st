USING AxUnit.Assert;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib

    {TestFixture}
    CLASS MyCompressorTest
        VAR PROTECTED
            _testCompressor : Compressor;
            _testCompressorStateless : Compressor;
            _Q : BinOutput;
            cmd : itfCommand;
        END_VAR

        {TestSetup}
        METHOD PUBLIC TestSetup
            _testCompressor := _testCompressorStateless;
            _testCompressor.QControl := _Q;
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnCompressorOn_Expect_state_is_On
            cmd := _testCompressor.Enable();
            AxUnit.Assert.Equal(expected := TRUE, actual := cmd.Busy());
            AxUnit.Assert.Equal(expected := TRUE, actual := _Q.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC Missing_the_control_Q_leads_To_error
            _testCompressor.QControl := NULL;
            cmd := _testCompressor.Enable();
            AxUnit.Assert.Equal(expected := TRUE, actual := cmd.Error());
            AxUnit.Assert.Equal(expected := FALSE, actual := _Q.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC TestTurnCompressorOff_Expect_state_is_Off
            cmd := _testCompressor.Disable();
            AxUnit.Assert.Equal(expected := TRUE, actual := cmd.Done());
            AxUnit.Assert.Equal(expected := FALSE, actual := _Q.IsOn());
        END_METHOD
    END_CLASS

END_NAMESPACE

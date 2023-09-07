USING Simatic.Ax.axftcmlib;

NAMESPACE Simatic.Ax.axftcmlib

    {TestFixture}
    CLASS MyEncoderTest
        VAR PROTECTED
            _testEncoderStatic : TimeBasedEncoder;
            _staticTimeProvider : TimeProviderMOCK_100ms_const;
            _staticAxis : Axis_Mock := (State := PlcOpenState#Busy);
        END_VAR

        METHOD PUBLIC SetUp
            VAR
                velocity : LREAL;
            END_VAR
            velocity := 1.0;
            _testEncoderStatic.velocity := 1.0;
            _testEncoderStatic.TimeProvider := _staticTimeProvider;
            _testEncoderStatic.EncoderAxis := _staticAxis;
            _testEncoderStatic.EncoderAxis.MoveVelocity(velocity, Direction#Forward);
        END_METHOD

        {Test}
        METHOD PUBLIC TestPositionAfter100ms_Expect_position_equal
            THIS.SetUp();
            _testEncoderStatic.Reset();
            _testEncoderStatic.Evaluate();
            AxUnit.Assert.Equal(expected := 100, actual := _testEncoderStatic.GetValue());
            _testEncoderStatic.Evaluate();
            AxUnit.Assert.Equal(expected := 200, actual := _testEncoderStatic.GetValue());
            // Set Axis to stop 
            _staticAxis.State := PlcOpenState#Done;
            _testEncoderStatic.Evaluate();
            AxUnit.Assert.Equal(expected := 200, actual := _testEncoderStatic.GetValue()); // dont integrate when axis is stopped
            // After Reset the GetValue should be 0
            _testEncoderStatic.Reset();
            AxUnit.Assert.Equal(expected := 0, actual := _testEncoderStatic.GetValue());

        END_METHOD
    END_CLASS

END_NAMESPACE

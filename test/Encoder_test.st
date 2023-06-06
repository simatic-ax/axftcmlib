USING Simatic.Ax.axftcmlib;

NAMESPACE Simatic.Ax.axftcmlib
    {TestFixture}
    
    CLASS MyEncoderTest
        VAR PROTECTED
            _testEncoderStatic : TimeBasedEncoder;
            _staticTimeProvider : TimeProviderMOCK_100ms_const;
            _staticAxis : Axis;
           
        END_VAR
        
    METHOD PUBLIC SetUp
        VAR
            velocity : LREAL;
            dummyValue : INT;
        END_VAR
        dummyValue := 0;
        velocity := 1.0;
        _testEncoderStatic.velocity := 1.0;
        _testEncoderStatic.TimeProvider := _staticTimeProvider;
        _testEncoderStatic.EncoderAxis := _staticAxis;
        _testEncoderStatic.EncoderAxis.MoveVelocity(velocity,dummyvalue);
    END_METHOD

    {Test}
    METHOD PUBLIC TestPositionAfter100ms_Expect_position_equal
        THIS.SetUp();
        _testEncoderStatic.Reset();
        _testEncoderStatic.Evaluate();
        _testEncoderStatic.GetValue();
        AxUnit.Assert.Equal(expected := LREAL#0.1, actual := _testEncoderStatic.RealPosition);
    END_METHOD

    END_CLASS

END_NAMESPACE
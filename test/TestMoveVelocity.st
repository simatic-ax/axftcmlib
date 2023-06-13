USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING AxUnit.Assert;

// USING Simatic.Ax.SimpleControlModules;
NAMESPACE Simatic.Ax.Library

    {TestFixture}
    CLASS TestMoveVelocity
        VAR PROTECTED
            _axis : Axis;
            _refSwitch : BinSignal;
            _motor : MotorFT;
            _fwd : BinOutput;
            _rvs : BinOutput;
            _encoder : Simatic.Ax.SimpleControlModules.EncoderAB;
        END_VAR
        METHOD PUBLIC Setup
            _motor.Forward := _fwd;
            _motor.Reverse := _rvs;
            _axis.Motor := _motor;
            _axis.Encoder := _encoder;
            _axis.ReferenceSwitch := _refSwitch;
        END_METHOD
        {Test}
        METHOD PUBLIC MotorForward_IsOn_When_MoveVelocityIsCalled_With_Direction_Forward
            THIS.Setup();
            _axis.MoveVelocity(direction := Direction#Forward);
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
        END_METHOD
        {Test}
        METHOD PUBLIC MotorReverse_IsOn_When_MoveVelocityIsCalled_With_Direction_Reverse
            THIS.Setup();
            _axis.MoveVelocity(direction := Direction#Reverse);
            _axis.RunCyclic();
            Equal(expected := FALSE, actual := _fwd.IsOn());
            Equal(expected := TRUE, actual := _rvs.IsOn());
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
        END_METHOD
        {Test}
        METHOD PUBLIC A_Moving_AxisStops_OnHalt;
            THIS.MotorForward_IsOn_When_MoveVelocityIsCalled_With_Direction_Forward();
            _axis.Halt();
            Equal(expected := FALSE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
            _axis.RunCyclic();
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
        END_METHOD
    END_CLASS

END_NAMESPACE

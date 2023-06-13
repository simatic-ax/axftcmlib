USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING AxUnit.Assert;

// USING Simatic.Ax.SimpleControlModules;
NAMESPACE Simatic.Ax.Library

    {TestFixture}
    CLASS TestAxisManualHoming
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
        METHOD PUBLIC AxisReturnes_IsHomed_when_Homing_Method_isCalled
            THIS.Setup();
            Equal(expected := FALSE, actual := _axis.IsHomed());
            _axis.Homing(position := 100);
            Equal(expected := TRUE, actual := _axis.IsHomed());
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
            _axis.RunCyclic();
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
        END_METHOD
    END_CLASS

END_NAMESPACE

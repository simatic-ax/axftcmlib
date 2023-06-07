USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING AxUnit.Assert;

// USING Simatic.Ax.SimpleControlModules;
NAMESPACE Simatic.Ax.Library

    {TestFixture}
    CLASS TestAxisHoming
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
        METHOD PUBLIC TestForwardDirection_Expect_Fwd_IsOn
            THIS.Setup();
            _axis.MoveVelocity(direction := Direction#Forward);
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
            Equal(expected := TRUE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());
        END_METHOD
        {Test}
        METHOD PUBLIC Homing_from_outside_of_the_referecne_sensor_Move_reverse
            THIS.Setup();
            _axis.Homing(direction := Direction#Reverse);
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
            _axis.RunCyclic();
            Equal(expected := FALSE, actual := _fwd.IsOn());
            Equal(expected := TRUE, actual := _rvs.IsOn());
        END_METHOD
        
        {Test}
        METHOD PUBLIC Homing_from_outside_of_the_referecne_sensor_Move_forward
            THIS.Setup();
            _axis.Homing(direction := Direction#Forward);
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());
        END_METHOD

        {Test}
        METHOD PUBLIC Homing_untilsensor_has_reached 
            VAR_TEMP
                isHomed : BOOL;
            END_VAR
            THIS.Setup();
            
            _axis.Homing(direction := Direction#Forward);
            _axis.RunCyclic();

            _refSwitch.ReadCyclic(signal := FALSE);
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Error);            
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
            Equal(expected := TRUE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());

            _refSwitch.ReadCyclic(signal := FALSE);
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Error);            
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
            Equal(expected := TRUE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());

            _refSwitch.ReadCyclic(signal := FALSE);
            _axis.RunCyclic();
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Error);            
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
            Equal(expected := TRUE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());

            _refSwitch.ReadCyclic(signal := TRUE);
            _axis.RunCyclic();
            _axis.RunCyclic();
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);            
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Error);            
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);            
            Equal(expected := FALSE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());
            Equal(expected := TRUE, actual := _axis.IsHomed());
        END_METHOD
        
    END_CLASS

END_NAMESPACE

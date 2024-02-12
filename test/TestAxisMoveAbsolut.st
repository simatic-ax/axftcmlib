USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.axftcmlib;
USING AxUnit.Assert;

// USING Simatic.Ax.SimpleControlModules;
NAMESPACE Simatic.Ax.Library

    {TestFixture}
    CLASS TestAxisMoveAbsolut
        VAR PROTECTED
            _axis : Axis;
            _axisStateLess : Axis;
            _refSwitch : BinSignal;
            _motor : MotorFT;
            _fwd : BinOutput;
            _rvs : BinOutput;
            _encoder : Simatic.Ax.SimpleControlModules.EncoderAB;
        END_VAR
        {TestSetup}
        METHOD PUBLIC Setup
            _axisStateLess := _axis;
            _motor.Forward := _fwd;
            _motor.Reverse := _rvs;
            _axis.Motor := _motor;
            _axis.Encoder := _encoder;
            _axis.ReferenceSwitch := _refSwitch;
        END_METHOD
        METHOD PUBLIC Home : BOOL
            VAR_INPUT
                axis : REF_TO Axis;
                refSwitch : REF_TO BinSignal;
            END_VAR
            axis^.Homing(direction := Direction#Forward);
            refSwitch^.ReadCyclic(signal := FALSE);
            axis^.RunCyclic();
            refSwitch^.ReadCyclic(signal := TRUE);
            axis^.RunCyclic();
            // one additional cycle to finalize the Homing 
            axis^.RunCyclic();
            Home := axis^.IsHomed();
        END_METHOD
        // {Test}
        // METHOD PUBLIC Test_MoveAbsolut_on_a_not_homed_axis_which_results_in_an_error
        //     VAR_TEMP
        //         isHomed : BOOL;
        //     END_VAR
        //     THIS.Setup();
        //     _axis.MoveAbsolute(velocity := 100.0, position := LINT#100);
        //     _axis.RunCyclic();
        //     Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);
        //     Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Error);
        //     Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);
        // END_METHOD
        // {Test}
        // METHOD PUBLIC Test_MoveAbsolut_on_a_homed_axis
        //     VAR_TEMP
        //         isHomed : BOOL;
        //     END_VAR
        //     THIS.Setup();
        //     isHomed := THIS.Home(axis := REF(_axis), refSwitch := REF(_refSwitch));
        //     Equal(expected := TRUE, actual := isHomed);
        //     Equal(expected := FALSE, actual := _fwd.IsOn());
        //     Equal(expected := FALSE, actual := _rvs.IsOn());
        //     // start Axis to move to position 100
        //     _axis.MoveAbsolute(velocity := 100.0, position := LINT#100);
        //     _axis.RunCyclic();
        //     Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);
        //     Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Error);
        //     Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);
        //     Equal(expected := TRUE, actual := _fwd.IsOn());
        //     Equal(expected := FALSE, actual := _rvs.IsOn());
        //     // Axis is at position 99
        //     _encoder.SetValue(value := LINT#99);
        //     _axis.RunCyclic();
        //     Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);
        //     // test axis in position
        //     _encoder.SetValue(value := LINT#100);
        //     _axis.RunCyclic();
        //     _axis.RunCyclic();
        //     Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);
        //     Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);
        //     Equal(expected := FALSE, actual := _fwd.IsOn());
        //     Equal(expected := FALSE, actual := _rvs.IsOn());            // test axis in position - done after one cycle is false
        //     _encoder.SetValue(value := LINT#100);
        //     _axis.RunCyclic();
        //     Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);
        //     Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);
        // END_METHOD
        {Test}
        METHOD PUBLIC Move_Absolut_on_a_axis_which_is_already_inPos
            VAR_TEMP
                isHomed : BOOL;
            END_VAR
            THIS.Setup();
            isHomed := THIS.Home(axis := REF(_axis), refSwitch := REF(_refSwitch));
            Equal(expected := TRUE, actual := isHomed);
            Equal(expected := FALSE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());
            // start Axis to move to position 100
            _encoder.SetValue(value := LINT#100);
            _axis.MoveAbsolute(velocity := 100.0, position := LINT#100);
            _axis.RunCyclic();
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Busy);
            Equal(expected := FALSE, actual := _axis.GetPlcOpenState() = PlcOpenState#Error);
            Equal(expected := TRUE, actual := _axis.GetPlcOpenState() = PlcOpenState#Done);
            Equal(expected := FALSE, actual := _fwd.IsOn());
            Equal(expected := FALSE, actual := _rvs.IsOn());
        END_METHOD
    END_CLASS

END_NAMESPACE

USING Simatic.Ax.IO.Input;
USING Simatic.Ax.Commands;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.axftcmlib

    {TestFixture}
    CLASS TwoWayActuatorTest
        VAR PROTECTED
            _actuator : TwoWayActuator;
            _actuatorStateLess : TwoWayActuator;
            _qToWork : BinOutput;
            _qToHome : BinOutput;
            _outputStateLess : BinOutput;
            _iInHomePos : BinSignal;
            _iInWorkPos : BinSignal;
            _binSignalStateless : BinSignal;
            cmd : itfCommand;
            done : BOOL;
            busy : BOOL;
        END_VAR

        {TestSetup}
        METHOD PUBLIC SetUp
            _actuator := _actuatorStateLess;
            _actuator.Q_ToWorkPosition := _qToWork;
            _actuator.Q_ToHomePosition := _qToHome;
            _actuator.I_InHomePosition := _iInHomePos;
            _actuator.I_InWorkPosition := _iInWorkPos;
            _iInHomePos := _binSignalStateless;
            _iInWorkPos := _binSignalStateless;
            _qToWork := _outputStateLess;
            _qToHome := _outputStateLess;
            busy := FALSE;
        END_METHOD

        // {Test}
        // METHOD PUBLIC GoToWorkPosition_Swiches_Q_ToWorkPosition_On_And_Returns_Busy
        //     cmd := _actuator.GoToWorkPosition();
        //     busy := cmd.Busy();
        //     AxUnit.Assert.Equal(expected := TRUE, actual := busy);
        //     AxUnit.Assert.Equal(expected := TRUE, actual := _qToWork.IsOn());
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToHome.IsOn());
        //     Equal(expected := TRUE, actual := _actuator.GetState() = ActuatorState#MoveToWorkPosition);
        // END_METHOD

        {Test}
        METHOD PUBLIC GoToWorkPosition_Returns_Done_When_end_position_is_already_reached
            _iInWorkPos.ReadCyclic(signal := TRUE);
            cmd := _actuator.GoToWorkPosition();
            busy := cmd.Busy();
            IF NOT(busy) THEN
                done := cmd.Done();
            END_IF;                
            AxUnit.Assert.Equal(expected := FALSE, actual := busy);
            AxUnit.Assert.Equal(expected := TRUE, actual := done);
            AxUnit.Assert.Equal(expected := FALSE, actual := _qToWork.IsOn());
            AxUnit.Assert.Equal(expected := FALSE, actual := _qToHome.IsOn());
            Equal(expected := TRUE, actual := _actuator.GetState() = ActuatorState#InWorkPosition);
        END_METHOD

        // {Test}
        // METHOD PUBLIC Reaching_WorkPosition_Switches_Q_ToWorkPosition_Off_And_Returns_Done
        //     THIS.GoToWorkPosition_Swiches_Q_ToWorkPosition_On_And_Returns_Busy();
        //     _iInWorkPos.ReadCyclic(signal := TRUE);
        //     busy := cmd.Busy();
        //     IF NOT(busy) THEN
        //         done := cmd.Done();
        //     END_IF;                
        //     AxUnit.Assert.Equal(expected := FALSE, actual := busy);
        //     AxUnit.Assert.Equal(expected := TRUE, actual := done);
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToWork.IsOn());
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToHome.IsOn());
        //     Equal(expected := TRUE, actual := _actuator.GetState() = ActuatorState#InWorkPosition);
        // END_METHOD


        // // Test Home Position
        // {Test}
        // METHOD PUBLIC GoToHomePosition_Swiches_Q_ToHomePosition_On_And_Returns_Busy
        //     cmd := _actuator.GoToHomePosition();
        //     busy := cmd.Busy();
        //     AxUnit.Assert.Equal(expected := TRUE, actual := busy);
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToWork.IsOn());
        //     AxUnit.Assert.Equal(expected := TRUE, actual := _qToHome.IsOn());
        //     Equal(expected := TRUE, actual := _actuator.GetState() = ActuatorState#MoveToHomePosition);
        // END_METHOD

        // {Test}
        // METHOD PUBLIC GoToHomePosition_Returns_Done_When_end_position_is_already_reached
        //     _iInHomePos.ReadCyclic(signal := TRUE);
        //     cmd := _actuator.GoToHomePosition();
        //     busy := cmd.Busy();
        //     IF NOT(busy) THEN
        //         done := cmd.Done();
        //     END_IF;                
        //     AxUnit.Assert.Equal(expected := FALSE, actual := busy);
        //     AxUnit.Assert.Equal(expected := TRUE, actual := done);
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToWork.IsOn());
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToHome.IsOn());
        //     Equal(expected := TRUE, actual := _actuator.GetState() = ActuatorState#InHomePosition);
        // END_METHOD

        // {Test}
        // METHOD PUBLIC Reaching_HomePosition_Switches_Q_ToHomePosition_Off_And_Returns_Done
        //     THIS.GoToHomePosition_Swiches_Q_ToHomePosition_On_And_Returns_Busy();
        //     _iInHomePos.ReadCyclic(signal := TRUE);
        //     busy := cmd.Busy();
        //     IF NOT(busy) THEN
        //         done := cmd.Done();
        //     END_IF;                
        //     AxUnit.Assert.Equal(expected := FALSE, actual := busy);
        //     AxUnit.Assert.Equal(expected := TRUE, actual := done);
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToWork.IsOn());
        //     AxUnit.Assert.Equal(expected := FALSE, actual := _qToHome.IsOn());
        //     Equal(expected := TRUE, actual := _actuator.GetState() = ActuatorState#InHomePosition);
        // END_METHOD
    END_CLASS

END_NAMESPACE

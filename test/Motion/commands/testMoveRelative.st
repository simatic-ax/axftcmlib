USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;
USING Simatic.Ax.Commands;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    {TestFixture}
    CLASS testMoveRelative
        VAR
            to_pos : TO_PosAxis;
            to_pos_Stateless : TO_PosAxis;
            moveRelative : commandMoveRelative;
            moveRelativeStateLess : commandMoveRelative;
            cmd : itfCommand;
            encoder : MockEncoder;
            motor : MotorBiDirectional;
            qNeg : BinOutput;
            qPos : BinOutput;
        END_VAR
        
        {TestSetup}
        METHOD PUBLIC TestSetup
            to_pos := to_pos_Stateless;
            moveRelative := moveRelativeStateLess;    
            motor.QForward := qPos;
            motor.QReverse := qNeg;
            to_pos.Motor := motor;
            to_pos.Encoder := encoder;
        END_METHOD

        {Test}
        METHOD PUBLIC Start_not_homed_axis_returns_error
            to_pos.isPowerdOn := TRUE;
            cmd := moveRelative.Start(AxisRef := REF(to_pos), Distance := 100);
            Equal(expected := TRUE, actual := cmd.Error());
            Equal(expected := WORD#16#8003, actual := cmd.ErrorID());
            to_pos.SetPosition(0);
            cmd := moveRelative.Start(AxisRef := REF(to_pos), distance := 100);
            Equal(expected := TRUE, actual := cmd.Busy());
            ;        
        END_METHOD

        {Test}
        METHOD PUBLIC Start_Homed_Axis_with_Distance_100_returns_busy
            to_pos.isPowerdOn := TRUE;
            to_pos.SetPosition(0);
            cmd := moveRelative.Start(AxisRef := REF(to_pos), distance := 100);
            Equal(expected := TRUE, actual := cmd.Busy());
            Equal(expected := TRUE, actual := to_pos.IsRunning());
            encoder.SetValue(100);
            Equal(expected := TRUE, actual := cmd.Done());
            Equal(expected := FALSE, actual := to_pos.IsRunning());

            cmd := moveRelative.Start(AxisRef := REF(to_pos), distance := 100);
            Equal(expected := TRUE, actual := cmd.Busy());
            Equal(expected := TRUE, actual := to_pos.IsRunning());
            encoder.SetValue(200);
            Equal(expected := TRUE, actual := cmd.Done());
            Equal(expected := FALSE, actual := to_pos.IsRunning());
            ;        
        END_METHOD
    END_CLASS
END_NAMESPACE

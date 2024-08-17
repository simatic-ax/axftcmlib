USING AxUnit.Assert;
USING Simatic.Ax.Commands;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    {TestFixture}
    CLASS testMoveAbsolute
        VAR
            to_pos : TO_PosAxis;
            to_pos_Stateless : TO_PosAxis;
            moveAbsolute : commandMoveAbsolute;
            moveAbsoluteStateLess : commandMoveAbsolute;
            cmd : itfCommand;
            encoder : MockEncoder;
            motor : MotorFT;
        END_VAR
        
        {TestSetup}
        METHOD PUBLIC TestSetup
            to_pos := to_pos_Stateless;
            moveAbsolute := moveAbsoluteStateLess;    
            to_pos.Motor := motor;
            to_pos.Encoder := encoder;
        END_METHOD

        {Test}
        METHOD PUBLIC Start_not_homed_axis_returns_error
            to_pos.isPowerdOn := TRUE;
            cmd := moveAbsolute.Start(AxisRef := REF(to_pos));
            Equal(expected := TRUE, actual := cmd.Error());
            Equal(expected := WORD#16#8003, actual := cmd.ErrorID());
            to_pos.SetPosition(0);
            cmd := moveAbsolute.Start(AxisRef := REF(to_pos), position := 100);
            Equal(expected := TRUE, actual := cmd.Busy());
            ;        
        END_METHOD

        {Test}
        METHOD PUBLIC Start_Homed_Axis_with_Distance_100_returns_busy
            to_pos.isPowerdOn := TRUE;
            to_pos.SetPosition(0);
            cmd := moveAbsolute.Start(AxisRef := REF(to_pos), position := 100);
            Equal(expected := TRUE, actual := cmd.Busy());
            Equal(expected := TRUE, actual := to_pos.IsRunning());
            encoder.SetValue(100);
            Equal(expected := TRUE, actual := cmd.Done());
            Equal(expected := FALSE, actual := to_pos.IsRunning());
            ;        
        END_METHOD
    END_CLASS
END_NAMESPACE

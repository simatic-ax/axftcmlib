USING AxUnit.Assert;
USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    {TestFixture}
    CLASS TestSpeedAxis
        VAR
            axis : SpeedAxis;
            axisStateLess : SpeedAxis;
            toAxis : TO_SpeedAxis;
            command : itfCommand;
        END_VAR
        
        {TestSetup}
        METHOD PUBLIC TestSetup
            axis := axisStateLess;
            axis.Attach(REF(toAxis));
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC MoveVelocity_WithoutPower_LeadsToAnError
            command := axis.MoveVelocity();
            Equal(expected := TRUE, actual := command.Error());
            Equal(expected := FALSE, actual := toAxis.IsRunning());

            
        END_METHOD

        {Test}
        METHOD PUBLIC MoveVelocity_Withpower_StartsAxis
            axis.PowerOn();
            command := axis.MoveVelocity();
            Equal(expected := TRUE, actual := command.Busy());
            Equal(expected := TRUE, actual := toAxis.IsRunning());
        END_METHOD

        {Test}
        METHOD PUBLIC StopARunningAxis
            THIS.MoveVelocity_Withpower_StartsAxis();
            command := axis.Stop();
            Equal(expected := TRUE, actual := command.Done());
            Equal(expected := FALSE, actual := toAxis.IsRunning());
        END_METHOD

    END_CLASS


END_NAMESPACE

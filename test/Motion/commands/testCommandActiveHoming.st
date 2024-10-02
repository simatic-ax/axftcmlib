USING Simatic.Ax.IO.Input;
USING AxUnit.Assert;
USING Simatic.Ax.Commands;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    {TestFixture}
    CLASS testCommandActiveHoming
        VAR
            axis : PosAxis;
            axisStateLess : PosAxis;
            toAxis : TO_PosAxis;
            toAxisStateLess : TO_PosAxis;
            command : itfCommand;
            cmdHomeDirect : commandActiveHoming; 
            encoder : MockEncoder;
            RefSensor : BinSignal;
            M1 : MotorBiDirectional;
        END_VAR
        
        {TestSetup}
        METHOD PUBLIC TestSetup
            axis := axisStateLess;
            toAxis := toAxisStateLess;
            toAxis.Encoder := encoder;
            toAxis.Motor := M1;
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC Start_Homing_And_IS_Running_On
            axis.Attach(REF(toAxis));
            axis.PowerOn();
            command := cmdHomeDirect.Start(AxisRef := REF(toAxis), Position := 100.0, RefSensor := RefSensor);
            IF (command <> NULL) THEN
                Equal(expected := TRUE, actual := command.Busy());
                ;
            END_IF;
            Equal(expected := TRUE, actual := toAxis.IsRunning());

            // set the encoder position manually to 100
            encoder.SetValue(100);

            Equal(expected := FALSE, actual := command.Done());
            Equal(expected := TRUE, actual := toAxis.IsRunning());

            RefSensor.ReadCyclic(signal := TRUE);
            Equal(expected := TRUE, actual := command.Done());
            Equal(expected := FALSE, actual := toAxis.IsRunning());
            Equal(expected := 100.0, actual := toAxis.GetPosition());

        END_METHOD
    END_CLASS

END_NAMESPACE

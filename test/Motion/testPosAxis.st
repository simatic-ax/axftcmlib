// USING AxUnit.Assert;
// USING Simatic.Ax.Commands;

// NAMESPACE Simatic.Ax.axftcmlib.Motion

//     {TestFixture}
//     CLASS TestPosAxis
//         VAR
//             axis : PosAxis;
//             axisStateLess : PosAxis;
//             toAxis : TO_PosAxis;
//             toAxisStateLess : TO_PosAxis;
//             command : itfCommand;
//         END_VAR
        
//         {TestSetup}
//         METHOD PUBLIC TestSetup
//             axis := axisStateLess;
//             toAxis := toAxisStateLess;
//             axis.Attach(REF(toAxis));

//             ;
//         END_METHOD

//         {Test}
//         METHOD PUBLIC MoveVelocity_WithoutPower_LeadsToAnError
//             command := axis.MoveVelocity();
//             Equal(expected := TRUE, actual := command.Error());
//             Equal(expected := FALSE, actual := toAxis.IsRunning());
//         END_METHOD

//         {Test}
//         METHOD PUBLIC MoveVelocity_Withpower_StartsAxis
//             axis.PowerOn();
//             command := axis.MoveVelocity();
//             Equal(expected := TRUE, actual := command.Busy());
//             Equal(expected := TRUE, actual := toAxis.IsRunning());
//         END_METHOD

//         {Test}
//         METHOD PUBLIC MoveRelative_WithPowered_StartsAxis
//             axis.PowerOn();
//             command := axis.MoveRelative();
            
//             Equal(expected := TRUE, actual := command.Busy());
//             Equal(expected := TRUE, actual := toAxis.IsRunning());
//         END_METHOD

//         {Test}
//         METHOD PUBLIC StopARunningAxis
//             THIS.MoveVelocity_Withpower_StartsAxis();
//             command := axis.Stop();
//             Equal(expected := TRUE, actual := command.Done());
//             Equal(expected := FALSE, actual := toAxis.IsRunning());
//         END_METHOD

//         {Test}
//         METHOD PUBLIC DirectHoming_Returns_Done_when_finished
//             axis.PowerOn();
//             command := axis.HomeDirect(Position := 100.0);
//             Equal(expected := TRUE, actual := command.Done());
//         END_METHOD

//     END_CLASS


// END_NAMESPACE

// USING System.Timer;
// USING Simatic.Ax.IO.Output;
// NAMESPACE Simatic.Ax.axftcmlib

// CLASS ConveyorBelt IMPLEMENTS IConveyorBelt

//     VAR PUBLIC
//         ConveyorIdle : BOOL;
//         ConveyorBeltMotor : IBinOutput;
//         IsHomed : BOOL;
//         Trigger: Pulse;
//         HomingPoint : BOOL;
//     END_VAR

//     METHOD PUBLIC MoveDuration//MoveRelative
//         VAR_INPUT
//             ActiveTime : TIME;
//             TriggerAction : BOOL;
//         END_VAR
//        Trigger(Signal :=TriggerAction, duration := ActiveTime);
//          IF Trigger.output = TRUE THEN
//          ConveyorBeltMotor.SetOn();
//          ConveyorIdle := TRUE;
//          IsHomed := FALSE;
//          ELSE
//         ConveyorBeltMotor.SetOff();
//         ConveyorIdle := FALSE; 
//          END_IF;    
//     END_METHOD

//     METHOD PROTECTED Homing //"Basic Idea"
//         IF IsHomed = FALSE THEN
//             IF HomingPoint = FALSE THEN
//                 ConveyorBeltMotor.SetOn();
//                  ConveyorIdle := TRUE;
//             END_IF;
//         END_IF;
//         ConveyorBeltMotor.SetOff();
//         IsHomed := TRUE;
//         ConveyorIdle := FALSE;
//     END_METHOD

//     METHOD PUBLIC MoveAbsolute //"Basic Idea"
//         VAR_INPUT
//             TargetPosition : INT;
//         END_VAR
//         VAR 
//             TickCounter : INT;
//         END_VAR;
//         IF IsHomed = FALSE THEN
//             THIS.Homing();
//         END_IF;
        
//         THIS.MoveRelative(TargetPosition); 
        
//     END_METHOD

//     METHOD PUBLIC MoveRelative //"Basic Idea"
//         VAR_INPUT
//             TargetPosition : INT;
//         END_VAR
//         VAR 
//             TickCounter : INT;
//         END_VAR;
        
//         FOR TickCounter := 0 TO TargetPosition DO //TODO endlos?
//             ConveyorBeltMotor.SetOn();
//             ConveyorIdle := TRUE;
//         END_FOR;

//         ConveyorBeltMotor.SetOff();
//         ConveyorIdle := FALSE;
//         IsHomed := FALSE;
//     END_METHOD

//     METHOD PUBLIC TurnOff
//         ConveyorBeltMotor.SetOff();
//         ConveyorIdle := FALSE;
//     END_METHOD

// END_CLASS
    
// END_NAMESPACE
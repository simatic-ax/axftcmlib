USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.StateFramework;
NAMESPACE Simatic.Ax.Cylinder 

    CLASS PneumaticCylinder EXTENDS ControlModuleAbstract  IMPLEMENTS IPneumaticCylinder
        VAR PUBLIC
            CoilPushing : IBinOutput; // = Used Valve
            ActivationTime : TIME := T#1s; //Delay for Coil beeing pushed
            
        END_VAR

        VAR PROTECTED
            _ctrl : StateController;            
            

            // State Retracted --> initial state
            _retracted : StateRetracted;
            _retractedToPush : Transition;
            _retractedToPushGuard : StartGuard;

            // State Pushing 
            _pushing : StatePushing;
            _pushingToPushed : Transition;
            _pushingToPushedGuard : TrueGuard;

            // State Pushed 
            _pushed : StatePushed;
            _pushedToRetracting : Transition;
            _pushedToRetractingGuard : TimeoutGuard;

            // State Retracting
            _retracting : StateRetracting;
            _retractingToRetracted : Transition;
            _retractingToRetractedGuard : TrueGuard;
        END_VAR

        METHOD PROTECTED OVERRIDE Constructor //Inititializing with Values 
              // State Retracted
              _retracted.Cylinder := THIS; 
              _retracted.Transition1 := _retractedToPush; 
              _retractedToPush.Guard := _retractedToPushGuard;
              _retractedToPush.NextState := _pushing;
  
              // State Pushing
              _pushing.Cylinder := THIS;
              _pushing.Transition1 := _pushingToPushed;
              _pushingToPushed.Guard := _pushingToPushedGuard;
              _pushingToPushed.NextState := _pushed;
  
              // State Pushed
              _pushed.Cylinder := THIS;
              _pushed.Transition1 := _pushedToRetracting;
              _pushedToRetracting.Guard := _pushedToRetractingGuard;
              _pushedToRetracting.NextState := _retracting;
  
              // State Retracting
              _retracting.Cylinder := THIS;
              _retracting.Transition1 := _retractingToRetracted;
              _retractingToRetracted.Guard := _retractingToRetractedGuard;
              _retractingToRetracted.NextState := _retracted;
  
              // Set initial state
              _ctrl.InitialState := _retracted; //Giving statecontroller the initialization --> Start
            ;
        END_METHOD

        METHOD PROTECTED OVERRIDE RunCyclicCustom

            _ctrl.Execute();

        END_METHOD

        METHOD PUBLIC Start
            _pushedToRetractingGuard.timeout := ActivationTime;
            _retractedToPushGuard.Start();
        END_METHOD

        METHOD PUBLIC PneumaticCylinderPush
            coilPushing.SetOn(); //BinOutput--> _state = true
        END_METHOD

        METHOD PUBLIC PneumaticCylinderRetract
            coilPushing.SetOff(); //BinOutput--> _state = false
        END_METHOD
    END_CLASS


END_NAMESPACE 
    
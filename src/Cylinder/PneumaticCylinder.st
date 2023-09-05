USING Simatic.Ax.IO;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.StateFramework;
NAMESPACE Simatic.Ax.axftcmlib
    ///Class contains basic functions for a pneumatic cyliner
    ///contains a statemachine that can be used to generate a working cylinder
    /// Is used for the Fischertechnik Factorysimulation 24V
    CLASS PneumaticCylinder EXTENDS ControlModuleAbstract  IMPLEMENTS IPneumaticCylinder
        VAR PUBLIC
            CoilPushing : IBinOutput; // = Used Valve
            ActivationTime : TIME := T#1s; //Delay for Coil beeing pushed
            ErrorState : BOOL;
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

        ///Mimics a constructor and asigns the values
        /// Executed by the Controlmodule
        METHOD PROTECTED OVERRIDE _constructor //Inititializing with Values 
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

        ///Returns TRUE if the coil is not working 
        METHOD PUBLIC ErrorFound 
          IF THIS.CoilPushing <> NULL THEN
            ErrorState:= FALSE;
          ELSE 
            ErrorState := TRUE;
          END_IF;
        END_METHOD  

        ///Is executed by the ControlmoduleAbstract: RunCyclic()
        ///initializes the first state
        METHOD PROTECTED OVERRIDE _runCyclicCustom
            _ctrl.Execute();
        END_METHOD

        ///Starts the statemachine
        METHOD PUBLIC Start
            _pushedToRetractingGuard.timeout := ActivationTime;
            _retractedToPushGuard.Start();
        END_METHOD

        //Activates valve to push the coil
        METHOD PUBLIC PneumaticCylinderPush
            THIS.ErrorFound();
            IF ErrorState = FALSE THEN
                coilPushing.SetOn();
            END_IF;
        END_METHOD
        
        //deactivates the valve to retract the cylinder
        METHOD PUBLIC PneumaticCylinderRetract
            THIS.ErrorFound();
            IF ErrorState = FALSE THEN
                coilPushing.SetOff();
            END_IF;
        END_METHOD
    END_CLASS


END_NAMESPACE 
    
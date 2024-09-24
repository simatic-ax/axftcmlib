USING Simatic.Ax.IO.Input;
USING System.Timer;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.axftcmlib.Motion
    TYPE INTERNAL
        StatesHoming : (Idle, MoveOutOfSensor, FindReferenceSensor, Done) := Idle;
    END_TYPE

    TYPE INTERNAL
        StateMoveAbsolute : (Idle, Moving, Stopping, Done) := Idle;
    END_TYPE

    TYPE INTERNAL
        MotionMode : (Stopped, Homing, MoveAbsolute, MoveRelative, MoveVelocity);
    END_TYPE

    TYPE
        PlcOpenState : (Ready, Busy, Done, Error) := Ready;
    END_TYPE

    ///Class contains all functions necessary for realisng a motion axis
    ///The motor is used for "powering" the axis
    ///The encoder is needed to monitor the current position 
    CLASS Axis2
        IMPLEMENTS IAxis
        VAR PUBLIC
            Motor : IMotor;
            Encoder : IEncoder;
            ReferenceSwitch : IBinSignal;
        END_VAR
        VAR PROTECTED
            _stateHoming : StatesHoming;
            _stateMoveAbsolute : StateMoveAbsolute;
            _motionMode : MotionMode;
            _velocity : LREAL;
            _direction : Direction;
            _position : LINT;
            _distance : LINT;
            _plcOpenState : PlcOpenState;
            _done : BOOL;
            _isHomed : BOOL;
            _statusRefSwitch : BOOL;
        END_VAR

        ///Outputs the current status of the axis and executes the protected methods(must be called in every cicle)
        METHOD PUBLIC RunCyclic
            _statusRefSwitch := ReferenceSwitch.Q();
            CASE _motionMode OF
                MotionMode#Stopped:
                    _plcOpenState := PlcOpenState#Ready;
                    ;
                MotionMode#Homing:
                    _plcOpenState := PlcOpenState#Busy;
                    _done := THIS._homing(velocity := _velocity, direction := _direction);
                    IF _done THEN
                        _plcOpenState := PlcOpenState#Done;
                        _isHomed := TRUE;
                        _motionMode := MotionMode#Stopped;
                    END_IF;
                MotionMode#MoveAbsolute:
                    IF (NOT (_isHomed)) THEN
                        _plcOpenState := PlcOpenState#Error;
                        RETURN;
                    END_IF;
                    _plcOpenState := PlcOpenState#Busy;
                    _done := THIS._moveAbsolute(velocity := _velocity, posititon := _position);
                    IF _done THEN
                        _plcOpenState := PlcOpenState#Done;
                        _motionMode := MotionMode#Stopped;
                    END_IF;
                    ;
                MotionMode#MoveRelative:
                    IF (NOT (_isHomed)) THEN
                        _plcOpenState := PlcOpenState#Error;
                        RETURN;
                    END_IF;
                    _plcOpenState := PlcOpenState#Busy;
                    _done := THIS._moveRelative(velocity := _velocity, distance := _distance);
                    IF _done THEN
                        _plcOpenState := PlcOpenState#Done;
                        _motionMode := MotionMode#Stopped;
                    END_IF;
                    ;
                MotionMode#MoveVelocity:
                    _plcOpenState := PlcOpenState#Busy;
                    Motor.Move(_velocity, _direction);

            END_CASE;
        END_METHOD

        ///Moves axis with a velocity
        /// Has to be stopped manually with Halt()
        METHOD PUBLIC MoveVelocity
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            _velocity := velocity;
             _direction := direction;
            _motionMode := MotionMode#MoveVelocity;
        END_METHOD

        ///Moves axis to a new position based on the current position
        METHOD PUBLIC MoveRelative : BOOL
            VAR_INPUT
                velocity : LREAL;
                distance : LINT;
            END_VAR
            _velocity := velocity;
            _distance := distance;
            _motionMode := MotionMode#MoveRelative;
        END_METHOD

        ///Moves axis to a new position based on the default position 
        ///homing the axis beforehand is needed to execute this function
        METHOD PUBLIC MoveAbsolute : BOOL
            VAR_INPUT
                velocity : LREAL;
                position : LINT;
            END_VAR
            _velocity := velocity;
            _position := position;
            _motionMode := MotionMode#MoveAbsolute;
        END_METHOD

        ///Moves axis to the default "homing" position (needed for moveAbsolute())
        METHOD PUBLIC Homing : BOOL
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            _velocity := velocity;
            _direction := direction;
            _motionMode := MotionMode#Homing;
        END_METHOD

        ///Homes axis without moving it into default position 
        ///Sets position to given value
        METHOD PUBLIC Homing : BOOL
            VAR_INPUT
                Position : LINT;
            END_VAR
            Encoder.SetValue(value := Position);
            _stateHoming := StatesHoming#Done;
            _plcOpenState := PlcOpenState#Done;
            _isHomed := TRUE;
        END_METHOD

        ///Stops movement of the axis
        ///needs to be called manually for MoveVelocity() 
        METHOD PUBLIC Halt
            Motor.Halt();
            _motionMode := MotionMode#Stopped;
            _plcOpenState := PlcOpenState#Done;
        END_METHOD
        ///Checks whether the axis is homed or not
        METHOD PUBLIC IsHomed : BOOL
            IsHomed := _isHomed;
        END_METHOD
      
     
       //Protected methods are executed by RunCyclic()
       
       ///Moves axis with a velocity
        /// Has to be stopped manually with Halt()
        METHOD PROTECTED _moveVelocity  
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            Motor.Move(velocity, direction);
        END_METHOD

        ///Moves axis to a new position based on the current position
        METHOD PROTECTED _moveRelative : BOOL
            VAR_INPUT
                velocity : LREAL;
                distance : LINT;
            END_VAR
            _moveRelative := THIS._moveAbsolute(velocity := velocity, posititon := Encoder.GetValue() + distance);
        END_METHOD

        ///Moves axis to a new position based on the default position 
        ///homing the axis beforehand is needed to execute this function
        METHOD PROTECTED _moveAbsolute : BOOL
            VAR_INPUT
                velocity : LREAL;
                posititon : LINT;
            END_VAR
            VAR_TEMP
                dir : Direction;
            END_VAR
            CASE _stateMoveAbsolute OF
                StateMoveAbsolute#Idle:
                    IF (posititon = Encoder.GetValue()) THEN 
                        _stateMoveAbsolute := StateMoveAbsolute#Done;
                        _moveAbsolute := TRUE;
                        Motor.Halt();
                    ELSE
                        _stateMoveAbsolute := StateMoveAbsolute#Moving;
                        Motor.Move(velocity, dir);
                    END_IF;
                    StateMoveAbsolute#Moving:
                    dir := THIS.DecideDirection(enc := Encoder, setPoint := posititon);
                    Motor.Move(velocity, dir);
                    IF (Encoder.GetValue() = posititon) THEN 
                        _stateMoveAbsolute := StateMoveAbsolute#Done;
                        Motor.Halt();
                    END_IF;
                    StateMoveAbsolute#Done:
                    _moveAbsolute := TRUE;
                    _stateMoveAbsolute := StateMoveAbsolute#Idle;
                    ;
            END_CASE;
        END_METHOD

        ///Homes axis without moving it into default position 
        ///Sets position to given value
        METHOD PROTECTED _homing : BOOL
            VAR_INPUT
                velocity : LREAL;
                direction : Direction;
            END_VAR
            // Reference switch already reached
            // Move out from the Reference switch in opposit direction
            CASE _stateHoming OF
                StatesHoming#Idle:
                    _isHomed := FALSE;
                    IF (ReferenceSwitch.Q()) THEN
                        _stateHoming := StatesHoming#MoveOutOfSensor;
                    ELSE
                        _stateHoming := StatesHoming#FindReferenceSensor;
                    END_IF;
                StatesHoming#MoveOutOfSensor:
                    Motor.Move(direction := THIS._oppositDirection(direction := direction));
                    IF (ReferenceSwitch.QFal()) THEN
                        Motor.Halt();
                        _stateHoming := StatesHoming#FindReferenceSensor;
                    END_IF;
                StatesHoming#FindReferenceSensor:
                    Motor.Move(direction := direction);
                    IF (ReferenceSwitch.QRis()) THEN
                        Motor.Halt();
                        Encoder.SetValue(value := 0);
                        _stateHoming := StatesHoming#Done;
                    END_IF;
                StatesHoming#Done:
                    _homing := TRUE;
                    _stateHoming := StatesHoming#Idle;
            END_CASE;
            ;
        END_METHOD

        ///inverts the current direction
        METHOD PROTECTED _oppositDirection : Direction
            VAR_INPUT
                direction : Direction;
            END_VAR
            IF (direction = Direction#PositiveDirection) THEN
                _oppositDirection := Direction#NegativeDirection;
            ELSE
                _oppositDirection := Direction#PositiveDirection;
            END_IF;
        END_METHOD

        ///decides the needed direction to reach setpoint
        METHOD PROTECTED DecideDirection : Direction
            VAR_INPUT
                enc : IEncoder;
                setpoint : LINT;
            END_VAR
            IF (setpoint >= enc.GetValue()) THEN
                DecideDirection := Direction#PositiveDirection;
            ELSE
                DecideDirection := Direction#NegativeDirection;
            END_IF;
        END_METHOD

        ///Outputs current status of the PLC
        METHOD PUBLIC GetPlcOpenState : PlcOpenState
            GetPlcOpenState := _plcOpenState;
        END_METHOD
        ///Returns whether the axis is busy with a movement command
        METHOD PUBLIC IsRunning : BOOL
            IsRunning := _plcOpenState = PlcOpenstate#Busy;
        END_METHOD
    END_CLASS

END_NAMESPACE
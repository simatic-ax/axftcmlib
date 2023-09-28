
# @simatic-ax.axftcmlib

## Description

This library was created for the `Fischertechnik Factorysimulation 24V`. It contains classes for the basic elements of this Model.
In the current state only the `SortingLine` is finished and can be fully implemented using this library.
This library includes the following classes:

- Cylinder
- Compressor
- ColorSensor
- Axis
- Encoder
- Motor

Those classes can be used for the calculation of the position based on the time.

## Install this package

Enter:

```cli
apax add @simatic-ax/axftcmlib
```

## Namespace

```iec-st
Simatic.Ax.axftcmlib
```

## Objects

## Example

Pneumatic Cylinder (*Note: Needs an active compressor to function with the model)

|Method|Description|
|-|-|
|PneumaticCylinderPush()|Cylinder pushes|
|PneumaticCylinderRetract()|Cylinder retracts|
|Start()| Activates StateMachine and executes it once|

<details><summary>Example for the class Cylinder ... </summary>
  
```iec-st
  VAR_GLOBAL
      SortingLineValveEjector : BOOL; //Actual PLC-variable
      CylinderOutputWriter : BinOutput; //Used to write on the PLC-variable
      CylinderClassInstance : PneumaticCylinder := (CoilPushing := CylinderOutputWriter); //Class instance initialized with the needed OutputWriter
      EnableCylinder : BOOL;
  END_VAR

  PROGRAM
    CylinderClassInstance.RunCyclic(); //Class Setup-> needs to be called in every cycle
    IF (EnableCylinder) THEN
      CylinderClassInstance.Start(); // start pushing the cylinder for a configured time
    END_IF;
    CylinderOutputWriter.WriteCyclic(Q => SortingLineValveEjector); //Writing on the Actual PLC-variable ->needs to be called in every cycle
  END_PROGRAM
  
```

</details>

Pneumatic compressor:
|Method|Description|
|-|-|
|PneumaticCompressorOn()|Turns the compressor on|
|PneumaticCompressorOff()|Turns the compressor off|

<details><summary>Example for the class Compressor ... </summary>
  
```iec-st

  VAR_GLOBAL
    SortingLineCompressor : BOOL; //Actual PLC-variable
    CompressorOutputWriter : BinOutput; //Used to write on the PLC-variable
    CompressorClassInstance : PneumaticCompressor := (ActiveCompressor := CompressorOutputWriter); // Class instance initialized with the needed OutputWriter
    EnableCCompressor : BOOL;
  END_VAR

  PROGRAM
    IF (EnableCCompressor) THEN
      CompressorClassInstance.PneumaticCompressorOn(); //Turning on the compressor -> Call only when needed (Off works the same way)
    END_IF;
    CompressorOutputWriter.WriteCyclic(Q => SortingLineCompressor);//Writing on the Actual PLC-variable ->needs to be called in every cycle
  END_PROGRAM
```

</details>

ColorSensor:
|Method|Description|
|-|-|
|DetectColor(DetectedColor : INT, ColorArray : ARRAY[*] OF ColorRange) : INT |Takes INT-value from sensor and compares it to a Array to find the correct color. ColorArray is a Array of ColorRanges which contains the thresholds for the corresponding color |

<details><summary>Example for the class ColorSensor ... </summary>
  
```iec-st
  
  VAR_GLOBAL
    SortingLineColorSensorValue : INT; //Actual Value provided from the sensor
    ColorSensorClassInstance : ColorSensor; //Instance of the class
    ColorValueArray[0..1] OF ColorRange := [(StartValue := 19801, EndValue := 30000, color := Colors#UNKNOWN), (StartValue := 6000, EndValue := 9999, color := Colors#WHITE)];
      //Gives the area in which each color is set
      ResultColor : INT;
  END_VAR

  
  PROGRAM
    ResultColor :=  ColorSensorClassInstance.detectColor(DetectedColor := SortingLineColorSensorValue, ColorArray := ColorValueArray);
    //outputs the detected color as an INT/ TYPE Colors (from Lib)
  END_PROGRAM
```

</details>

<details><summary>Colors and ColorRange ... </summary>

```iec-st

  ///Contains all Colors that the Sensor should know -> Can be expanded
  TYPE
      Colors : INT (UNKNOWN := 10, WHITE := 1, RED := 2,  BLUE := 3); // default value = UNKNOWN
  END_TYPE

  ///Defines the area in which the values equals a certain color
  TYPE
      ColorRange : STRUCT
          StartValue : INT;
          EndValue : INT;
          Color : colors;
      END_STRUCT;
  END_TYPE
```

</details>

Axis:

The Axis consists of a motor and an Encoder

<details><summary>Motor ... </summary>
  
|Method|Description|
|-|-|
|Move(Velocity : LREAL, direction := Direction) | starts movement depending on the direction|
|Halt()| Stops any current movement|

The motor is usually completely controlled through the Axis but needs to manually write on the output.

```iec-st

  VAR_GLOBAL
    SortingLineMotor : BOOL; //Actual PLC-variable
    MotorOutputWriterForward : BinOutput; //Used to write on the PLC-variable
    MotorOutputWriterReverse : BinOutput; //Used to write on the PLC-variable
    MotorClassInstance : MotorFT := (Forward := MotorOutputWriterForward, Reverse := MotorOutputWriterReverse ); //Class instance initialized with the needed OutputWriter
  END_VAR

  PROGRAM
  //The methods of the motor are all called by the axis but could be added here.
   MotorClassInstance.MoveVelocity(Velocity := 1.0, direction := Direction#Forward);
   MotorOutputWriterForward.WriteCyclic(Q =>SortingLineMotor);//Writing on the Actual PLC-variable ->needs to be called in every cycle
  END_PROGRAM

```

</details>

<details><summary>Encoder + TimeProvider ... </summary>

If you haven't a hardware encoder for the Axis, then you can simulate this hardware encoder by the `TimeBasedEncoder` which calculates the position based on time. The time will be provided by a TimeProvider. This `TimeProvider` is based on the PLC cycle time

TimeBasedEncoder:

|Method|Description|
|-|-|
|Reset()|Sets current Position to 0|
|SetValue(value : LINT)|Sets position to a certain value|
|GetValue() : LINT|Outputs current value as LINT in mm|
|Evaluate()|Measures change in position based on the velocity and cycle time (from the encoder)|

TimeProvider:

|Method|Description|
|-|-|
|Evaluate()| Measures the time needed for one cycle of the CPU|
|GetElapsedSeconds()| Outputs the measured time|

```iec-st

  VAR_GLOBAL
     TimeProviderForAxis : TimeProvider; //Class instance
     TimebasedEncoderForAxis         : TimeBasedEncoder  := (TimeProvider := TimeProviderForAxis, EncoderAxis := ConveyorbeltForSortingLine, Velocity := 1.0); //Class instance
      //Encoder needs access to the axis to check, if it is running
  END_VAR

  PROGRAM
    TimebasedEncoderForAxis.Evaluate(); //Checking the position every cycle -> must be called every cycle
    TimeProviderForAxis.Evaluate();    //Checking the cycle time -> must be called every cycle
   //Axis uses this information for the monitoring of the current position
  END_PROGRAM

```

</details>

|Method|Description|
|-|-|
|RunCyclic()| Execute the cyclic evaluation of the axis|
|MoveVelocity(Velocity : LREAL, direction : Direction)| moves the axis with given speed into certain direction until Halt() is called|
|MoveRelative(velocity : LREAL, distance : LINT) : BOOL|moves the axis for a distance based on the current position|
|MoveAbsolute(velocity : LREAL, position : LINT) : BOOL|moves the axis based on a default point -> Axis needs to be homed|
|Homing(velocity : LREAL, direction : Direction) : BOOL|moves the axis into its homing position|
|Homing(Position : LINT) : BOOL| homes the axes without movement -> position is set to given value|
|Halt()|Stops all movement|
|GetPlcOpenState() : PlcOpenState | Returns current status of axis: Ready, busy, done, error|
|IsRUnning() : BOOL| Checks, if the  axis is currently moving|

<details><summary>Example for the class Axis ... </summary>
  
```iec-st

  VAR_GLOBAL
    SortingLineMotor : BOOL; //Actual PLC-variable
    MotorOutputWriterForward : BinOutput; //Used to write on the PLC-variable
    MotorOutputWriterReverse : BinOutput; //Used to write on the PLC-variable
    MotorClassInstance : MotorFT := (Forward := MotorOutputWriterForward, Reverse := MotorOutputWriterReverse ); //Class instance initialized with the needed OutputWriter
  
    TimeProviderForAxis : TimeProvider; //Class instance
    TimebasedEncoderForAxis         : TimeBasedEncoder  := (TimeProvider := TimeProviderForAxis, EncoderAxis := ConveyorbeltForSortingLine, Velocity := 1.0); //Class instance

    AxisReferenceSwitch  : BinSignal;
    ConveyorbeltForSortingLine : Axis := (Motor :=  MotorForAxis, Encoder := TimebasedEncoderForAxis, ReferenceSwitch := AxisReferenceswitch);
  END_VAR

  PROGRAM
    TimebasedEncoderForAxis.Evaluate(); //Checking the position every cycle -> must be called every cycle
    TimeProviderForAxis.Evaluate();    //Checking the cycle time -> must be called every cycle
  
    ConveyorbeltForSortingLine.RunCyclic(); //Must be called every cycle
    ConveyorbeltForSortingLine.Homing(Position := 0);
    ConveyorbeltForSortingLine.MoveAbsolute(Velocity := 1.0, Position := 4000); 

     MotorForwardOutputWriter.WriteCyclic(Q => SortingLineMotorForConveyor); // Write output signals 
  END_PROGRAM

```

</details>

## Markdownlint-cli

This workspace will be checked by the [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli) (there is also documented ho to install the tool) tool in the CI workflow automatically.  
To avoid, that the CI workflow fails because of the markdown linter, you can check all markdown files locally by running the markdownlint with:

```sh
markdownlint **/*.md --fix
```

## Contribution

Thanks for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section or, even better, is free to propose any changes to this repository using Merge Requests.

## License and Legal information

Please read the [Legal information](LICENSE.md)

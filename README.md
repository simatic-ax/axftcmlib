
# @simatic-ax.axftcmlib

## Description

This library was created for the “Fischertechnik Factorysimulation 24V”. It contains classes for the basic elements of this Model.
In the current state only the “Sortingline” is finished and can be fully implemented using this library.
This library includes the following classes:
Cylinder, Compressor, Color sensor and Axis + Motor + Encoder.
*Note: Since the Encoder included with the model could not be accessed due to hardware limitations, the library includes TimebasedEncoder as well as Timeprovider to substitute this.
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
|Start()| Activates Staemachine and executes it once|

<details><summary>Example for the class Cylinder ... </summary>
  
```iec-st
  VAR_GLOBAL
      SortinglineValveEjector : BOOL; //Actual PLC-variable
      CylinderOutputWriter : BinOutput; //Used to write on the PLC-variable
      CylinderClassInstance : PneumaticCylinder := (CoilPushing := CylinderOutputWriter); //Classinstance initialized with the needed Outputwriter
  END_VAR

  PROGRAM
    CylinderClassInstance.RunCyclic(); //Class Setup-> needs to be called in every cycle
    CylinderClassInstance.Start(); //actual executen of the cylinder -> Call only when needed
    CylinderOutputwriter.WriteCyclic(Q => SortinglineValveEjector); //Writing on the Actual PLC-variable ->needs to be called in every cycle
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
    SortinglineCompressor : BOOL; //Actual PLC-variablel
    CompressorOutputWriter : BinOutput; //Used to write on the PLC-variable
    CompressorClassInstance : PneumaticCompressor := (ActiveCompressor := CompressorOutputWriter); //Classinstance initialized with the needed Outputwriter
  END_VAR

  PROGRAMM
    CompressorClassInstance.PneumaticCompressorOn(); //Turning on the compressor -> Call only when needed (Off works the same way)
    CompressorOutputWriter.WriteCyclic(Q => SortinglineCompressor);//Writing on the Actual PLC-variable ->needs to be called in every cycle
  END_PROGRAMM

```

</details>

ColorSensor:
|Method|Description|
|-|-|
|DetectColor(DetectedColor := INT-VALUE, ColorArray := ARRAY[*] OF COLORRANGE) : INT |Takes INT-value from sensor and compares it to a Array to find the correct color|

<details><summary>Example for the class ColorSensor ... </summary>
  
```iec-st

  VAR_GLOBAL
    SortinglineColorSensorValue : INT; //Actual Value provided from the sensor
    ColorSensorClassInstance : ColorSesnor; //Instance of the class
    ColorValueArray[0..1] OF ColorRange := [(StartValue := 19801, EndValue := 30000, color := Colors#UNKNOWN), (StartValue := 6000, EndValue := 9999, color := Colors#WHITE)];
      //Gives the area in which each color is set
  END_VAR

  VAR
      ReesultColor : INT;
  END_VAR

  PROGRAMM
    ResultColor :=  ColorSensorClassInstance.detectColor(DetectedColor := SortinglineColorSensorValue, AolorArray := ColorValueArray);
    //outputs the detected color as an INT/ TYPE Colors (from Lib)
  END_PROGRAMM

```

</details>

Axis:

The Axis consists of a motor and an Encoder

<details><summary>Motor ... </summary>
  
|Method|Description|
|-|-|
|Move(Velocity := LREAL, direchtion := Direction) | starts movement depending on the direction|
|Halt()| Stops any current movement|

The motor is usually completly controlled through the Axis but needs to manually write on the output.

```iec-st

  VAR_GLOBAL
    SortinglineMotor : BOOL; //Actual PLC-variablel
    MotorOutputWriterForward : BinOutput; //Used to write on the PLC-variable
    MotorOutputWriterReverse : BinOutput; //Used to write on the PLC-variable
    MotorClassInstance : MotorFT := (Forward := MotorOutputWriterForward, Reverse := MotorOutputWriterReverse ); //Class instance initialized with the needed Outputwriter
  END_VAR

  PROGRAMM
  //The methods of the motor are all called by the axis but could be added here.
   MotorClassInstance.Move(Velocity := 1.0, direchtion := Direction#Forward);
   MotorOutputWriterForward.WriteCyclic(Q =>SortinglineMotor);//Writing on the Actual PLC-variable ->needs to be called in every cycle
  END_PROGRAMM

```

</details>

<details><summary>Encoder + Timeprovider ... </summary>

Due to hardwarelimitations, the provided encoder could not be used. Therefore an alternative is provided here based on the cycle time of the CPU.
For this an additional Timeprovider is needed.

TimeBasedEncoder:

|Method|Description|
|-|-|
|Reset()|Sets current Position to 0|
|SetValue(value := LINT)|Sets position to a certain value|
|GetValue() : LINT|Outputs current value as LINT in mm|
|Evaluate()|Measures change in position based on the velocity and cycletime( from the encoder)|

Timeprovider:

|Method|Description|
|-|-|
|Evaluate()| Measures the time needed for one cylce of the CPU|
|GetElapsedSeconds()| Outputs the measured time|

```iec-st

  VAR_GLOBAL
     TimeProviderForAxis : Timeprovider; //Class instance
     TimebasedEncoderForAxis         : TimeBasedEncoder  := (Timeprovider := TimeproviderForAxis, EncoderAxis := ConveyorbeltForSortingline, Velocity := 1.0); //Class instance
      //Encoder needs acces to the axis to check, if it is running
  END_VAR

  PROGRAMM
    TimebasedEncoderForAxis.Evaluate(); //Checking the position every cycle -> must be called every cycle
    TimeproviderForAxis.Evaluate();    //Checking the cycletime -> must be called every cycle
   //Axis uses this information for the monitoring of the current position
  END_PROGRAMM

```

</details>

|Method|Description|
|-|-|
|RunCyclic()| Checks the current status and changes the motionmode of the Axis|
|MoveVelocity(Velocity := LREAL, direction := Direction)| moves the axis with given speed into certain direction until Halt() is called|
|MoveRelative(velocity := LREAL, distance := LINT) : BOOL|moves the axis for a distance based on the current position|
|MoveAbsolute(velocity := LREAL, position := LINT) : BOOL|moves the axis based on a default point -> Axis needs to be homed|
|Homing(velocity := LREAL, direction : Direction) : BOOL|moves the axis into its homing position|
|Homing(Position := LINT) : BOOL| homes the axes without movement -> position is set to given value|
|Halt()|Stops all movement|
|GetPlcOpenState() : PlcOpenstate | Returns current status of axis: Ready, busy, done, error|
|IsRUnning() : BOOL| Checks, if the  axis is currently moving|

<details><summary>Example for the class Axis ... </summary>
  
```iec-st

  VAR_GLOBAL
    SortinglineMotor : BOOL; //Actual PLC-variablel
    MotorOutputWriterForward : BinOutput; //Used to write on the PLC-variable
    MotorOutputWriterReverse : BinOutput; //Used to write on the PLC-variable
    MotorClassInstance : MotorFT := (Forward := MotorOutputWriterForward, Reverse := MotorOutputWriterReverse ); //Class instance initialized with the needed Outputwriter
  
    TimeProviderForAxis : Timeprovider; //Class instance
    TimebasedEncoderForAxis         : TimeBasedEncoder  := (Timeprovider := TimeproviderForAxis, EncoderAxis := ConveyorbeltForSortingline, Velocity := 1.0); //Class instance

    AxisReferenceSwitch  : BinSignal;
    ConveyorbeltForSortingline : Axis := (Motor :=  MotorForAxis, Encoder := TimebasedEncoderForAxis, ReferenceSwitch := AxisReferenceswitch);
  END_VAR

  PROGRAMM
    TimebasedEncoderForAxis.Evaluate(); //Checking the position every cycle -> must be called every cycle
    TimeproviderForAxis.Evaluate();    //Checking the cycletime -> must be called every cycle
  
    ConveyorbeltForSortingline.RunCyclic(); //Must be called every cycle
    ConveyorbeltForSortingline.Homing(Position := 0);
    ConveyorbeltForSortingline.MoveAbsolute(Velocity := 1.0, Position := 4000); 

     MotorForwardOutputWriter.WriteCyclic(Q => SortinglineMotorForConveyor); //Motor actually witingon the PLC-variable -> must be called every cycle
  END_PROGRAMM

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

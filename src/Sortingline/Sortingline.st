USING Simatic.Ax.IO;
USING Simatic.Ax.axftcmlib;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.StateFramework;
USING System.Timer;
NAMESPACE Simatic.Ax.axftcmlib
    CLASS Sortingline EXTENDS ControlModuleAbstract IMPLEMENTS ISortingline

        VAR PUBLIC
        
            SlAxis : Axis;
            SlTimeProvider : TimeProvider;
            SlAxisVelocity : LREAL;
            SlAxisPositionColorSensor : LINT;
            SlAxisPositionWhite : LINT;
            SlAxisPositionRed : LINT;
            SlAxisPositionBlue : LINT;
            Homingposition : LINT := 0;
            SlColorSensor : ColorSensor;
            SlColorvalue : INT;
            ResultColor : INT;
            ColorArray : ARRAY[0..3] OF ColorRange;
            SlCompressor : PneumaticCompressor; 
            SlCoilPushingWhite : IBinOutput;
            SlCoilpushingRed : IBinOutput;
            SlCoilPushingBlue : IBinOutput;
            SlSensorActivation : BOOL;
            SlSensorSorting : BOOL;

            //........
            SlDirection : INT := 0;
            //SlClearTime : LTIME := LT#5s;
           Activetime : PULSE := (duration := LT#5.0s);
        END_VAR

        METHOD PUBLIC SlMoveToColorSensor
           SlAxis.Homing(Homingposition);
           SlAxis.moverelative(SlAxisVelocity, SlAxisPositionColorSensor);
        END_METHOD

        METHOD PUBLIC SlDetectColor : BOOL
            ResultColor :=  SlColorsensor.detectColor(SlColorValue, ColorArray);
            IF ResultColor = Colors#Unknown THEN
                SlDetectColor := FALSE;
            ELSE
                SlDetectColor := TRUE;
            END_IF;
        END_METHOD

        METHOD PUBLIC SlMoveToSensor
            SlAxis.MoveVelocity(SlAxisVelocity, SlDirection);
        END_METHOD

    METHOD PUBLIC SlClearConveyor
        VAR
            Trigger : BOOL;
        END_VAR
             Trigger := TRUE; 
             IF ActiveTime.output THEN
                 SlAxis.MoveVelocity(SlAxisVelocity,SlDirection);
             ELSE
                SlAxis.HALT();
             END_IF;
    END_METHOD
        


        METHOD PROTECTED OVERRIDE RunCyclicCustom
            ;
        END_METHOD

        METHOD PROTECTED OVERRIDE Constructor
            ;
        END_METHOD

    END_CLASS
END_NAMESPACE 
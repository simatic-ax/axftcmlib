
NAMESPACE Simatic.Ax.axftcmlib

    ///Contains all Colors that the Sensor should know -> Can be expanded 
    TYPE
        Colors : INT (UNKNOWN := 10, WHITE := 1, RED := 2,  BLUE := 3); //defaultvalue = UNKNOWN
    END_TYPE

    ///Defines the area in which the values equals a certain color
    TYPE
        ColorRange : STRUCT
            StartValue : INT;
            EndValue : INT;
            Color : colors;
        END_STRUCT;
    END_TYPE

    ///Based on the analogous sensor used in the Fischertechnik FactorySimulation
    CLASS ColorSensor 
        VAR PROTECTED
            ColorDetected : BOOL;
        END_VAR

        ///Compares detected value with an array of predefined colorvalues to determin the color 
        METHOD PUBLIC detectColor : INT
        VAR_INPUT
        DetectedColorValue : INT;
        ColorArray : ARRAY[*] OF ColorRange;
        END_VAR

        VAR 
            Counter : DINT;
        END_VAR
        ColorDetected := FALSE;
        FOR Counter := LOWER_BOUND(ColorArray,1) TO UPPER_BOUND(ColorArray,1) DO
            IF DetectedColorValue >= ColorArray[counter]. StartValue AND DetectedColorValue <= ColorArray[counter].EndValue THEN
                detectColor := ColorArray[Counter].color;
                ColorDetected := TRUE;
            END_IF;
        END_FOR;

            IF ColorDetected = FALSE THEN
                detectColor := Colors#Unknown;
            END_IF;
        
        END_METHOD

    END_CLASS

END_NAMESPACE





NAMESPACE Simatic.Ax.axftcmlib

    TYPE //Expand here
        Colors : INT (UNKNOWN := 10, WHITE := 1, RED := 2,  BLUE := 3); //defaultwert = UNKNOWN
    END_TYPE

    TYPE
        ColorRange : STRUCT
            _from : INT;
            _to : int;
            color : colors; //=Int würde auch funktionieren
        END_STRUCT;
    END_TYPE

    CLASS ColorSensor 
        VAR PROTECTED
            ColorDetected : BOOL;
        END_VAR

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
            IF DetectedColorValue >= ColorArray[counter]._from AND DetectedColorValue <= ColorArray[counter]._to THEN
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




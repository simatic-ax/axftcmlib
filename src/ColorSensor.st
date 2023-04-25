// USING Simatic.Ax.IO.Input;
// USING Simatic.Ax.IO;
// USING Simatic.Ax.IO;


NAMESPACE Simatic.Ax.axftcmlib
    TYPE
        Colors : INT (UNKNOWN := 10, WHITE := 1, RED := 2,  BLUE := 3); //defaultwert = UNKNOWN
    END_TYPE

    CLASS ColorSensor 
        
        VAR PUBLIC
            OutputColor : INT;
        END_VAR

        METHOD PUBLIC detectColor //TODO : INT als returnwert
        VAR_INPUT
        DetectedColorValue : INT;
        END_VAR
        IF DetectedColorValue < 10000 THEN //TODO Grenzen avariable
            OutputColor := Colors#WHITE;
        ELSIF DetectedColorValue <15000 THEN
            OutputColor := Colors#RED;
        ELSIF DetectedColorValue <20000 THEN
            OutputColor := Colors#BLUE;
        END_IF;
        //ELSIF Error if nothing detected 
       
        END_METHOD

    END_CLASS

END_NAMESPACE




// NAMESPACE Simatic.Ax.axftcmlib
//     TYPE
//         Colors : (RED, WHITE, BLUE, UNKNOWN) := UNKNOWN; //defaultwert = UNKNOWN
//     END_TYPE

//     CLASS ColorSensor //IMPLEMENTS IColorSensor
    
//         VAR PUBLIC
//             OutputColor : colors;
//         END_VAR


//         METHOD PUBLIC detectColor
//         VAR_INPUT
//         DetectedColorValue : INT;
//         END_VAR
//         IF DetectedColorValue < 10000 THEN
//             OutputColor := Colors#WHITE;
//         ELSIF DetectedColorValue <15000 THEN
//             OutputColor := Colors#RED;
//         ELSIF DetectedColorValue <20000 THEN
//             OutputColor := Colors#BLUE;
//         END_IF;

//         END_METHOD

//     END_CLASS

// END_NAMESPACE
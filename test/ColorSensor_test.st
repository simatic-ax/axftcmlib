USING AxUnit.Assert;

NAMESPACE Simatic.Ax.axftcmlib

    {TestFixture}
    CLASS MyColorSensorTest
        VAR PROTECTED
            _testColorSensor : ColorSensor;
            _SetOfColors : ARRAY[0..3] OF ColorRange := [(_from := 0, _to := 1, color := Colors#UNKNOWN),
            (_from := 2, _to := 3, color := Colors#WHITE),(_from := 4, _to := 5, color := Colors#RED),
            (_from := 6, _to := 7, color := Colors#BLUE)];
        END_VAR

        {Test}
        METHOD PUBLIC TestDetectionUnknown_Expect_True
            VAR_TEMP
                Dummy : BOOL;
            END_VAR
            Dummy := FALSE;
            IF _testColorSensor.detectColor(DetectedColorValue := 1,ColorArray := _SetOfColors) = 10 THEN
                Dummy := TRUE;
            END_IF;
            AxUnit.Assert.Equal(expected := TRUE, actual := Dummy);
        END_METHOD

        {Test}
        METHOD PUBLIC TestDetectionWhite_Expect_True
            VAR_TEMP
                Dummy : BOOL;
            END_VAR
            Dummy := FALSE;
            IF _testColorSensor.detectColor(DetectedColorValue := 2,ColorArray := _SetOfColors) = 1 THEN
                Dummy := TRUE;
            END_IF;
            AxUnit.Assert.Equal(expected := TRUE, actual := Dummy);
        END_METHOD

        {Test}
        METHOD PUBLIC TestDetectionRed_Expect_True
            VAR_TEMP
                Dummy : BOOL;
            END_VAR
            Dummy := FALSE;
            IF _testColorSensor.detectColor(DetectedColorValue := 5,ColorArray := _SetOfColors) = 2 THEN
                Dummy := TRUE;
            END_IF;
            AxUnit.Assert.Equal(expected := TRUE, actual := Dummy);
        END_METHOD

        {Test}
        METHOD PUBLIC TestDetectionBlue_Expect_True
            VAR_TEMP
                Dummy : BOOL;
            END_VAR
            Dummy := FALSE;
            IF _testColorSensor.detectColor(DetectedColorValue := 6,ColorArray := _SetOfColors) = 3 THEN
                Dummy := TRUE;
            END_IF;
            AxUnit.Assert.Equal(expected := TRUE, actual := Dummy);
        END_METHOD
    END_CLASS

END_NAMESPACE


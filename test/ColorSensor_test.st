USING AxUnit.Assert;

NAMESPACE Simatic.Ax.axftcmlib
    {TestFixture}
    Class MyColorSensorTest

        VAR PROTECTED
            _testColorSensor : ColorSensor;
            //_testSubject : colors; 
        END_VAR

        // METHOD PROTECTED SetUp
        //     _testColorSensor.OutputColor := _testSubject;
        // END_METHOD

        {Test}
        METHOD PUBLIC TestDetectionWhite_Expect_True
            VAR_TEMP
                Dummy : BOOL;
            END_VAR

            // THIS.SetUp();
            Dummy := FALSE;
            _testColorSensor.detectColor(DetectedColorValue := 9000);
            IF _testColorSensor.OutputColor = 1 THEN
                Dummy := TRUE;
            END_IF;
            AxUnit.Assert.Equal(expected := TRUE, actual := Dummy); 
        END_METHOD

        {Test}
        METHOD PUBLIC TestDetectionRed_Expect_True
            VAR_TEMP
                Dummy : BOOL;
            END_VAR

            // THIS.SetUp();
            Dummy := FALSE;
            _testColorSensor.detectColor(DetectedColorValue := 14000);
            IF _testColorSensor.OutputColor = 2 THEN
                Dummy := TRUE;
            END_IF;
            AxUnit.Assert.Equal(expected := TRUE, actual := Dummy); 
        END_METHOD

        {Test}
        METHOD PUBLIC TestDetectionBlue_Expect_True
            VAR_TEMP
                Dummy : BOOL;
            END_VAR

            // THIS.SetUp();
            Dummy := FALSE;
            _testColorSensor.detectColor(DetectedColorValue := 19000);
            IF _testColorSensor.OutputColor = 3 THEN
                Dummy := TRUE;
            END_IF;
            AxUnit.Assert.Equal(expected := TRUE, actual := Dummy); 
        END_METHOD


    END_CLASS
END_NAMESPACE
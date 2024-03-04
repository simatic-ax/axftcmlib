USING AxUnit.Assert;
NAMESPACE Simatic.Ax.axftcmlib.Motion

    {TestFixture}
    CLASS TestAxis
        VAR
            o : AxisBaseTestImpl;
            oStateLess : AxisBaseTestImpl;
            toAxis : TO_Axis;
        END_VAR
        
        {TestSetup}
        METHOD PUBLIC TestSetup
            o := oStateLess;
            o.Attach(REF(toAxis));
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC PowerOn_Leads_To_Powered_Axis
            o.PowerOn();
            Equal(expected := TRUE, actual := toAxis.isPowerdOn);
        END_METHOD

        {Test}
        METHOD PUBLIC PowerOff_Leads_To_Off_Powered_Axis
            o.PowerOn();
            o.PowerOff();
            Equal(expected := FALSE, actual := toAxis.isPowerdOn);
        END_METHOD

    END_CLASS

    CLASS AxisBaseTestImpl EXTENDS AxisBase
    
        METHOD PROTECTED OVERRIDE MakeAxisAbstract
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE

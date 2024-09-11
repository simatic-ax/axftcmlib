USING AxUnit.Assert;
USING Simatic.Ax.Commands;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.axftcmlib.Motion

    {TestFixture}
    CLASS testCommandHome
        VAR
            axis : PosAxis;
            axisStateLess : PosAxis;
            toAxis : TO_PosAxis;
            toAxisStateLess : TO_PosAxis;
            command : itfCommand;
            cmdHomeDirect : commandHomeDirect; 
            encoder : MockEncoder;
        END_VAR
        
        {TestSetup}
        METHOD PUBLIC TestSetup
            axis := axisStateLess;
            toAxis := toAxisStateLess;
            toAxis.Encoder := encoder;
            ;
        END_METHOD

        {Test}
        METHOD PUBLIC CommandHome_To_100_Set_Position_to_100
            axis.Attach(REF(toAxis));
            axis.PowerOn();
            command := cmdHomeDirect.Start(AxisRef := REF(toAxis), Position := 100.0);
            Equal(expected := 100.0, actual := toAxis.GetPosition());
        END_METHOD
        {Test}
        METHOD PUBLIC An_running_Axis_cant_be_homed
            axis.Attach(REF(toAxis));
            axis.PowerOn();
            axis.MoveVelocity(100.0, Direction#PositiveDirection);
            command := cmdHomeDirect.Start(AxisRef := REF(toAxis), Position := 100.0);
            Equal(expected := TRUE, actual := command.Error());
            NotEqual(expected := WORD#0000, actual := command.ErrorID());
            Equal(expected := 0.0, actual := toAxis.GetPosition());
        END_METHOD
    END_CLASS

    CLASS MockEncoder IMPLEMENTS IEncoder
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            _value : LINT;
            _RelativeCount : LINT;
        END_VAR
        
        METHOD PUBLIC MyMethod
            ;
        END_METHOD
    
        METHOD PUBLIC Evaluate
            ;
        END_METHOD
    
        METHOD PUBLIC Reset
            ;
        END_METHOD
    
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LINT;
            END_VAR
            _value := value;
            _RelativeCount := value;
            ;
        END_METHOD
    
        METHOD PUBLIC GetValue : LINT
            GetValue := _value;
        END_METHOD
    
        METHOD PUBLIC SetDirection
            VAR_INPUT
                mode : CountMode;
            END_VAR

            ;
        END_METHOD
    
        METHOD PUBLIC RelativeCount : LINT
            RelativeCount := _RelativeCount;
        END_METHOD
    
        METHOD PUBLIC ResetRelative
            _RelativeCount := LINT#0;
        END_METHOD
    
        METHOD PUBLIC GetModulo : LINT
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE

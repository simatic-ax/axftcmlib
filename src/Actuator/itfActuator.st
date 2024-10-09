USING Simatic.Ax.Commands;

NAMESPACE Simatic.Ax.axftcmlib

    INTERFACE itfActuator
        METHOD GoToHomePosition : itfCommand
        END_METHOD
    END_INTERFACE

    INTERFACE itfTwoWayActuator EXTENDS itfActuator
        METHOD GoToWorkPosition : itfCommand
        END_METHOD
    END_INTERFACE

END_NAMESPACE

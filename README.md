# @simatic-ax.axftcmlib

## Description
This library was created for the “Fischertechnik Factorysimulation 24V”. It contains classes for the basic elements of this Model. In the current state only the “Sortingline” is finished and can be fully implemented using this library. 
This library includes the following classes: 
Cylinder, Compressor, Color sensor and Axis + Motor + Encoder. 
*Note: Since the Encoder included with the model could not be accessed due to hardware limitations, the library includes TimebasedEncoder as well as Timeprovider to substitute this. Those classes can be used for the calculation of the position based on the time. 

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

<please provide a working example>

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

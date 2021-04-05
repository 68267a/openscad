# openscad
buncha stuff
# REQUIRES

lib/
https://github.com/JustinSDK/dotSCAD.git

## Powershell
`$env:OPENSCADPATH=$PWD;$PWD\lib\dotSCAD\src`
[System.Environment]::SetEnvironmentVariable("OPENSCADPATH","$PWD\lib\dotSCAD\src;$PWD\lib\mine")

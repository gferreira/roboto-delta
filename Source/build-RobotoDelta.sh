
source tools/roboto-delta-env/bin/activate

## MAKE VF

fontmake -m source/Roman/RobotoDelta-Roman.designspace -o variable --output-path fonts/LGCAlpha/RobotoDelta-Roman-VF.ttf --no-production-names --no-check-compatibility

fontmake -m source/Italic/RobotoDelta-Italic.designspace -o variable --output-path fonts/LGCAlpha/RobotoDelta-Italic-VF.ttf --no-production-names --no-check-compatibility

deactivate

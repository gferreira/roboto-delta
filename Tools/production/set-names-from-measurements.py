# menuTitle: compare source names with actual measurements

import os, glob
from xTools4.modules.measurements import FontMeasurements, permille, setSourceNamesFromMeasurements

baseFolder       = os.path.dirname(os.getcwd())
subFamilyName    = ['Roman', 'Italic'][0]
familyName       = f'RobotoDelta {subFamilyName}'
sourcesFolder    = os.path.join(baseFolder, 'Source', subFamilyName)
measurementsPath = os.path.join(sourcesFolder, 'measurements.json')

assert os.path.exists(sourcesFolder)

ignoreTags = ['wght', 'GRAD', 'BARS', 'VANG', 'VROT', 'XTSP']

setSourceNamesFromMeasurements(
        sourcesFolder,
        familyName,
        measurementsPath,
        preflight=True,
        ignoreTags=ignoreTags,
)

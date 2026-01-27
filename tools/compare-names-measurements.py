# menuTitle: set source names from measurements

import os, glob
from xTools4.modules.measurements import FontMeasurements, permille # setSourceNamesFromMeasurements

baseFolder       = os.path.dirname(os.getcwd())
subFamilyName    = ['Roman', 'Italic'][0]
sourcesFolder    = os.path.join(baseFolder, 'Source', subFamilyName)
measurementsPath = os.path.join(sourcesFolder, 'measurements.json')

assert os.path.exists(sourcesFolder)

ignoreTags = ['wght', 'GRAD', 'BARS', 'VANG', 'VROT', 'XTSP'] # 'BARS',

allSources = glob.glob(f'{sourcesFolder}/*.ufo')

M = FontMeasurements()
M.read(measurementsPath)

for srcPath in sorted(allSources):
    folder, fileNameExt = os.path.split(srcPath)
    fileName, ext = os.path.splitext(fileNameExt)
    styleName = '-'.join(fileName.split('-')[2:])
    param, value = styleName[:4], styleName[4:]
    if param in ignoreTags:
        continue
    f = OpenFont(srcPath, showInterface=False)
    M.measure(f)
    newValue = permille(M.values.get(param), 2048)
    print(param, value, newValue)

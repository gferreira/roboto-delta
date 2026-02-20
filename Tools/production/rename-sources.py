# menuTitle: rename all parametric sources

import os, glob, shutil
from xTools4.modules.measurements import FontMeasurements, permille

baseFolder       = os.path.dirname(os.getcwd())
familyName       = f'RobotoDelta'
subFamilyName    = ['Roman', 'Italic'][0]
sourcesFolder    = os.path.join(baseFolder, 'Source', subFamilyName)
measurementsPath = os.path.join(sourcesFolder, 'measurements.json')

assert os.path.exists(sourcesFolder)

ignoreTags = ['wght', 'GRAD', 'BARS', 'VANG', 'VROT', 'XTSP']

allSources = glob.glob(f'{sourcesFolder}/*.ufo')

M = FontMeasurements()
M.read(measurementsPath)

print('renaming sources...\n')

for srcPath in sorted(allSources):
    folder, fileNameExt = os.path.split(srcPath)
    fileName, ext = os.path.splitext(fileNameExt)
    styleName = '-'.join(fileName.split('-')[2:])
    param, value = styleName[:4], styleName[4:]
    if param in ignoreTags:
        continue
    f = OpenFont(srcPath, showInterface=False)
    M.measure(f)
    measurement = permille(M.values.get(param), 2048)
    newStyleName = f'{param}{measurement}'
    newFileName  = f'{familyName}-{subFamilyName}_{newStyleName}.ufo'
    print(f'old name: {fileNameExt}')
    print(f'new name: {newFileName}')
    print()
    f.info.styleName = newStyleName
    f.save()
    f.close()
    
    newSourcePath = os.path.join(folder, newFileName)
    shutil.move(srcPath, newSourcePath)

print('...done!\n')

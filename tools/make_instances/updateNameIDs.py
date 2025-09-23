import xml.etree.ElementTree as ET
import argparse

parser = argparse.ArgumentParser(description='A program to catch current location')
parser.add_argument("-l", "--location", help="location coordinates", default="wght400-wdth100-opsz14-GRAD0")
parser.add_argument("-p", "--ttxpath", help="location of ttx to update", default="wght400-wdth100-opsz14-GRAD0.ttx")
parser.add_argument("-o", "--ttxpath_output", help="location of ttx to update output", default="wght400-wdth100-opsz14-GRAD0.ttx")
args = parser.parse_args()
print(args.location)

tree = ET.parse(str(args.ttxpath))

for namerecord in tree.findall('.*/namerecord[@nameID="1"]'):
    print (namerecord)
    namerecord.text = 'Roboto Delta'
    
for namerecord in tree.findall('.*/namerecord[@nameID="2"]'):
    print (namerecord)
    namerecord.text = args.location

for namerecord in tree.findall('.*/namerecord[@nameID="4"]'):
    print (namerecord)
    namerecord.text = 'Roboto Delta ' + args.location

for namerecord in tree.findall('.*/namerecord[@nameID="6"]'):
    print (namerecord)
    namerecord.text = 'Roboto Delta-' + args.location

tree.write(args.ttxpath_output, encoding="UTF-8", xml_declaration=True)



source tools/RobotoflexA2-env/bin/activate

## MAKE INSTANCES
# fontmake -m source/Parametric-avar2/Roboto-Delta-blended-parametric.designspace -i -o ufo --output-dir source/Parametric-avar2/instances/


## instancer
# fonttools varLib.instancer fonts/LGCAlpha/Roboto-Delta-blended-parametric-VF.ttf opsz=144 wght=100 wdth=25 -o fonts/LGCAlpha/Roboto-Delta-opsz144-wdth25-wght100.ttf --static

#Array values to loop
#declare -a weights=('100' '200' '300' '400' '500' '600' '700' '800' '900' '1000')
#declare -a widths=('25' '100' '151')
#declare -a opticalsize=('8' '14' '144')
#declare -a grade=('0' '-250'  '150')

declare -a weights=('100' '400' '1000')
declare -a widths=('25' '100' '151')
declare -a opticalsize=('8' '14' '144')
declare -a grade=('0')
declare -a slant=('0' '1')

for fontGrade in ${grade[@]}
do
	for fontSlant in ${slant[@]}
	do
		for fontOpticalSize in ${opticalsize[@]}
		do
			for fontWidth in ${widths[@]}
				do
				
				mkdir fonts/LGCAlpha/instances/'GRAD'$fontGrade'-opsz'$fontOpticalSize'-wdth'$fontWidth'-slnt'$fontSlant
				
				for fontWeight in ${weights[@]}
				do
					PATH_INSTANCES='fonts/LGCAlpha/instances'
					PATH_GRADE='GRAD'$fontGrade'-opsz'$fontOpticalSize'-wdth'$fontWidth'-slnt'$fontSlant
					FILENAME=Roboto-Delta-'GRAD'$fontGrade-opsz$fontOpticalSize-wdth$fontWidth-wght$fontWeight'-slnt'$fontSlant
					FULL_PATH=$PATH_INSTANCES/$PATH_GRADE
					LOCATION='GRAD'$fontGrade'-opsz'$fontOpticalSize'-wdth'$fontWidth'-wght'$fontWeight'-slnt'$fontSlant
					
					if [ $fontSlant == 0 ]; then
						fonttools varLib.instancer fonts/LGCAlpha/Roboto-Delta-blended-parametric-no-slant-VF.ttf opsz=$fontOpticalSize wght=$fontWeight wdth=$fontWidth -o $FULL_PATH/$FILENAME.ttf --static
					else
						fonttools varLib.instancer fonts/LGCAlpha/Roboto-Delta-blended-parametric-slant-VF.ttf opsz=$fontOpticalSize wght=$fontWeight wdth=$fontWidth -o $FULL_PATH/$FILENAME.ttf --static
					fi
					# ttx name
					ttx -t name $FULL_PATH/$FILENAME.ttf
					
					# Update nameIDs
					python tools/make_instances/updateNameIDs.py -l $LOCATION -p $FULL_PATH/$FILENAME.ttx -o $FULL_PATH/$FILENAME'-output'.ttx
					
					#merge with new nameIDs
					ttx -m $FULL_PATH/$FILENAME.ttf $FULL_PATH/$FILENAME'-output'.ttx
					
					#rename output
					rm $FULL_PATH/$FILENAME.ttf
					rm $FULL_PATH/$FILENAME.ttx
					rm $FULL_PATH/$FILENAME'-output'.ttx
					mv $FULL_PATH/$FILENAME'-output'.ttf $FULL_PATH/$FILENAME.ttf
					
				done
			
			done
		done
	done
done

deactivate

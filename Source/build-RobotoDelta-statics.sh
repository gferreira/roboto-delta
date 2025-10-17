
source tools/RobotoflexA2-env/bin/activate

declare -a weights=('100' '400' '1000')
declare -a widths=('25' '100' '151')
declare -a opticalsize=('8' '14' '144')
declare -a grade=('0')
declare -a posture=('Roman' 'Italic')

for fontGrade in ${grade[@]}
do
	for fontPosture in ${posture[@]}
	do
		for fontOpticalSize in ${opticalsize[@]}
		do
			for fontWidth in ${widths[@]}
				do
				
				declare DIR_NAME='fonts/LGCAlpha/statics/'$fontPosture'-GRAD'$fontGrade'-opsz'$fontOpticalSize'-wdth'$fontWidth
				
				# Check if the directory exists
				if [ -d $DIR_NAME ]; then
					# If it exists, remove it and its contents recursively and forcefully
					rm -r $DIR_NAME
				fi
				
				mkdir $DIR_NAME
				
				for fontWeight in ${weights[@]}
				do
					PATH_INSTANCES='fonts/LGCAlpha/statics'
					PATH_GRADE=$fontPosture'-GRAD'$fontGrade'-opsz'$fontOpticalSize'-wdth'$fontWidth
					FILENAME=RobotoDelta-$fontPosture'-GRAD'$fontGrade-opsz$fontOpticalSize-wdth$fontWidth-wght$fontWeight
					FULL_PATH=$PATH_INSTANCES/$PATH_GRADE
					LOCATION=$fontPosture'-GRAD'$fontGrade'-opsz'$fontOpticalSize'-wdth'$fontWidth'-wght'$fontWeight
					
					if [ $fontPosture == 'Roman' ]; then
						fonttools varLib.instancer fonts/LGCAlpha/RobotoDelta-Roman-VF.ttf opsz=$fontOpticalSize wght=$fontWeight wdth=$fontWidth -o $FULL_PATH/$FILENAME.ttf --static
					else
						fonttools varLib.instancer fonts/LGCAlpha/RobotoDelta-Italic-VF.ttf opsz=$fontOpticalSize wght=$fontWeight wdth=$fontWidth -o $FULL_PATH/$FILENAME.ttf --static
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

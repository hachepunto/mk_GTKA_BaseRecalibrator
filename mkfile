BASERECALIBRATOR=`{./targets}

baserecalibrator:VE:	$BASERECALIBRATOR

results/baseRecalibrator/%.recal_data.bam:D:	data/%.bam
	mkdir -p `dirname $target`
	java -jar $GTKA \
		-T BaseRecalibrator \
		-R $REFERENCEFASTA \
		-I $prereq \
		-knownSites $DBSNP \
		-o $target".build"
	&& mv $target".build" $target
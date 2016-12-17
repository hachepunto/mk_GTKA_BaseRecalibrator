<GTKA_BaseRecalibrator.mk

BASERECALIBRATOR=`{./targets}

baserecalibrator:VE:	$BASERECALIBRATOR

'results/baseRecalibrator/%.recal_data.table':D:	data/%.bam
	mkdir -p `dirname $target`
	java -jar $GTKA \
		-T BaseRecalibrator \
		-R $REFERENCEFASTA \
		-I $prereq \
		-L 20 \
		-knownSites $DBSNP \
		-knownSites $GOLDINDELS \
		-o $target".build" \
	&& mv $target".build" $target

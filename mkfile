<GTKA_BaseRecalibrator.mk

BASERECALIBRATOR=`{./targets}

baserecalibrator:VE:	$BASERECALIBRATOR

'results/baseRecalibrator/%.recal_data.table':D:	data/%.bam
	mkdir -p `dirname $target`
	java -jar $GTKA \
		-T BaseRecalibrator \
		-R $REFERENCEFASTA \
		-I $prereq \
		-knownSites $DBSNP \
		-knownSites $GOLDINDELS \
		-o $target".build" \
	&& mv $target".build" $target


'results/baseRecalibrator/%.recal_reads.bam':D:		data/%.bam	results/baseRecalibrator/%.recal_data.table
	mkdir -p `dirname $target`
	java -jar $GTKA \
		-T PrintReads \
		-R $REFERENCEFASTA \
		-I data/$stem.bam \
		-BQSR results/baseRecalibrator/$stem.recal_data.table \
		-o $target".build" \
	&& mv $target".build" $target



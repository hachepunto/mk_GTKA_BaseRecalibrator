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

'results/baseRecalibrator/%.post_recal_data.table':D:		data/%.bam	results/baseRecalibrator/%.recal_data.table
	mkdir -p `dirname $target`
	java -jar $GTKA \
		-T BaseRecalibrator \
		-R $REFERENCEFASTA \
		-I $stem.bam \
		-knownSites $DBSNP \
		-knownSites $GOLDINDELS \
		-BQSR $stem.recal_data.table \
		-o $target".build" \
	&& mv $target".build" $target

'results/baseRecalibrator/%.recalibration_plots.pdf':D:		results/baseRecalibrator/%.recal_data.table	results/baseRecalibrator/%.post_recal_data.table
	mkdir -p `dirname $target`
	java -jar $GTKA \
		-T AnalyzeCovariates \
		-R $REFERENCEFASTA \
		-before $stem.recal_data.table \
		-after $stem.post_recal_data.table \
		-plots $target".build" \
	&& mv $target".build" $target

'results/baseRecalibrator/%.recal_reads.bam':D:		data/%.bam	results/baseRecalibrator/%.recal_data.table
	mkdir -p `dirname $target`
	java -jar $GTKA \
		-T PrintReads \
		-R $REFERENCEFASTA \
		-I $stem.bam \
		-BQSR $stem.recal_data.table \
		-o $target".build" \
	&& mv $target".build" $target



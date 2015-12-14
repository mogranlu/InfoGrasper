#!/bin/bash
echo "INFO: Entering script $0"
set -o errexit
set -o nounset

pwd
. infograsper.properties
echo "DEBUG: Document root dir = $doc_root_dir"

outdir="$doc_root_dir/$output_dir"

## If the output dir does not exist, create it:
[ -d "$outdir" ] || mkdir --verbose $outdir

## Convert from *.pptx or *.ppt to pps (automatic slide show)
echo soffice --invisible --convert-to pps --outdir ${outdir} ${doc_root_dir}/*.ppt?

echo "DEBUG: $(ls ${outdir})"

## Loop through 
for nextFile in $(ls ${outdir})
do
   ## Present next file (slideshow) in the output dir:
   echo "Presenting ${nextFile}..."
   soffice --show --nologo --norestore ${outdir}/${nextFile} &

   ## Try to get the process ID (PID) of this presentation (we give libreoffice some seconds to get up and running)
   sleep 3s && presentationPID=$(pidof soffice.bin)
   echo "To kill in 12 seconds: ${presentationPID}..."

   ##If the presentation actually started (PID not zero), then try to kill it after some time.
   [ -z "$presentation_timeout" ] || sleep $presentation_timeout && kill $presentationPID
done


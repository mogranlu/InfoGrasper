#!/bin/bash
echo "INFO: Entering script $0"
set -o errexit
set -o nounset

. infograsper.properties
echo "DEBUG: Document root dir = $doc_root_dir"

## Convert from *.pptx or *.ppt to pps (automatic slide show)
soffice --invisible --convert-to pps --outdir ${output_dir} ${doc_root_dir}/*.ppt?

echo "DEBUG: $(ls ${output_dir})"

## Loop through all files in the presentation directory
for nextFile in $(ls ${output_dir})
do
   ## Present next file (slideshow) in the output dir:
   echo "Presenting ${nextFile}..."
   soffice --show --nologo --norestore ${output_dir}/${nextFile} &

   ## Try to get the process ID (PID) of this presentation (we give libreoffice some seconds to get up and running)
   sleep 3s && presentationPID=$(pidof soffice.bin)
   echo "To kill in 12 seconds: ${presentationPID}..."

   ##If the presentation actually started (PID not zero), then try to kill it after some time.
   [ -z "$presentation_timeout" ] || sleep $presentation_timeout && kill $presentationPID
done


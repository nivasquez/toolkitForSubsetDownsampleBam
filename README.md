# toolkitForSubsetDownsampleBam

This toolkit was made to subset and downsample BAM files. Developers can input BAM files to this workflow and end up with a subsetted and downsampled BAM file that uses a smaller amount of disk space. The purpose of this is to give developers another tool they can use to generate quick, testable data in the BAM format. 

For a toolkit that takes CRAM files, converts them to BAM files, then downsamples/subsets, then converts back to a CRAM file, take a look at my colleagues toolkit for generating test data here: https://github.com/ibrahimjabarkhel/toolkit-for-generating-test-data

Please let me know if you have any questions about this toolkit! I used Windows 10 and Ubuntu from the Microsoft Store to make this toolkit. If you run into any installation problems due to the Windows operating system, don't be afraid to contact me. Windows was quite the headache and I didn't know it could cause so many installation problems that the rest of my team (using MAC OS) didn't run into. - Nicholas

# Authors

Nicholas Vasquez nivasquez@csumb.edu,  
Ibrahim Jabarkhel ibrahimjabarkhil747@gmail.com,  
Ash O'Farrell aofarrel@ucsc.edu  

# How to Run

We used [this course](https://bioinformatics-core-shared-training.github.io/docker-4-bioinformatics/) and [this quickstart guide](https://dockstore.org/quick-start) to learn how to install Docker and Dockstore respectively. We'll explain how to run this both with and without the Dockstore CLI.

Stay organized by keeping all files you download from here in the same folder on your local machine! Make sure you `cd` to this folder in your terminal to run the below code. 

## First Steps
1. Download the dockerfile from this repo and paste this to your terminal: 
`docker build -t="toolkit" .` 
"toolkit" can be replaced with a name of your choice. I prefer to use the name of the repo I learned how to make dockerfiles in, from the website quay.io.

2. Type `docker images` into your terminal to confirm your image has been made

3. Download the WDL file and replace the "docker:" part found in the `runtime{` section. Change it to the same name as the name of your Docker image. OPTIONAL: use `docker push (insert-link-to-pre-made-repository-here)` in your terminal to push the docker image to a code sharing site of your choice (make sure you already made the repository and it is under your name on the website (example: quay.io/nivasquez/toolkit)

4. Download the JSON file. You have two options here:

Download the file named "wgEncodeUwRepliSeqBjS1AlnRep2.bam" from https://hgdownload-test.gi.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeUwRepliSeq/release1/ and keep it in the same folder as all of the other files downloaded from here OR find/use your own .bam file. Make sure to provide the web link to it (gs://, http:// type links for example) and replace the .json file name with the new name/link of your bam file. 

## Running locally with Cromwell
To test locally with Cromwell, make sure you have the latest version of Java. If you installed the Dockstore CLI, you should have the latest version of Java because it is required to use Dockstore. Download "cromwell-51.jar" from [the Broad Institute's cromwell repository](https://github.com/broadinstitute/cromwell/releases/tag/51). Put this new jar file in the same folder as everything else used from this tutorial. Run this command `java -jar cromwell.51-jar run (.wdl-file -name-here) -i (.json-file-name-here)` and if it was a success, you should see an output that says something like "Workflow Succeeded" and you will see the path to where your new BAM file was downloaded right below it. 

## Running locally with the Dockstore CLI
To test using the Dockstore CLI, make sure you have the weblink to the BAM file in your JSON file. You can use BAM file links that begin with gs:// or ftp:// have worked for us. If you get an error with gs:// or ftp:// links, try using the command `dockstore plugin download` to update your Dockstore plugins. Use the command `dockstore tool launch --local-entry (.wdl-file-name-here) --json (.json-file-name-here)` and if it was a success, you should see an output that says something like "Workflow Succeeded" and you will see the path to where your new BAM file was downloaded right below it.

If you run into a "corrupt jar file" error when using the dockstore tool launch command, you may need to use a different OS; this error seems unique to Windows. This toolkit is confirmed to work on Mac OSX and should work on any similar UNIX-like operating system.

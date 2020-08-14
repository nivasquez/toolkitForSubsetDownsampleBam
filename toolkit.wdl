version 1.0

# wdl defines tool as a one task wdl workflow, task has associated docker image (docs.dockstore.org)

task toolkit {
  input {
    File inputBAMFile
    String inputFileName
    Int disk_size
  }

  # command specifies what to run on command line   
  command {
    samtools view -bs 45.1 ${inputBAMFile} > ${inputFileName}.downsample.bam
  }
  
  output {
    File value = "${inputFileName}.downsample.bam"
  }

 # runtime section uses docker image to run task in
 runtime {
    docker: "quay.io/nivasquez/toolkit:latest"
    cpu: 1
    memory: "15 GB"
    disks: "local-disk " + disk_size + " HDD"
    continueOnReturnCode: true
  }
  meta {
        author: "Nicholas Vasquez"
        email: "nivasquez@csumb.edu"
  }
}

workflow toolkit_test {
  input {
    File inputBAMFile
    # Optional increase in disk size
    Int? increase_disk_size
  }
 
  # Increase disk size
  Int additional_disk = select_first([increase_disk_size, 20])

  # Get the size of the standard inputBAM file 
  Int bam_size = ceil(size(inputBAMFile, "GB")) 

  String inputFileName = basename("${inputBAMFile}")

  call toolkit { input: inputBAMFile = inputBAMFile,
                    inputFileName = inputFileName,
                    disk_size = bam_size + additional_disk
  }


}

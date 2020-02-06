def run_cocotb_tests() {
    docker.withRegistry('https://docker-local.artifactory.imsar.us') {
        vlibs = '/fpga_tools/mentor/libraries/2017.2/modelsim_dlx_10.7/'
        docker.image('cocotb').inside("--mount type=bind,ro,src=${vlibs},dst=${vlibs}") {
            for (f in findFiles(glob: 'firmware/grizzly/**/cocotb/Makefile')) {
                def name = f.path.split('/')[-3]
                def cover_name = "cocotb_${name}_cv_rpt.xml"
                try {
                    stage("cocotb ${name}") {
                        ansiColor('xterm') {
                            sh("cd `dirname ${f}`; pwd; linux32 make")
                            sh(get_cocotb_sh_script(f, cover_name))
                        }
                    }
                } catch (e) {
                    currentBuild.result = 'FAIL'
                    result = 'FAIL'
                }
            }
        }
    }
    archiveArtifacts '**/sim_build/results.xml, **/*_cv_rpt.*, **/*.ucdb'
}

node('master')
{
  stage('Checkout')
  {
    cleanWs()
    checkout scm
  }
  stage('Build x86')
  {
    dir('urjtag') {
      sh('./autogen.sh --enable-stapl --enable-ftdi && make V=1')
    }
  }
  stage('Build armhf')
  {
    dir('urjtag') {
      sh('./autogen.sh --enable-stapl --disable-ftdi && make V=1')
    }
  }
  stage('Archive')
  {
    //archiveArtifacts artifacts: 'build/**', fingerprint: true
  }
}

pipeline {
  agent none

  stages {

    stage('Build') {
      steps {
        script {
          def builds = [:]

          def docker_base = "px4io/px4-dev-base:2017-10-23"
          def docker_nuttx = "px4io/px4-dev-nuttx:2017-10-23"
          def docker_rpi = "px4io/px4-dev-raspi:2017-10-23"
          def docker_armhf = "px4io/px4-dev-armhf:2017-10-23"
          def docker_arch = "px4io/px4-dev-base-archlinux:2017-12-08"


          builds["px4fmu-v2_default"] = getNode(docker_nuttx, "nuttx_px4fmu-v2_default")
          builds["px4fmu-v2_lpe"] = getNode(docker_nuttx, "nuttx_px4fmu-v2_lpe")

          // nuttx default targets that are archived and uploaded to s3
          for (def option in ["px4fmu-v3", "px4fmu-v4", "px4fmu-v4pro", "px4fmu-v5", "aerofc-v1"]) {
            def node_name_default = "${option}_default"
            def node_name_rtps = "${option}_rtps"
            builds[node_name_default] = getNode(docker_nuttx, "nuttx_${node_name_default}")
            builds[node_name_rtps] = getNode(docker_nuttx, "nuttx_${node_name_rtps}")
          }

          builds["px4fmu-v5_default (GCC 7)"] = getNode(docker_nuttx, "nuttx_px4fmu-v5_default")

          // nuttx default targets that are archived and uploaded to s3
          for (def option in ["aerocore2", "auav-x21", "crazyflie", "mindpx-v2", "nxphlite-v3", "tap-v1"]) {
            def node_name = "${option}"
            builds[node_name] = getNode(docker_nuttx, "nuttx_${node_name}_default")
          }

          // other nuttx default targets
          for (def option in ["px4-same70xplained-v1", "px4-stm32f4discovery", "px4cannode-v1", "px4esc-v1", "px4nucleoF767ZI-v1", "s2740vc-v1"]) {
            def node_name = "${option}"
            builds[node_name] = getNode(docker_nuttx, "nuttx_${node_name}_default")
          }

          builds["sitl_default"] = getNode(docker_base, "posix_sitl_default")
          builds["sitl_default (GCC 7)"] = getNode(docker_arch, "posix_sitl_default")
          builds["sitl_rtps"] = getNode(docker_base, "posix_sitl_rtps")

          builds["rpi"] = getNode(docker_rpi, "posix_rpi_cross")
          builds["bebop"] = getNode(docker_rpi, "posix_bebop_default")

          builds["ocpoc"] = getNode(docker_armhf, "posix_ocpoc_ubuntu")

          //builds["snapdragon"] = getNode(docker_snapdragon, "eagle_default")

          parallel builds
        } // script
      }
    } // stage Builds

    stage('Test') {
      parallel {

        stage('check style') {
          agent {
            docker {
              image 'px4io/px4-dev-base:2017-10-23'
              args '-e CI=true'
            }
          }
          steps {
            sh 'make check_format'
          }
        }

        stage('clang analyzer') {
          agent {
            docker {
              image 'px4io/px4-dev-clang:2017-10-23'
              args '-e CI=true -e CCACHE_BASEDIR=$WORKSPACE -e CCACHE_DIR=/tmp/ccache -v /tmp/ccache:/tmp/ccache:rw'
            }
          }
          steps {
            sh 'make clean'
            sh 'make scan-build'
            // publish html
            publishHTML target: [
              reportTitles: 'clang static analyzer',
              allowMissing: false,
              alwaysLinkToLastBuild: true,
              keepAll: true,
              reportDir: 'build/scan-build/report_latest',
              reportFiles: '*',
              reportName: 'Clang Static Analyzer'
            ]
          }
        }

        stage('clang tidy') {
          agent {
            docker {
              image 'px4io/px4-dev-clang:2017-10-23'
              args '-e CI=true -e CCACHE_BASEDIR=$WORKSPACE -e CCACHE_DIR=/tmp/ccache -v /tmp/ccache:/tmp/ccache:rw'
            }
          }
          steps {
            sh 'make clean'
            sh 'make clang-tidy-quiet'
          }
        }

        stage('cppcheck') {
          agent {
            docker {
              image 'px4io/px4-dev-base:ubuntu17.10'
              args '-e CI=true -e CCACHE_BASEDIR=$WORKSPACE -e CCACHE_DIR=/tmp/ccache -v /tmp/ccache:/tmp/ccache:rw'
            }
          }
          steps {
            sh 'make clean'
            sh 'make cppcheck'
            // publish html
            publishHTML target: [
              reportTitles: 'Cppcheck',
              allowMissing: false,
              alwaysLinkToLastBuild: true,
              keepAll: true,
              reportDir: 'build/cppcheck/',
              reportFiles: '*',
              reportName: 'Cppcheck'
            ]
          }
        }

        stage('tests') {
          agent {
            docker {
              image 'px4io/px4-dev-base:2017-10-23'
              args '-e CI=true -e CCACHE_BASEDIR=$WORKSPACE -e CCACHE_DIR=/tmp/ccache -v /tmp/ccache:/tmp/ccache:rw'
            }
          }
          steps {
            sh 'make clean'
            sh 'make posix_sitl_default test_results_junit'
            junit 'build/posix_sitl_default/JUnitTestResults.xml'
          }
        }

        // temporarily disabled until stable
        //stage('tests coverage') {
        //  agent {
        //    docker {
        //      image 'px4io/px4-dev-base:2017-10-23'
        //      args '-e CI=true -e CCACHE_BASEDIR=$WORKSPACE -e CCACHE_DIR=/tmp/ccache -v /tmp/ccache:/tmp/ccache:rw'
        //    }
        //  }
        //  steps {
        //    sh 'make clean'
        //    sh 'make tests_coverage'
        //    // publish html
        //    publishHTML target: [
        //      allowMissing: false,
        //      alwaysLinkToLastBuild: false,
        //      keepAll: true,
        //      reportDir: 'build/posix_sitl_default/coverage-html',
        //      reportFiles: '*',
        //      reportName: 'Coverage Report'
        //    ]
        //  }
        //}

      } // parallel
    } // stage Test

    stage('Generate Metadata') {

      parallel {

        stage('airframe') {
          agent {
            docker { image 'px4io/px4-dev-base:2017-10-23' }
          }
          steps {
            sh 'make airframe_metadata'
            archiveArtifacts(artifacts: 'airframes.md, airframes.xml', fingerprint: true)
          }
        }

        stage('parameter') {
          agent {
            docker { image 'px4io/px4-dev-base:2017-10-23' }
          }
          steps {
            sh 'make parameters_metadata'
            archiveArtifacts(artifacts: 'parameters.md, parameters.xml', fingerprint: true)
          }
        }

        stage('module') {
          agent {
            docker { image 'px4io/px4-dev-base:2017-10-23' }
          }
          steps {
            sh 'make module_documentation'
            archiveArtifacts(artifacts: 'modules/*.md', fingerprint: true)
          }
        }
      }
    }

    stage('S3 Upload') {
      agent {
        docker { image 'px4io/px4-dev-base:2017-10-23' }
      }

      when {
        anyOf {
          branch 'master'
          branch 'beta'
          branch 'stable'
        }
      }

      steps {
        sh 'echo "uploading to S3"'
      }
    }
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    timeout(time: 60, unit: 'MINUTES')
  }
}

def getNode(String docker_repo, String target) {
  return {
    node {
      docker.image(docker_repo).inside('-e CI=true -e CCACHE_BASEDIR=$WORKSPACE -e CCACHE_DIR=/tmp/ccache -v /tmp/ccache:/tmp/ccache:rw') {
        stage(target) {
          checkout scm
          sh('make clean')
          sh('ccache -z')
          sh('git fetch --tags')
          sh('make ' + target)
          sh('make sizes')
          sh('ccache -s')
          archiveArtifacts(artifacts: 'build/*/*.px4', fingerprint: true)
        }
      }
    }
  }
}
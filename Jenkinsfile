pipeline {
  agent none

  stages {

    stage('Build') {
      steps {
        script {
          def builds = [:]

          def docker_base = "px4io/px4-dev-base:2017-10-23"
          def docker_nuttx = "px4io/px4-dev-nuttx:2017-10-23"

          builds["px4fmu-v2_default"] = getNodeForInstance(docker_nuttx, "nuttx_px4fmu-v2_default")
          builds["px4fmu-v2_rtps"] = getNodeForInstance(docker_nuttx, "nuttx_px4fmu-v2_rtps")
          builds["px4fmu-v2_lpe"] = getNodeForInstance(docker_nuttx, "nuttx_px4fmu-v2_lpe")
          builds["px4fmu-v3_default"] = getNodeForInstance(docker_nuttx, "nuttx_px4fmu-v3_default")
          builds["px4fmu-v3_rtps"] = getNodeForInstance(docker_nuttx, "nuttx_px4fmu-v3_rtps")

          builds["sitl_default"] = getNodeForInstance(docker_base, "posix_sitl_default")

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

def getNodeForInstance(String docker_repo, String target) {
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
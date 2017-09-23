#!/bin/bash
mkdir -p fmu_tmp && cd fmu_tmp && omc ../compile_fmu.mos && mv Controller.fmu .. && rm -rf fmu_tmp

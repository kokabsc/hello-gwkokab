#!/bin/bash

source ../env.sh 

CPU_MASK="31-59"

GWKOKAB_LOG_FILE="flowMC_example.log" taskset -c "${CPU_MASK}" time f_sage_n_pls_m_gs \
	--seed $RANDOM \
	--n-pl 1 \
	--n-g 0 \
	--posterior-regex "../generating_mock_posterior_estimates/data/realization_0/posteriors/event_*.dat" \
	--prior-json prior.json \
	--sampler-config flowMC_config.json \
	--n-buckets 5 \
	--add-truncated-normal-eccentricity

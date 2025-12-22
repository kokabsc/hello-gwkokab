#!/bin/bash

source ../env.sh
CPU_MASK="1-30"

GWKOKAB_LOG_FILE="Numpyro_example.log" taskset -c "${CPU_MASK}" n_sage_n_pls_m_gs \
	--seed $RANDOM \
	--n-pl 1 \
	--n-g 0 \
	--posterior-regex "../generating_mock_posterior_estimates/data/realization_0/posteriors/event_*.dat" \
	--pmean-json pmean.json \
	--prior-json prior.json \
	--sampler-config numpyro_config.json \
	--n-buckets 5 \
	--add-truncated-normal-eccentricity

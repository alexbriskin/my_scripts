#!/bin/bash -eu

grep -rn -e tx_block -e TX_BLOCK -e \
tx_byte -e TX_BYTE -e \
TX_SUCCESS -e TX_FEATURE_NOT_ENABLED -e TX_*_ERROR -e \
tx_event_flags -e TX_EVENT_FLAGS -e \
tx_interrupt -e TX_INTERRUPT -e \
tx_mutex -e TX_MUTEX -e \
TX_WAIT -e TX_NO_WAIT -e TX_DELETED -e TX_NOT_AVAILABLE -e TX_NOT_OWNED -e \
tx_queue -e TX_QUEUE -e \
tx_semaphore -e TX_SEMAPHORE -e \
TX_CEILING_EXCEEDED -e TX_INVALID_CEILING -e \
tx_thread -e TX_THREAD .

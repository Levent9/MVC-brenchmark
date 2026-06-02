#!/bin/bash
# Minimal launcher for the UniSpeaker MVC benchmark evaluator.
# Edit the four paths and the task name below, then run: bash eval.sh

TASK=face_tts                                  # face_tts | face_vc | text_tts | text_vc | ave
MANIFEST=./face/facetts.lst                    # matching .lst file
DATA_ROOT=/path/to/mvc_data_root               # prefix for relative paths in MANIFEST
GEN_DIR=/path/to/your_generated_wavs           # contains <wav_id>.wav for each row
OUTDIR=./eval_out/face_tts                     # where results go
SPK_ONNX=/path/to/campplus.onnx                # CAM++ ONNX (3D-Speaker)

python eval_unispeaker.py \
    --task      "$TASK" \
    --manifest  "$MANIFEST" \
    --data_root "$DATA_ROOT" \
    --gen_dir   "$GEN_DIR" \
    --outdir    "$OUTDIR" \
    --spk_onnx  "$SPK_ONNX" \
    --tasks sst ssc ssd wer \
    --lang en

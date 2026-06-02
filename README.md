# MVC Benchmark — Evaluation Toolkit

This directory contains the **Multimodal Voice Control (MVC)** benchmark and
the objective-evaluation toolkit used in:

> **UniSpeaker: A Unified Approach for Multimodality-driven Speaker Generation.**
> Sheng *et al.*, *Findings of EMNLP 2025.*

The benchmark covers **five tasks** that drive speaker generation from
different voice-description modalities:

| Task        | Voice description |
|-------------|-------------------|
| `face_tts`  | face image        | 
| `face_vc`   | face image        | 
| `text_tts`  | text description  | 
| `text_vc`   | text description  | 
| `ave`       | attribute prompt  | 

Three objective dimensions are reported:

* **Voice suitability** — SST, SSC
* **Voice diversity**   — SSD
* **Speech quality**    — WER




---

## Inference inputs (`.lst` schema)

Each task ships a pipe-delimited prompt list. **Column 1 is always the
utterance id**; columns 2 – 4 differ per task and are interpreted as below.

| Task        | `.lst` columns                                                              |
|-------------|-----------------------------------------------------------------------------|
| `face_tts`  | `wav_id` \| `tgt_wav` \| `face_image` \| `text`                             |
| `face_vc`   | `wav_id` \| `tgt_wav` \| `face_image` \| `source_wav`                       |
| `text_tts`  | `wav_id` \| `tgt_wav` \| `text_prompt` \| `text`                       |
| `text_vc`   | `wav_id` \| `tgt_wav` \| `text_prompt` \| `source_wav`                 |
| `ave`       | `wav_id` \| `tgt_wav` \| `attribute_prompt` \| `source_wav`                 |

---

| File                          | Status                                          |
|-------------------------------|-------------------------------------------------|
| `face/facetts.lst`            | ✅  |
| `face/facevc.lst`             | ✅                       |
| `text/texttts.lst`            | demo samples only                               |
| `text/textvc.lst`             | demo samples only                               |
| `voice_attribute/ave.lst`     | ✅ |



## Prerequisites

```bash
pip install numpy soundfile torch torchaudio onnxruntime tqdm jiwer
# English WER (whisper-large-v3 is auto-pulled from HuggingFace)
pip install transformers scipy
# Chinese WER (paraformer-zh is auto-pulled by FunASR)
pip install funasr zhconv zhon
```

Download the **CAM++** speaker-verification model and export it to ONNX:

* ModelScope: <https://modelscope.cn/models/iic/speech_campplus_sv_zh-cn_16k-common>
* Source repo: <https://github.com/modelscope/3D-Speaker>

Save it locally and pass the path via `--spk_onnx`.

---

## Running the evaluator

### Quick start — directly on a bundled `.lst`

```bash
python scripts/eval/unispeaker/eval_unispeaker.py \
    --manifest scripts/eval/unispeaker/face/facetts.lst \
    --task     face_tts \
    --data_root /path/to/mvc_data_root \
    --gen_dir  /path/to/your_facetts_outputs \
    --outdir   ./eval_out/face_tts \
    --spk_onnx /path/to/campplus.onnx \
    --tasks    sst ssc ssd wer \
    --lang     en
```

Switch `--task` (and the matching `.lst`) to evaluate the other four tasks:

```bash
# face_vc
--manifest .../face/facevc.lst   --task face_vc
# text_tts
--manifest .../text/texttts.lst  --task text_tts
# text_vc
--manifest .../text/textvc.lst   --task text_vc
# ave
--manifest .../voice_attribute/ave.lst --task ave
```

Or edit the path variables at the top of `eval.sh` and run `bash eval.sh`.

### Custom manifest (`.jsonl`)


```json
{"utt":"id001","spk":"S023","target_wav":"/abs/target.wav","source_wav":"/abs/src.wav","text":"hello","task":"face_vc"}
```




## Citation

```bibtex
@inproceedings{sheng2025unispeaker,
  title     = {UniSpeaker: A Unified Approach for Multimodality-driven Speaker Generation},
  author    = {Sheng, Zhengyan and Du, Zhihao and Lu, Heng and Zhang, Shiliang and Ling, Zhen-Hua},
  booktitle = {Findings of the Association for Computational Linguistics: EMNLP 2025},
  year      = {2025}
}
```

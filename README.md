# Signal Processing Project – Frequency Analysis and Musical Note Detection

## Overview

This project focuses on signal processing techniques for analyzing, identifying, and matching audio frequencies to musical notes. Implemented primarily in MATLAB, it processes WAV files to extract tone information and compare them against a reference frequency table.

The project contains tools for:

- Frequency extraction
- Note classification
- Audio comparison
- Evaluation of recognition accuracy

---

## Project Structure

```
signal-810101514/
├── CalculateFrequencies.m          # Main script to compute dominant frequencies
├── emtiazi.m                       # Evaluation or grading script
├── notes.m                         # Reference musical notes and their properties
├── p1.m                            # Possibly the first-phase analysis script
├── noteHarryPoter.wav              # Target melody to analyze
├── noteOptimized.wav               # Cleaned or optimized version of the melody
├── newOutputFromListening.wav      # User-generated or captured audio
├── Table of Frequencies.xlsx       # Reference table of musical note frequencies
├── octave5/                        # Folder containing pure note samples
│   ├── A.wav, B.wav, C.wav, ..., G#.wav
├── report.docx / report.pdf        # Project report and documentation
```

---

## How It Works

1. **Frequency Analysis**:`CalculateFrequencies.m` performs FFT-based analysis on input audio to extract dominant frequency components.
2. **Note Matching**:Frequencies are compared against standard note frequencies defined in `notes.m` or the Excel table.
3. **Audio Matching**:The script attempts to match the content of `newOutputFromListening.wav` to known notes or melodies.
4. **Evaluation**:
   `emtiazi.m` possibly checks correctness against the expected output or grading criteria.

---

## Requirements

- MATLAB (recommended version: R2020 or later)
- Signal Processing Toolbox

---

## How to Run

1. Open MATLAB.
2. Set the working directory to the project folder.
3. Run the main script:

```matlab
>> CalculateFrequencies
```

4. To evaluate performance (if implemented):

```matlab
>> emtiazi
```

---

## Notes

- Audio files in `octave5/` serve as reference tones from octave 5.
- The frequency table provides the ideal Hz values for each musical note.
- WAV files may include noise, and scripts may apply preprocessing to improve accuracy.

---

## Report

For detailed explanations, experimental results, and methodology, refer to:

- `report.pdf` or `report.docx`

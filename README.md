# Music Transcription Tool
An universal MATLAB tool to transcribe monophonic acoustic signals. In this project, I implemented a template matching algorithms to solve the fundamental frequency (F0) estimation task and a phase-based method for the onset detection task.
## Upon testing:
- At the frame-level, the accuracy score was 88% for piano (accounted for octave errors) and 89% for violin signal. 
- At the note-level, accuracy score was 89% for piano signal, and 38% for violin signal.

## Some visual results:
### Frame-level:
NOTE: 
- Each dot is an F0 estimation of a frame, a line of dots is a note
- Red dot is the ground truth, blue dot is the transcription
      
<img alt="Transcription of Musical Offering on violin" src="https://user-images.githubusercontent.com/64146871/216738125-b7504bba-3721-478f-858c-5aed1fde5747.png" height="450" width="auto" title="Musical Offering on violin (Frame-level Transcription)">

<img alt="Transcription of Jupiter on violin" src="https://user-images.githubusercontent.com/64146871/216738068-7cb64049-dab6-475f-9887-7bce1b751162.png" height="450" width="auto" title="An excerpt of Jupiter on violin (Frame-level Transcription)">

### Note-level:
NOTE: 
- Each dot marks the beginning of a single note

<img alt="Transcription of Alphabet Song on piano" src="https://user-images.githubusercontent.com/64146871/216738014-ff3dddd1-638f-48de-a83d-cf06fdac6ca0.jpg" height="400" width="auto" title="The Alphabet Song on piano (Note-level Transcription)">

## Current issues:
- Onset detection is not optimal enough for string instruments or wind instruments, whose onset/change of pitch tend to be very soft.

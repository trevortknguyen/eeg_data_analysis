**Description**

We collected EEG signal data from 10 college students while they watched MOOC video clips. We extracted online education videos that are assumed not to be confusing for college students, such as videos of the introduction of basic algebra or geometry. We also prepare videos that are expected to confuse a typical college student if a student is not familiar with the video topics like Quantum Mechanics, and Stem Cell Research. We prepared 20 videos, 10 in each category. Each video was about 2 minutes long. We chopped the two-minute clip in the middle of a topic to make the videos more confusing. 
The students wore a single-channel wireless MindSet that measured activity over the frontal lobe. The MindSet measures the voltage between an electrode resting on the forehead and two electrodes (one ground and one reference) each in contact with an ear.
After each session, the student rated his/her confusion level on a scale of 1-7, where one corresponded to the least confusing and seven corresponded to the most confusing. These labels if further normalized into labels of whether the students are confused or not. This label is offered as self-labelled confusion in addition to our predefined label of confusion. 

**Data information:**

*-----data.csv*

 1. Column 1: Subject ID 
 2. Column 2: Video ID
 3. Column 3: Attention (Proprietary measure of mental focus)
 4. Column 4: Mediation (Proprietary measure of calmness)
 5. Column 5: Raw (Raw EEG signal)
 6. Column 6: Delta (1-3 Hz of power spectrum)
 7. Column 7: Theta (4-7 Hz of power spectrum)
 8. Column 8: Alpha 1 (Lower 8-11 Hz of power spectrum)
 9. Column 9: Alpha 2 (Higher 8-11 Hz of power spectrum)
 10. Column 10: Beta 1 (Lower 12-29 Hz of power spectrum)
 11. Column 11: Beta 2 (Higher 12-29 Hz of power spectrum)
 12. Column 12: Gamma 1 (Lower 30-100 Hz of power spectrum)
 13. Column 13: Gamma 2 (Higher 30-100 Hz of power spectrum)
 14. Column 14: predefined label (whether the subject is expected to be confused)
 15. Column 15: user-defined label (whether the subject is actually confused)

*-----subject demographic*

 1. Column 1: Subject ID
 2. Column 2: Age
 3. Column 3: Ethnicity (Categorized according to https://en.wikipedia.org/wiki/List_of_contemporary_ethnic_groups)
 4. Column 4: Gender

*-----video data*

Each video lasts roughly two-minute long, we remove the first 30 seconds and last 30 seconds, only collect the EEG data during the middle 1 minute. 

**Format**

These data are collected from ten students, each watching ten videos. 

Therefore, it can be seen as only 100 data points for these 12000+ rows. If you look at this way, then each data point consists of 120+ rows, which is sampled every 0.5 seconds (so each data point is a one minute video). Signals with higher frequency are reported as the mean value during each 0.5 second. 

**Reference:**

 - Wang, H., Li, Y., Hu, X., Yang, Y., Meng, Z., & Chang, K. M. (2013, June). Using EEG to Improve Massive Open Online Courses Feedback Interaction. In AIED Workshops. [[PDF][1]]

**Data Collection**

The data is collected from a software that we implemented ourselves. Check [HaohanWang/Bioimaging][2] for the source code. 


**Inspiration**

 - This dataset is an extremely challenging data set to perform **binary
   classification**. 65% of prediction accuracy is quite decent according to our experience. 
   
 - It is an interesting data set to carry out the **variable selection**  (**causal inference**)
   task that may help further research. Past research has indicated that
   *Theta* signal is correlated with confusion level. 
   
 - It is also an interesting data set for **confounding factors correction**
   model because we offer two labels (*subject id* and *video id*) that
   could profoundly confound the results.

**Warning**

The data for subject 3 might be corrupted. 

**Other Resources**

[Promotion Video][3]

[Source Code of Data Collection Software][4]

**Contact**

[Haohan Wang][5] 


  [1]: http://www.cs.cmu.edu/~kkchang/paper/WangEtAl.2013.AIED.EEG-MOOC.pdf
  [2]: https://github.com/HaohanWang/BioImaging
  [3]: https://www.youtube.com/watch?v=ACjLuMvbAnM
  [4]: https://github.com/HaohanWang/BioImaging
  [5]: http://www.cs.cmu.edu/~haohanw/
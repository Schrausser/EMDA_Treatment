---
title: 'EMDA: Treatment procedure for lateral Eye Movement Desensitization'
tags:
  - Eye Movement desensitization
  - EMDR
  - PTSD
  - Post-traumatic stress disorder
  - Clinical Psychology
  - Psychotherapy
  - Psychiatry
  - Neuropsychology
  - Ophthalmology
  - Ocular Physiological Processes
  - Cognitive Psychology
authors:
  - name: Dietmar G. Schrausser
    orcid: 0000-0002-4924-8280
    equal-contrib: true
    affiliation: "1,2"
    corresponding: true
  - name: Judith Draxler
    equal-contrib: true
    affiliation: 3
  - name: Jürgen Plechinger
    equal-contrib: true
    affiliation: 3
affiliations:
  - name: Independent Researcher, Austria
  - index: 1
  - name: Karl-Franzens University, Institute of Psychology, Austria
  - index: 2
  - name: Dietmar G. Schrausser, Independent Researcher, Austria
  - index: 3
date: 2023
bibliography: paper.bib
---

# Summary
To investigate the (putative) affect-reducing effect of the clinical method lateral eye movement (EMDR) an experimental treatment was performed by means of `EMDA`. Assuming that arousal reduction and mood elevation compared to other types of distractions are significant, an emotionally colored arousal was generated, followed by lateral eye movement and two variants of distraction. Results from `EMDA` *treatment* suggest an effect in arousal reduction compared to *distraction* conditions.

# Statement of need
The method of *Eye Movement Desensitization and Reprocessing* (EMDR) was developed by Francine Shapiro in 1989 to treat Post-Traumatic Stress Disorder (PTSD), see @GDP:2019 or @Merians:2023. According to DSM [@APA:2013] PTSD is defined by (a) constant reliving of a traumatic experience, (b) avoidance of thoughts about that situation and (c) an associated *increased level of arousal*.

@Shapiro:1989 describes the process of treating PTSD with EMDR as follows: At the beginning, the client should visualize the traumatic event as vividly and in as much detail as possible. Then the therapist moves his finger rhythmically from right to left at a distance of $d=30$ cm from the client's head and with a deflection of again $d=30$ cm, with a pendulum movement per second. During the imagining of the traumatic event, the patient generally follows the therapist's finger with his eyes until the imaginings become *bearable*. The length of such a set is given as $n=15$ to $n=25$ lateral eye movements. A stable effect was reported in a follow-up after three months.

As possible neurophysiological explanation, Shapiro refers to the fact that experiencing a traumatic event disturbs the balance between excitation and inhibition in the brain [@Pavlov:1927], lateral eye movements should be able to *restore this balance*. However, a full explanation of the underlying physiological mechanisms is yet to come, for further approaches see e.g. @Stickgold:2002, @Söndergaard:2008, @Pierce:2021 or @Fernandez:2023.

The advantage of the method is clearly due to the fact that treatments are rather short and so clients are not exposed to intense fear for a longer period of time [@Shapiro:1996]. @Vaughan:1994 first examined the effect of EMDR on the major symptom groups of PTSD and found that all three categories of PTSD as well as depression were significantly improved. 

Meanwhile, the value of Shapiro's method has received broad confirmation and acceptance. In a meta-analysis [@Yunitri:2023], EMDR proved itself to be most effective in the treatment of PTSD compared to several other forms of therapy, see e.g. @Shapiro:2002, @Greenwald:2010, @Oren:2012, @Brown:2016 or @Laliotis:2022. For an overview and outlook regarding the method, see @Luber:2009 or @Valiente-Gómez:2017.

The aim of the research by means of `EMDA` procedure [@EMDA] was to *produce* an emotionally colored arousal to *treat* it with EMDR. Arousal was accomplished by placing subjects in a situation that elicited evaluation anxiety, as the latter was found to be significantly positively correlated with arousal levels [@Guerin:1983]. It was investigated whether lateral eye movement induced by `EMDA` rendering reduces this *kind of arousal* more than (a) fixing an inert target or (b) a different kind of distraction [@Schrausser:2022].

# `EMDA` Treatment
A horizontal *moving* bar was rendered on a monitor to generate eye movements imperceptible to the subjects \autoref{fig. 1}. Additionally a tripod-mounted video camera was placed to the left of the subjects to *maintain* an anxiety-provoking situation. 

![figure.\label{Figure 1: `EMDA` Treatment 1, lateral eye movement.}](figure1.jpg)

The moving bar changed color from green to blue with a probability of $p_1=0.125$ per pass. Each blue bar was to be reported as *blue*. One run from left to right and back lasted for $t_1=3$ seconds each of $n_1=60$ runs, resulting in a $t_1=3$ minute treatment duration and $n=60×0.125=7.5$ expected events $e_1$. 
Calculation of pseudo random variable *g* for the color representation of the bar:
~~~
FOR s% = 1 TO dur
    aa = 1: bb = 640: fa1 = 10: x1 = 0: x2 = 30: st = 1
    RANDOMIZE zf
    zfa = RND(2)
    IF s% > 1 AND zfa >= .87 THEN g = -1 ELSE g = 0 
    GOSUB emd:
NEXT
~~~
Main loop for treatment 1 rendering. *STEP* implies velocity of moving bar depending on the hardware:
~~~
emd:
    FOR r% = 1 TO 2
        FOR i% = aa TO bb STEP 7 * st    
            LINE (i% - x1, 150)-(i% + x2, 40), fa1 - g, BF
            LINE (i% - x2, 150)-(i% + x1, 40), 0, BF
        NEXT
        SWAP aa, bb: SWAP x1, x2: st = -1
    NEXT
RETURN
~~~
In order to fix the central object, four *non-moving* rectangles were rendered on the screen \autoref{fig. 2}. These rectangles appeared either blue or green every $t_2=3$ seconds ($p=0.5$). Once all four rectangles displayed the same color ($p_2=2×0.5^4=0.125$), subjects had to react (*blue* or *green*). Duration of the procedure again was $t_2=3$ minutes with $n=7.5$ expected events $e_2$. 

![figure.\label{Figure 2: `EMDA` Treatment 2, fix target.}](figure2.jpg)

Function to calculate pseudo-random variable *g* to display rectangles:
~~~
RESTORE
  FOR i = 1 TO 4
      RANDOMIZE zf
      zfa = RND(2)
      IF zfa < .5 THEN g = 1 ELSE g = 0
      GOSUB abla
  NEXT
~~~
Main function via efficient *DATA READ* definition of coordinate points for treatment 2 rendering:
~~~
abla:
      READ x, y, x1, y1
      DATA 0,-45,0,-40,0,40,0,45,-80,0,-80,0,80,0,80,0
      LINE (300 + x, 120 + y)-(340 + x1, 80 + y1), 10 - g, BF
RETURN
~~~
# Software
`EMDA` is implemented in QBasic for Microsoft DOS 6.0 to perform treatment procedures and timing. Further programs `EMDapk` [@EMDapk] for handheld Android operation systems versions 4.0 or later and `EMDscr` [@EMDscr] as screensaver or executable for Windows platforms are created. Both applications performing treatment part 1 described above, that is the moving bar to induce the EMDR, this with selectabe speed usable in the field. For related works see e.g. @Alulema:2014, @Goga:2020 or Shakeel:2022. Early commercial approaches give e.g. @SAVYNTECH:2019.

# Conclusion
Considering the proven and broadly confirmed positive effects of EMDR, `EMDA` represents a useful basis for further development and adaptation, both in the experimental field and in the area of application. This applies for the latter in particular to the extractions `EMDapk` and `EMDscr`, which are not only useful for a quick and comfortable treatment or therapeutic application but may be even more appropriate for further development and integration of the source-code. The simple structure of the syntax as well as the generally easy to understand programming language should be of not inconsiderable advantage for uncomplicated and broad elaboration.

# Acknowledgement
We acknowledge contributions from the psychology students at the Karl-Franzens University, who acted as subjects as part of their education during the genesis of this project.

# References

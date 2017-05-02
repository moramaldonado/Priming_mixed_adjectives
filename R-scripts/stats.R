mydata <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE)

## (1) 3-way/Higher order interaction
model.full <- glmer(Blur.Selection~Condition.Prime.Re*Condition.Target*HOI + 
                      (1+Condition.Prime.Re*Condition.Target*HOI|subject)+(1|exemplar), 
                    data = mydata, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)
model.noint <- glmer(Blur.Selection~(Condition.Prime.Re+Condition.Target+HOI)^2+
                       (1+Condition.Prime.Re*Condition.Target*HOI|subject)+(1|exemplar), 
                    data = mydata, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)

anova(model.full,model.noint)

## (2) Two-way interaction 

model.2way <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                      (1|subject), 
                    data = mydata, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)
model.2way.noint <- glmer(Blur.Selection~Condition.Prime+Condition.Target+
                       (1|subject), 
                     data = mydata, 
                     control=glmerControl(optCtrl=list(maxfun=100000)),
                     family=binomial)

anova(model.full.2way,model.2way.noint)

## (3) Interaction C vs. D
mydata.primes <- subset(mydata, Condition.Prime =='D' | Condition.Prime =='C')
model.full.primes <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                             (1|subject), 
                           data = mydata.primes, 
                           control=glmerControl(optCtrl=list(maxfun=100000)),
                           family=binomial)
model.noint.primes <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                              (1|subject), 
                            data = mydata.primes, 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)

anova(model.full.primes,model.noint.primes)


## (4) Interaction between baselines
mydata.baseline <- subset(mydata, Condition.Prime !='D' & Condition.Prime !='C')
model.full.baseline <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                      (1|subject), 
                    data = mydata.baseline, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)
model.noint.baseline <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                       (1|subject), 
                     data = mydata.baseline, 
                     control=glmerControl(optCtrl=list(maxfun=100000)),
                     family=binomial)

anova(model.full.baseline,model.noint.baseline)



#Interaction D vs. Baseline-only
mydata.DvsOnly <- subset(mydata, Condition.Prime =='D' | Condition.Prime =='Baseline-only')
model.full.DvsOnly  <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                             (1|subject), 
                           data = mydata.DvsOnly, 
                           control=glmerControl(optCtrl=list(maxfun=100000)),
                           family=binomial)
model.noint.DvsOnly  <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                              (1|subject), 
                            data = mydata.DvsOnly, 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)

anova(model.full.DvsOnly ,model.noint.DvsOnly)

#Interaction D vs. Baseline-the
mydata.DvsDef <- subset(mydata, Condition.Prime =='D' | Condition.Prime =='Baseline-the')
model.full.DvsDef  <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                               (1|subject), 
                             data = mydata.DvsDef, 
                             control=glmerControl(optCtrl=list(maxfun=100000)),
                             family=binomial)
model.noint.DvsDef <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                                (1|subject), 
                              data = mydata.DvsDef, 
                              control=glmerControl(optCtrl=list(maxfun=100000)),
                              family=binomial)

anova(model.full.DvsDef ,model.noint.DvsDef)



#Interaction C vs. Baseline-the

mydata.CvsDef <- subset(mydata, Condition.Prime =='C' | Condition.Prime =='Baseline-the')
model.full.CvsDef  <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                               (1|subject), 
                             data = mydata.CvsDef, 
                             control=glmerControl(optCtrl=list(maxfun=100000)),
                             family=binomial)
model.noint.CvsDef  <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                                (1|subject), 
                              data = mydata.CvsDef, 
                              control=glmerControl(optCtrl=list(maxfun=100000)),
                              family=binomial)

anova(model.full.CvsDef ,model.noint.CvsDef)



#Interaction C vs. Baseline-only

mydata.CvsOnly <- subset(mydata, Condition.Prime =='C' | Condition.Prime =='Baseline-only')
model.full.CvsOnly  <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                              (1|subject), 
                            data = mydata.CvsOnly, 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)
model.noint.CvsOnly <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                               (1|subject), 
                             data = mydata.CvsOnly, 
                             control=glmerControl(optCtrl=list(maxfun=100000)),
                             family=binomial)

anova(model.full.CvsOnly ,model.noint.CvsOnly)
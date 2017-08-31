
##STATS 

## EXPERIMENT 1

# Interaction Condition Prime * Condition Target

mydata.experiment1 <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment =='Exp1')
mydata.experiment1$subject <- factor(mydata.experiment1$subject)

modelfull <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                     (1|subject), 
                   data = mydata.experiment1, 
                   control=glmerControl(optCtrl=list(maxfun=100000)),
                   family=binomial)

modelnoint <-  glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                       (1|subject), 
                     data = mydata.experiment1, 
                     control=glmerControl(optCtrl=list(maxfun=100000)),
                     family=binomial)

anova(modelfull ,modelnoint)


#Interaction with Predicate Condition (Matching or Mismatching across Primes and Targets)
modelfull.predicates <- glmer(Blur.Selection~Condition.Prime*Condition.Target*Predicate_scale + 
                     (1|subject), 
                   data = mydata.experiment1, 
                   control=glmerControl(optCtrl=list(maxfun=100000)),
                   family=binomial)

model.noint.preducates <- glmer(Blur.Selection~(Condition.Prime+Condition.Target+Predicate_scale)^2+
                       (1|subject), 
                     data = mydata.experiment1, 
                     control=glmerControl(optCtrl=list(maxfun=100000)),
                     family=binomial)

anova(modelfull.predicates, model.noint.preducates)




###Experiment

#My data
mydata.experiment2 <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment =='Exp2')
mydata.experiment2$subject <- factor(mydata.experiment2$subject)

## (Result 1) 3-way/Higher order interaction
model.full <- glmer(Blur.Selection~Condition.Prime.Re*Condition.Target*HOI + 
                      (1|subject), 
                    data = mydata.experiment2, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)

model.noint <- glmer(Blur.Selection~(Condition.Prime.Re+Condition.Target+HOI)^2+
                       (1|subject), 
                    data = mydata.experiment2, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)

anova(model.full,model.noint)


## (Result 2) Interaction C vs. D
mydata.expriment2.primes <- subset(mydata.experiment2, Condition.Prime =='D' | Condition.Prime =='C')
model.full.primes <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                             (1|subject),  
                           data = mydata.expriment2.primes , 
                           control=glmerControl(optCtrl=list(maxfun=100000)),
                           family=binomial)

model.noint.primes <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                              (1|subject), 
                            data = mydata.expriment2.primes , 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)

anova(model.full.primes,model.noint.primes)


## (Result 3) Interaction between baselines
mydata.experiment2.baselines <- subset(mydata.experiment2, Condition.Prime !='D' & Condition.Prime !='C')
model.full.baseline <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                               (1|subject), 
                    data = mydata.experiment2.baselines, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)
model.noint.baseline <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                                (1|subject), 
                     data = mydata.experiment2.baselines, 
                     control=glmerControl(optCtrl=list(maxfun=100000)),
                     family=binomial)

anova(model.full.baseline,model.noint.baseline)

model.main.baseline <- glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                               (1|subject), 
                             data = mydata.experiment2.baselines, 
                             control=glmerControl(optCtrl=list(maxfun=100000)),
                             family=binomial)

model.nomain.baseline <- glmer(Blur.Selection~Condition.Prime + 
                               (1|subject), 
                             data = mydata.experiment2.baselines, 
                             control=glmerControl(optCtrl=list(maxfun=100000)),
                             family=binomial)

anova(model.main.baseline,model.nomain.baseline)

## (Result 4) Interaction D vs. Baseline-only
mydata.DvsOnly <- subset(mydata.experiment2, Condition.Prime =='D' | Condition.Prime =='Baseline-only')
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



## (Result 5) Interaction C vs. Baseline-the

mydata.CvsDef <- subset(mydata.experiment2, Condition.Prime =='C' | Condition.Prime =='Baseline-the')
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





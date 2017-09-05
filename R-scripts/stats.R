
##STATS 

# EXPERIMENT 1 (NEW STATS) ####

# Dependent measure: Distributive responses in targets

mydata.experiment1 <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment =='Exp1')
mydata.experiment1$subject <- factor(mydata.experiment1$subject)
mydata.experiment1$Condition.Prime <- factor(mydata.experiment1$Condition.Prime)
mydata.experiment1$Condition.Target <- factor(mydata.experiment1$Condition.Target)
mydata.experiment1$Interaction<- contrasts(mydata.experiment1$Condition.Prime)[mydata.experiment1$Condition.Prime]*
  contrasts(mydata.experiment1$Condition.Target)[mydata.experiment1$Condition.Target]

# Looking for main effect of Condition.Prime in distributive responses. 

## mydata.experiment1 <- subset(mydata.experiment1, Predicate_scale=='mismatching')
  
  
model.full.exp1 <- glmer(Distributive.response~Condition.Prime + Condition.Target + Interaction + 
                     (1+Condition.Prime|subject), 
                   data = mydata.experiment1, 
                   control=glmerControl(optCtrl=list(maxfun=100000)),
                   family=binomial)

model.nopriming.exp1 <-  glmer(Distributive.response~Condition.Target + Interaction + 
                       (1+Condition.Prime|subject), 
                     data = mydata.experiment1, 
                     control=glmerControl(optCtrl=list(maxfun=100000)),
                     family=binomial)

anova(model.full.exp1, model.nopriming.exp1)

# Interaction with Predicate/Dimension Condition (Matching or Mismatching across Primes and Targets)

modelfull.pred <-  glmer(Distributive.response~(Condition.Prime+Condition.Target+Predicate_scale)^2+
                           (1|subject), 
                         data = mydata.experiment1, 
                         control=glmerControl(optCtrl=list(maxfun=100000)),
                         family=binomial)

model.noint.pred <- glmer(Distributive.response~Condition.Prime*Condition.Target+Predicate_scale +
                                  (1|subject), 
                                data = mydata.experiment1, 
                                control=glmerControl(optCtrl=list(maxfun=100000)),
                                family=binomial)

anova(modelfull.pred, model.noint.pred)


# EXPERIMENT 1 (OLD STATS) ####

# Interaction Condition Prime * Condition Target

mydata.experiment1 <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment =='Exp1')
mydata.experiment1$subject <- factor(mydata.experiment1$subject)

modelfull.blur <- glmer(Blur.Selection~Condition.Prime*Condition.Target + 
                     (1|subject), 
                   data = mydata.experiment1, 
                   control=glmerControl(optCtrl=list(maxfun=100000)),
                   family=binomial)

modelnoint.blur <-  glmer(Blur.Selection~Condition.Prime+Condition.Target + 
                       (1|subject), 
                     data = mydata.experiment1, 
                     control=glmerControl(optCtrl=list(maxfun=100000)),
                     family=binomial)

anova(modelfull.blur ,modelnoint.blur)


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



### EXPERIMENT 2 (NEW STATS) ####

mydata.experiment2 <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment =='Exp2')
mydata.experiment2$subject <- factor(mydata.experiment2$subject)
mydata.experiment2$Condition.Prime.Re <- factor(mydata.experiment2$Condition.Prime.Re)
mydata.experiment2$Condition.Target <- factor(mydata.experiment2$Condition.Target)
mydata.experiment2$Interaction<- contrasts(mydata.experiment2$Condition.Prime.Re)[mydata.experiment2$Condition.Prime.Re]*
  contrasts(mydata.experiment2$Condition.Target)[mydata.experiment2$Condition.Target]


# R1: Interaction between prime condition and type of prime
# model.full <- glmer(Distributive.response~ (Condition.Prime.Re + HOI + Condition.Target)^2 + 
#                       (1|subject), 
#                     data = mydata.experiment2, 
#                     control=glmerControl(optCtrl=list(maxfun=100000)),
#                     family=binomial)

model.full.exp2 <- glmer(Distributive.response~ Condition.Prime.Re*HOI + Condition.Target + Interaction + 
                      (1|subject), 
                    data = mydata.experiment2, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)

model.noint.exp2 <- glmer(Distributive.response~ Condition.Prime.Re + HOI + Condition.Target + Interaction + 
                      (1|subject), 
                    data = mydata.experiment2, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)


anova(model.full.exp2, model.noint.exp2)

# (Result 2) Replication Experiment 1 (Main effect Prime condition)
mydata.expriment2.primes <- subset(mydata.experiment2, Condition.Prime =='D' | Condition.Prime =='C')

model.full.primes <- glmer(Distributive.response~Condition.Prime.Re+ Condition.Target + Interaction + 
                             (1|subject),  
                           data = mydata.expriment2.primes , 
                           control=glmerControl(optCtrl=list(maxfun=100000)),
                           family=binomial)

model.noint.primes <- glmer(Distributive.response~ Condition.Target + Interaction +
                              (1|subject), 
                            data = mydata.expriment2.primes , 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)

anova(model.full.primes,model.noint.primes)

## (Result 3) Effect forbmaselines
mydata.experiment2.baselines <- subset(mydata.experiment2, Condition.Prime !='D' & Condition.Prime !='C')


model.full.baseline <- glmer(Distributive.response~Condition.Prime.Re+ Condition.Target + Interaction + 
                               (1|subject),  
                             data = mydata.experiment2.baselines , 
                             control=glmerControl(optCtrl=list(maxfun=100000)),
                             family=binomial)


model.noint.baseline <- glmer(Distributive.response~ Condition.Target + Interaction + 
                                (1|subject),  
                              data = mydata.experiment2.baselines , 
                              control=glmerControl(optCtrl=list(maxfun=100000)),
                              family=binomial)

anova(model.full.baseline,model.noint.baseline)


## (Result 4) Interaction between type of prime and target?? or main effect of type of prime?
mydata.DvsOnly <- subset(mydata.experiment2, Condition.Prime =='D' | Condition.Prime =='Baseline-only')

## (Result 5) Interaction between type of prime and target?? or main effect of type of prime?









## EXPERIMENT 2 (OLD STATS) ####

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





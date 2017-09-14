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


## (Result 7) 

## First try
## Merge baselines into a single level
## Model 1: Assuming that each condition has a different influence in the amount of distributive responses
T1 <- factor(mydata.experiment2$Condition.Prime=="D")
T2 <- factor(mydata.experiment2$Condition.Prime=="C")
T3 <- factor(mydata.experiment2$Condition.Prime=="Baseline-only"|mydata.experiment2$Condition.Prime=="Baseline-the")

m1 <- glmer(Distributive.response ~ 0 + T1 + T2 + (1|subject), data=mydata.experiment2, family=binomial) 

## Model 2: Assume that each condition has the same influence (but on different directions) in the amount of distributive responses
T4 <- mydata.experiment2$Condition.Prime
levels(T4) <- c('Baseline', "Baseline", 'C', 'D') 

mat = matrix(c(0,1,0,0,0,-1), ncol = 2)
contrasts(T4) <- mat
levels(T4) <- c(0,1,-1) 
T4 <- as.numeric(as.character(T4))
m2 <- glmer(Distributive.response ~ 0 + T4 + (1|subject), data=mydata.experiment2, family=binomial) 

anova(m1,m2)


### Second attempt: function that calculates R^2 (based on https://jonlefcheck.net/2013/03/13/r2-for-linear-mixed-effects-models/)

## Creates a lists of models and calculates R2 for each model...
list.models.C <- list(model.full.C.primes,model.null.C.primes)
sem.model.fits(list.models.C)

list.models.D <- list(model.full.D.primes,model.null.D.primes)
sem.model.fits(list.models.D)


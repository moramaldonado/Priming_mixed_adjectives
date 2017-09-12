
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

## (Result 3) Effect fo rbmaselines
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


## (Result 4) Main effect of type of prime restricted to primes and baselines of the same condition
mydata.DvsOnly <- subset(mydata.experiment2, Condition.Prime =='D' | Condition.Prime =='Baseline-only')

model.full.D.primes <- glmer(Distributive.response~ Condition.Target + HOI + 
                              (1|subject),  
                            data = mydata.DvsOnly , 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)


model.null.D.primes <- glmer(Distributive.response~ Condition.Target  + 
                              (1|subject),  
                            data = mydata.DvsOnly , 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)

anova(model.full.D.primes,model.null.D.primes)

## (Result 5) Interaction between type of prime and target?? or main effect of type of prime?

mydata.CvsDef <- subset(mydata.experiment2, Condition.Prime =='C' | Condition.Prime =='Baseline-the')

model.full.C.primes <- glmer(Distributive.response~ Condition.Target + HOI + 
                              (1|subject),  
                            data = mydata.CvsDef, 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)


model.null.C.primes <- glmer(Distributive.response~ Condition.Target  + 
                              (1|subject),  
                            data = mydata.CvsDef , 
                            control=glmerControl(optCtrl=list(maxfun=100000)),
                            family=binomial)

anova(model.full.C.primes,model.null.C.primes)

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




##STATS 

# EXPERIMENT 1 (NEW STATS) ####

# Dependent measure: Distributive responses in targets
mydata.experiment1 <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment =='Exp1')
mydata.experiment1$subject <- factor(mydata.experiment1$subject)
mydata.experiment1$Condition.Prime <- factor(mydata.experiment1$Condition.Prime)
mydata.experiment1$Condition.Target <- factor(mydata.experiment1$Condition.Target)
mydata.experiment1$Interaction<- contrasts(mydata.experiment1$Condition.Prime)[mydata.experiment1$Condition.Prime]*
  contrasts(mydata.experiment1$Condition.Target)[mydata.experiment1$Condition.Target]

# (Main Result) Looking for main effect of Condition.Prime in distributive responses. 
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


# (Second Result) Restriction to mismatching condition
mydata.experiment1 <- subset(mydata.experiment1, Predicate_scale=='mismatching')
model.full.exp1.mis <- glmer(Distributive.response~Condition.Prime + Condition.Target + Interaction + 
                           (1+Condition.Prime|subject), 
                         data = mydata.experiment1, 
                         control=glmerControl(optCtrl=list(maxfun=100000)),
                         family=binomial)

model.nopriming.exp1.mis <-  glmer(Distributive.response~Condition.Target + Interaction + 
                                 (1+Condition.Prime|subject), 
                               data = mydata.experiment1, 
                               control=glmerControl(optCtrl=list(maxfun=100000)),
                               family=binomial)

anova(model.full.exp1.mis, model.nopriming.exp1.mis)




### EXPERIMENT 2 (NEW STATS) ####

mydata.experiment2 <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment =='Exp2')
mydata.experiment2$subject <- factor(mydata.experiment2$subject)
mydata.experiment2$Condition.Target <- factor(mydata.experiment2$Condition.Target)
levels(mydata.experiment2$Condition.Prime) <- c('Distributive', 'Collective', 'Collective', 'Distributive')

mydata.experiment2$Complete.Type <- paste(mydata.experiment2$HOI, mydata.experiment2$Condition.Prime, sep="")
mydata.experiment2$Interaction<- contrasts(mydata.experiment2$Condition.Prime)[mydata.experiment2$Condition.Prime]*
  contrasts(mydata.experiment2$Condition.Target)[mydata.experiment2$Condition.Target]


# Result 1: Replication of Experiment 1 - Main effect of prime condition (Data restricted to Primes)

mydata.expriment2.primes <- subset(mydata.experiment2, HOI=='prime')

model.full.primes <- glmer(Distributive.response~Condition.Prime + Condition.Target + Interaction + 
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


# Result 2: Interaction between type of prime and prime condition
model.full.exp2 <- glmer(Distributive.response~ Condition.Prime*HOI  + Condition.Target +
                           (1|subject), 
                         data = mydata.experiment2, 
                         control=glmerControl(optCtrl=list(maxfun=100000)),
                         family=binomial)

model.noint.exp2 <- glmer(Distributive.response~ Condition.Prime + HOI + Condition.Target + 
                   (1|subject), 
                    data = mydata.experiment2, 
                    control=glmerControl(optCtrl=list(maxfun=100000)),
                    family=binomial)

anova(model.full.exp2, model.noint.exp2)

# Result 3: Asymmetry of the effect (to mathc with the new plot)
# 1. Change the dependent measure such that we will be comparing proportion of matching responses
# 2. Look for an interaction

#just to have a rough idea...
means <-  ddply(mydata.experiment2,  c("Condition.Prime", "HOI"), 
                                        function(mydata.experiment2)c(mean=mean(mydata.experiment2$Proportion.Matching, na.rm=T)))


model.full.exp2_asymmetry <- glmer(Proportion.Matching~ Condition.Prime*HOI  + 
                           (1|subject), 
                         data = mydata.experiment2, 
                         control=glmerControl(optCtrl=list(maxfun=100000)),
                         family=binomial)

model.noint.exp2_asymmetry <- glmer(Proportion.Matching~ Condition.Prime + HOI +
                            (1|subject), 
                          data = mydata.experiment2, 
                          control=glmerControl(optCtrl=list(maxfun=100000)),
                          family=binomial)

anova(model.full.exp2_asymmetry, model.noint.exp2_asymmetry)

## Other possible way of looking at the asymmetry?
## Merge baselines into a single level
## Model 1: Assume each condition has a different influence in the amount of distributive responses

T1 <- factor(mydata.experiment2$Condition.Prime=="Distributive" & mydata.experiment2$HOI=="prime")
T2 <-  factor(mydata.experiment2$Condition.Prime=="Collective" & mydata.experiment2$HOI=="prime")
T3 <- factor(mydata.experiment2$HOI=="baseline")

m1 <- glmer(Distributive.response ~ 0 + T1 + T2 + (1|subject), data=mydata.experiment2, family=binomial) 

## Model 2: Assume that each condition has the same influence (but on different directions) in the amount of distributive responses
T4 <- factor(mydata.experiment2$Complete.Type)
levels(T4) <- c('Baseline', "Baseline", 'C', 'D') 
mat = matrix(c(0,-1,0,0,0,1), ncol = 2)
contrasts(T4) <- mat
levels(T4) <- c(0,-1,1) 
T4 <- as.numeric(as.character(T4))
m2 <- glmer(Distributive.response ~ 0 + T4 + (1|subject), data=mydata.experiment2, family=binomial) 

anova(m1,m2)





### basic plots
non_accurate_primes <- subset(experimental_items, element.number != 'Target' & Accuracy==FALSE)
ggplot(subset(experimental_items, element.number != 'Target'), aes(x=Predicate.Prime, y=Accuracy, color=Condition.Prime)) + geom_jitter() + facet_grid(Experiment~list)


# ACCURACY IN PRIMES ####
accuracy_primes <- ddply(subset(experimental_items, element.number != 'Target'), c("subject", "Condition.Prime.Re", "Experiment", "HOI"), 
                         function(experimental_items)c(mean=mean(experimental_items$Accuracy, na.rm=T)))

accuracy_primes.overall <-  ddply(accuracy_primes,  c("Condition.Prime.Re", "Experiment", "HOI"), 
                                  function(accuracy_primes)c(mean=mean(accuracy_primes$mean, na.rm=T), se=se(accuracy_primes$mean, na.rm=T)))


# CONTROL RESULTS ####
accuracy_controls <- ddply(subset(control, Condition != 'Both-C' & Condition!='Both-D'), c("subject","Condition", "Experiment"), 
                           function(control)c(mean=mean(control$Selection.Blur_Both, na.rm=T)))

accuracy_controls.overall <-  ddply(accuracy_controls,  c("Condition", "Experiment"), 
                                    function(accuracy_controls)c(mean=mean(accuracy_controls$mean, na.rm=T), se=se(accuracy_controls$mean, na.rm=T)))


both_controls <- ddply(subset(control, Condition == 'Both-C' | Condition=='Both-D'), c("subject","Condition", "Experiment"), 
                       function(control)c(mean=mean(control$Selection.Blur_Both, na.rm=T)))

both_controls.overall <-  ddply(both_controls,  c("Condition", "Experiment"), 
                                function(both_controls)c(mean=mean(both_controls$mean, na.rm=T), se=se(both_controls$mean, na.rm=T)))


ggplot(both_controls.overall, aes(x=Condition, y=mean, fill=Condition)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('Proportion of Strong picture choices')+
  scale_fill_brewer(palette="Greys") +
  theme(legend.position='none')+
  scale_x_discrete(breaks=c("Both-C", "Both-D"),
                   labels=c("Strong \n Collective", "Strong \n Distributive")) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) + facet_grid(~Experiment)

ggsave('Both-Controls.png', path='Paper_Priming_Adjectives/fig/', width=4, height = 4)





## TARGET RESULTS (quantifing distributive responses instead of blur/strong responses)####

# Experiment 1 
results_targets_exp1 <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment=='Exp1'), c("subject","Condition.Prime", "Condition.Target"), 
                         function(experimental_items)c(mean=mean(experimental_items$Distributive.response, na.rm=T)))

results_targets_exp1.overall <-  ddply(results_targets_exp1,  c("Condition.Prime", "Condition.Target"), 
                                  function(results_targets_exp1)c(mean=mean(results_targets_exp1$mean, na.rm=T), se=se(results_targets_exp1$mean, na.rm=T)))


ggplot(results_targets_exp1.overall, aes(x=Condition.Prime, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('Proportion of Distributive responses')+
  scale_x_discrete(breaks=c("C", "D"),
                   labels=c("After \n Collective Prime", "After \n Distributive Prime")) +
  scale_fill_manual(values=my_colours,                       
                    name="Target Condition",
                    breaks=c("C/Pos/Heavy-type", "D/Neg/Light-type" ),
                    labels=c("Collective", "Distributive")) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) 
ggsave('Targets-Experiment1-DR.png', path='Paper_Priming_Adjectives/fig/', width=5, height = 4)


## Matching vs. Mismatching dimension
results_targets <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment=='Exp1'), c("subject","Condition.Prime", "Condition.Target", "Predicate_scale", "Experiment"), 
                         function(experimental_items)c(mean=mean(experimental_items$Distributive.response, na.rm=T)))

results_targets.overall <-  ddply(results_targets,  c("Condition.Prime", "Condition.Target", "Predicate_scale"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

levels(results_targets.overall$Predicate_scale) <- c('Matching dimension', 'Mismatching dimension') 

ggplot(results_targets.overall, aes(x=Condition.Prime, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('Proportion of \'blur\' selection')+
  scale_x_discrete(breaks=c("C", "D"),
                   labels=c("After \n Collective Prime", "After \n Distributive Prime")) +
  scale_fill_manual(values=my_colours,                       
                    name="Target Condition",
                    breaks=c("C/Pos/Heavy-type", "D/Neg/Light-type" ),
                    labels=c("Collective", "Distributive")) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_wrap(~Predicate_scale)

ggsave('Targets-Experiment1-predicates-DR.png', path='Paper_Priming_Adjectives/fig/', width=7, height = 4)


# Experiment 2

results_targets_exp2 <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment=='Exp2'), c("subject","Condition.Prime", "Condition.Target", "HOI"), 
                              function(experimental_items)c(mean=mean(experimental_items$Distributive.response, na.rm=T)))

results_targets_exp2.overall <-  ddply(results_targets_exp2,  c("Condition.Prime", "Condition.Target", "HOI"), 
                                       function(results_targets_exp2)c(mean=mean(results_targets_exp2$mean, na.rm=T), se=se(results_targets_exp2$mean, na.rm=T)))


ggplot(results_targets_exp2.overall, aes(x=Condition.Prime, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('Proportion of Distributive responses')+
  scale_x_discrete(breaks=c('Baseline-only', 'Baseline-the', "C", "D"),
                   labels=c("After \n D-Baseline", "After \n C-Baseline", "After \n Collective Prime", "After \n Distributive Prime")) +
  scale_fill_manual(values=my_colours,                       
                    name="Target Condition",
                    breaks=c("C/Pos/Heavy-type", "D/Neg/Light-type" ),
                    labels=c("Collective", "Distributive")) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_grid(~HOI, scale='free_x')

ggsave('Targets-Experiment2-DR.png', path='Paper_Priming_Adjectives/fig/', width=7, height = 4)



##Last figure for asymmetry


results_targets_simpl <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE & Experiment=='Exp2'), c("subject","Condition.Prime", "HOI"), 
                         function(experimental_items)c(mean=mean(experimental_items$Proportion.Matching, na.rm=T)))


levels(results_targets_simpl$Condition.Prime) <- c('Distributive','Collective','Collective','Distributive')

#results_targets_simpl$mean <- if_else(results_targets_simpl$Condition.Prime=='Collective', 1-results_targets_simpl$mean, results_targets_simpl$mean)


results_targets.overall_simpl <-  ddply(results_targets_simpl,  c("Condition.Prime", "HOI"), 
                                  function(results_targets_simpl)c(mean=mean(results_targets_simpl$mean, na.rm=T), se=se(results_targets_simpl$mean, na.rm=T)))


ggplot(results_targets.overall_simpl, aes(x=HOI, y=mean)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('Proportion of \'matching\' responses')+
   geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_wrap(~Condition.Prime)
ggsave('Targets-Experiment2-Simplified-DR.png', path='Paper_Priming_Adjectives/fig/', width=11, height = 4)


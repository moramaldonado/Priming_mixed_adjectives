
### basic plots

## ACCURACY IN PRIMES
accuracy_primes <- ddply(subset(experimental_items, element.number != 'Target'), c("subject","Condition.Prime"), 
                         function(experimental_items)c(mean=mean(experimental_items$Accuracy, na.rm=T)))

ggplot(accuracy_primes, aes(x=Condition.Prime, y=mean, group=subject, color=subject)) + geom_jitter()+ 
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +ylab('% Accuracy')


accuracy_primes.overall <-  ddply(accuracy_primes,  c("Condition.Prime"), 
                     function(accuracy_primes)c(mean=mean(accuracy_primes$mean, na.rm=T), se=se(accuracy_primes$mean, na.rm=T)))

ggplot(accuracy_primes.overall, aes(x=Condition.Prime, y=mean, fill=Condition.Prime)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Accuracy')+
  ggtitle('Accuracy in primes')+
  scale_x_discrete(breaks=c("Baseline-only","Baseline-the","C","D"), labels=c("Only \n Baseline", "Def \n Baseline", "C Prime", "D Prime"))+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  theme(legend.position='none')

ggsave('Accuracy-Primes.png', path='graphs/')



accuracy_primes <- ddply(subset(experimental_items, element.number != 'Target'), c("subject","Condition.Prime", "Predicate.Prime"), 
                         function(experimental_items)c(mean=mean(experimental_items$Accuracy, na.rm=T)))

accuracy_primes.overall <-  ddply(accuracy_primes,  c("Condition.Prime", "Predicate.Prime"), 
                                  function(accuracy_primes)c(mean=mean(accuracy_primes$mean, na.rm=T), se=se(accuracy_primes$mean, na.rm=T)))

ggplot(accuracy_primes.overall, aes(x=Condition.Prime, y=mean, fill=Condition.Prime)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Accuracy')+
  ggtitle('Accuracy in primes')+
  scale_x_discrete(breaks=c("Baseline-only","Baseline-the","C","D"), labels=c("Only \n Baseline", "Def \n Baseline", "C Prime", "D Prime"))+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  theme(legend.position='none') +
  facet_grid(.~Predicate.Prime)

ggsave('Accuracy-Primes-Predicates.png', path='graphs/')


## CONTROL RESULTS
accuracy_controls <- ddply(subset(control, Condition != 'Both-C' & Condition!='Both-D'), c("subject","Condition"), 
                         function(control)c(mean=mean(control$Selection.Blur_Both, na.rm=T)))

ggplot(accuracy_controls, aes(x=Condition, y=mean, group=subject, color=subject)) + geom_point()+ geom_line() +
ylab('% Selection BLUR option')
ggsave('Subject-Accuracy-Controls.png', path='graphs/')



accuracy_controls.overall <-  ddply(accuracy_controls,  c("Condition"), 
                                  function(accuracy_controls)c(mean=mean(accuracy_controls$mean, na.rm=T), se=se(accuracy_controls$mean, na.rm=T)))

ggplot(accuracy_controls.overall, aes(x=Condition, y=mean, fill=Condition)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Blur selection')+
  ggtitle('BLUR selection in Controls')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))
ggsave('Accuracy-Controls.png', path='graphs/')



both_controls <- ddply(subset(control, Condition == 'Both-C' | Condition=='Both-D'), c("subject","Condition"), 
                           function(control)c(mean=mean(control$Selection.Blur_Both, na.rm=T)))
ggplot(both_controls, aes(x=Condition, y=mean, group=subject, color=subject)) + geom_point()+ geom_line() +
scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) + ylab('% Selection BOTH option')
ggsave('Subject-Both-Controls.png', path='graphs/')

both_controls.overall <-  ddply(both_controls,  c("Condition"), 
                                  function(both_controls)c(mean=mean(both_controls$mean, na.rm=T), se=se(both_controls$mean, na.rm=T)))

ggplot(both_controls.overall, aes(x=Condition, y=mean, fill=Condition)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Both selection')+
  ggtitle('BOTH selection in Controls')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))
ggsave('Both-Controls.png', path='graphs/')


##TARGET RESULTS
levels(experimental_items$Condition.Target) <- c('C/Pos/Heavy-type', 'D/Neg/Light-type')
experimental_items$HOI <- as.factor(if_else(experimental_items$Condition.Prime=='C' |experimental_items$Condition.Prime=='D', 'prime', 'baseline'))
experimental_items$Condition.Prime.Re <- as.factor(if_else(experimental_items$Condition.Prime=='C' |experimental_items$Condition.Prime=='Baseline-the', 'Coll/DEF', 'Dist/Only'))
results_targets <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE), c("subject","Condition.Prime.Re", "Condition.Target", "HOI"), 
                         function(experimental_items)c(mean=mean(experimental_items$Blur.Selection, na.rm=T)))

ggplot(results_targets, aes(x=Condition.Prime, y=mean)) + geom_boxplot()

results_targets.overall <-  ddply(results_targets,  c("Condition.Prime.Re", "Condition.Target", "HOI"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

ggplot(results_targets.overall, aes(x=Condition.Prime.Re, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
    ylab('% Blur selection')+
  scale_fill_manual(values=my_colours)+ 
  ggtitle('BLUR selection in targets')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_grid(.~HOI, scales='free_x')

ggsave('BLUR_targets.png', path='graphs/')


#Matching predicates
results_targets <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE), c("subject","Condition.Prime", "Condition.Target", "Predicate_scale"), 
                         function(experimental_items)c(mean=mean(experimental_items$Blur.Selection, na.rm=T)))

results_targets.overall <-  ddply(results_targets,  c("Condition.Prime", "Condition.Target", "Predicate_scale"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

ggplot(results_targets.overall, aes(x=Condition.Prime, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  scale_x_discrete(breaks=c("Baseline-only","Baseline-the","C","D"), labels=c("After Only \n Baseline", "After Def \n Baseline", "After C \n Prime", "After D \n Prime"))+
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Blur selection')+
  scale_fill_manual(values=my_colours)+ 
  ggtitle('BLUR selection in targets')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))+
  facet_grid(.~Predicate_scale)

ggsave('BLUR_targets_predicate.png', path='graphs/')





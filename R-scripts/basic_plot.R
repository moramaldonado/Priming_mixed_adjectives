
### basic plots
non_accurate_primes <- subset(experimental_items, element.number != 'Target' & Accuracy==FALSE)
ggplot(subset(experimental_items, element.number != 'Target'), aes(x=Predicate.Prime, y=Accuracy, color=Condition.Prime)) + geom_jitter() + facet_grid(Experiment~list)

non_accurate_targets <- subset(experimental_items, element.number == 'Target' & Accuracy==FALSE)
targets <- subset(experimental_items, element.number == 'Target')


## ACCURACY IN PRIMES
accuracy_primes <- ddply(subset(experimental_items, element.number != 'Target'), c("subject", "Condition.Prime.Re", "Experiment", "HOI"), 
                         function(experimental_items)c(mean=mean(experimental_items$Accuracy, na.rm=T)))

accuracy_primes.overall <-  ddply(accuracy_primes,  c("Condition.Prime.Re", "Experiment", "HOI"), 
                     function(accuracy_primes)c(mean=mean(accuracy_primes$mean, na.rm=T), se=se(accuracy_primes$mean, na.rm=T)))

ggplot(accuracy_primes.overall, aes(x=Condition.Prime.Re, y=mean, fill=Condition.Prime.Re)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Accuracy')+
  ggtitle('Accuracy in primes')+
  #scale_x_discrete(breaks=c("Baseline-only","Baseline-the","C","D"), labels=c("Only \n Baseline", "Def \n Baseline", "C Prime", "D Prime"))+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  theme(legend.position='none') +
  facet_wrap(HOI~Experiment, scale='free_x')

ggsave('Accuracy-Primes.png', path='graphs/', width=10)


# By predicate
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

ggsave('Accuracy-Primes-Predicates.png', path='graphs/', width=10)


## CONTROL RESULTS
accuracy_controls <- ddply(subset(control, Condition != 'Both-C' & Condition!='Both-D'), c("subject","Condition", "Experiment"), 
                         function(control)c(mean=mean(control$Selection.Blur_Both, na.rm=T)))

ggplot(accuracy_controls, aes(x=Condition, y=mean, group=subject, color=subject)) + geom_point()+ geom_line() + theme(legend.position='none')+
ylab('% Selection BLUR option')
ggsave('Subject-Accuracy-Controls.png', path='graphs/', width = 7)

accuracy_controls.overall <-  ddply(accuracy_controls,  c("Condition", "Experiment"), 
                                  function(accuracy_controls)c(mean=mean(accuracy_controls$mean, na.rm=T), se=se(accuracy_controls$mean, na.rm=T)))

ggplot(accuracy_controls.overall, aes(x=Condition, y=mean, fill=Condition)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Blur selection')+
  ggtitle('BLUR selection in Controls')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_wrap(~Experiment, scale='free_x')
ggsave('Accuracy-Controls.png', path='graphs/' , width=5)



both_controls <- ddply(subset(control, Condition == 'Both-C' | Condition=='Both-D'), c("subject","Condition", "Experiment"), 
                           function(control)c(mean=mean(control$Selection.Blur_Both, na.rm=T)))
ggplot(both_controls, aes(x=Condition, y=mean, group=subject, color=subject)) + geom_point()+ geom_line() + theme(legend.position='none')+
scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) + ylab('% Selection BOTH option') + facet_grid(~Experiment)

ggsave('Subject-Both-Controls.png', path='graphs/', width = 7)

both_controls.overall <-  ddply(both_controls,  c("Condition", "Experiment"), 
                                  function(both_controls)c(mean=mean(both_controls$mean, na.rm=T), se=se(both_controls$mean, na.rm=T)))

ggplot(both_controls.overall, aes(x=Condition, y=mean, fill=Condition)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Both selection')+
  ggtitle('BOTH selection in Controls')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) + facet_grid(~Experiment)

ggsave('Both-Controls.png', path='graphs/', width=7)


##TARGET RESULTS
levels(experimental_items$Condition.Target) <- c('C/Pos/Heavy-type', 'D/Neg/Light-type')
experimental_items$HOI <- as.factor(if_else(experimental_items$Condition.Prime=='C' |experimental_items$Condition.Prime=='D', 'prime', 'baseline'))
experimental_items$Condition.Prime.Re <- as.factor(if_else(experimental_items$Condition.Prime=='C' |experimental_items$Condition.Prime=='Baseline-the', 'Coll/DEF', 'Dist/Only'))

ggplot(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE), aes(x=Condition.Target, y=Blur.Selection, color=Condition.Prime)) + geom_jitter() + facet_grid(.~list)
targets <- subset(experimental_items, element.number == 'Target')
accurate <- subset(experimental_items, element.number == 'Target' & Accuracy==TRUE)

results_targets.count <- ddply(subset(experimental_items, element.number == 'Target'), c("subject","Condition.Prime", "Condition.Target", "Accuracy", "Experiment"), 
                         function(experimental_items)c(count=length(experimental_items$Blur.Selection)))



results_targets <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE), c("subject","Condition.Prime.Re", "Condition.Target", "HOI", "Experiment"), 
                         function(experimental_items)c(mean=mean(experimental_items$Blur.Selection, na.rm=T)))

ggplot(results_targets, aes(x=Condition.Prime.Re, y=mean, colour=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  scale_colour_manual(values=my_colours)+ 
  geom_jitter()+
  ylab('% Blur selection')+
  ggtitle('BLUR selection in targets')+
  theme(legend.position='none')+
  facet_grid(Experiment~HOI, scales='free_x') 
ggsave('BLUR_targets-Subjects.png', path='graphs/', width=5)

results_targets.overall <-  ddply(results_targets,  c("Condition.Prime.Re", "Condition.Target", "HOI", "Experiment"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

ggplot(results_targets.overall, aes(x=Condition.Prime.Re, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
    ylab('% Blur selection')+
  scale_fill_manual(values=my_colours)+ 
  ggtitle('BLUR selection in targets')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_grid(Experiment~HOI, scales='free_x')

ggsave('BLUR_targets-HOI.png', path='graphs/', width=10)


results_targets <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE), c("subject","Condition.Prime.Re", "Condition.Target", "HOI", "Experiment"), 
                         function(experimental_items)c(mean=mean(experimental_items$Distributive.response, na.rm=T)))
results_targets.overall <-  ddply(results_targets,  c("Condition.Prime.Re", "Condition.Target", "HOI", "Experiment"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

ggplot(results_targets.overall, aes(x=Condition.Prime.Re, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Distributive responses')+
  scale_fill_manual(values=my_colours)+ 
  ggtitle('Distributive selection in targets')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_grid(Experiment~HOI, scales='free_x')




try <- subset(experiment2, HOI=='baseline')
try$mi <- if_else(try$element.number == 'Prime2' & (try$exemplar=='bird' | try$exemplar=='book'), TRUE, FALSE)
try$mi[try$element.number=='Target'] <- try$mi[try$element.number=='Prime2']
try <- subset(try, Accuracy==TRUE & element.number=='Target' & mi==TRUE)

results_targets <- ddply(subset(try, element.number == 'Target' & Accuracy==TRUE), c("subject","Condition.Prime.Re", "Condition.Target", "HOI", "Experiment"), 
                         function(try)c(mean=mean(try$Blur.Selection, na.rm=T)))

results_targets.overall <-  ddply(results_targets,  c("Condition.Prime.Re", "Condition.Target", "HOI", "Experiment"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

ggplot(results_targets.overall, aes(x=Condition.Prime.Re, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Blur selection')+
  scale_fill_manual(values=my_colours)+ 
  ggtitle('BLUR selection in targets')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
  facet_grid(Experiment~HOI, scales='free_x')



#Matching predicates
results_targets <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE), c("subject","Condition.Prime", "Condition.Target", "Predicate_scale", "Experiment"), 
                         function(experimental_items)c(mean=mean(experimental_items$Blur.Selection, na.rm=T)))

results_targets.overall <-  ddply(results_targets,  c("Condition.Prime", "Condition.Target", "Predicate_scale", "Experiment"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

ggplot(results_targets.overall, aes(x=Condition.Prime, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  #scale_x_discrete(breaks=c("Baseline-only","Baseline-the","C","D"), labels=c("After Only \n Baseline", "After Def \n Baseline", "After C \n Prime", "After D \n Prime"))+
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Blur selection')+
  scale_fill_manual(values=my_colours)+ 
  ggtitle('BLUR selection in targets')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))+
  facet_wrap(Experiment~Predicate_scale, scale='free_x')

ggsave('BLUR_targets_predicate.png', path='graphs/', width=10)


##TARGET RESULTS
results_targets <- ddply(subset(experimental_items, element.number == 'Target' & Accuracy==TRUE), c("subject","Condition.Prime", "Condition.Target", "Experiment"), 
                         function(experimental_items)c(mean=mean(experimental_items$Blur.Selection, na.rm=T)))

results_targets.overall <-  ddply(results_targets,  c("Condition.Prime", "Condition.Target", "Experiment"), 
                                  function(results_targets)c(mean=mean(results_targets$mean, na.rm=T), se=se(results_targets$mean, na.rm=T)))

theme_mm_presentation <- theme_grey() +
  theme(
    plot.margin=unit(x=c(1,1,1,1),units="mm"),
    axis.title.y=element_text(angle=90,vjust=.3, size=12),
    axis.title.x=element_blank(),
    axis.text.x=element_text(size=12), 
    axis.text.y=element_text(size=12), 
    strip.background =  element_rect(fill = "white", colour = "white"),
    strip.text.x = element_text(size = 12, vjust=0.5, colour="grey30"),
    panel.background =  element_rect(fill = "white", colour = "black"),
    panel.grid.major.y = element_line(colour = 'gray', linetype = 'solid', size=.5),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(size=13),
    legend.text=element_text(size=12),
    legend.title = element_blank(),
    legend.position='top',
    complete=FALSE
  )

theme_set(theme_mm_presentation)
levels(results_targets.overall$Condition.Target) <- c('Collective \n Target', 'Distributive \n Target')

ggplot(subset(results_targets.overall, Experiment=='E2'), aes(x=Condition.Prime, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Selection of Blur option')+
  ggtitle('Fig. 2')+
  scale_x_discrete(breaks=c("C","D"), labels=c("After Collective \n Prime", "After Distributive \n Prime"))+
  scale_fill_manual(values=my_colours)+ 
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) 

ggsave('BLUR_targets_exp2.png', path='graphs/', width=6)

ggplot(subset(results_targets.overall, Experiment=='E1'), aes(x=Condition.Prime, y=mean, fill=Condition.Target)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% Blur selection')+
  scale_x_discrete(breaks=c("Baseline-only","Baseline-the","C","D"), labels=c("After D \n Baseline", "After C \n Baseline", "After Collective \n Prime", "After Distributive \n Prime"))+
  scale_fill_manual(values=my_colours)+ 
  ggtitle('BLUR selection in targets')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) 



#basic plots
results <- subset(results, Condition != 'NA')
ap <-  ddply(subset(results, Condition != 'NA' & Parte!='OVERT'), c("subject","Condition","Parte","pilot", "Valence"), 
             function(results)c(mean=mean(results$APBLUR, na.rm=T)))

ggplot(ap, aes(x=Condition, y=mean, group=subject, color=subject)) + geom_point()+ geom_line()+facet_grid(pilot+Parte~Valence, scales = "free_x") +ylab('% AP/BLUR choices')+theme(legend.position="none") 


overt <-  ddply(subset(results, (Condition != 'D-Both' & Condition !='C-Both')& Parte=='OVERT' ), c("subject","Condition","Parte","pilot", "Valence"), 
                function(results)c(mean=mean(results$Foil, na.rm=T)))
ggplot(overt, aes(x=Condition, y=mean, group=subject, color=subject)) + geom_point()+ geom_line()+facet_grid(pilot+Parte~Valence, scales = "free_x") +ylab('% Foil choices')+ theme(legend.position="none")


target <-  ddply(subset(results, (Condition == 'D-Both' | Condition =='C-Both')& Parte=='OVERT' ), c("subject","Condition","Parte","pilot"), 
                 function(results)c(mean=mean(results$Both, na.rm=T)))
ggplot(target, aes(x=Condition, y=mean, group=subject, color=subject)) + geom_point()+ geom_line()+facet_grid(pilot+Parte~., scales = "free_x") +ylab('% Both choices') +theme(legend.position="none")


#good_subjects_ap <- subset(ap, Condition=='Foil' & mean>.3)
#good_subjects_overt <- subset(overt, mean<.3)

#results <- filter(results, subject %in% good_subjects_ap$subject)



ap.overall <-  ddply(ap,  c("Condition","Parte","pilot", 'Valence'), 
             function(ap)c(mean=mean(ap$mean, na.rm=T), se=se(ap$mean, na.rm=T)))

ggplot(ap.overall, aes(x=Condition, y=mean, fill=Valence)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab('% AP/BLUR choices')+
  xlab('Condition (Which was the other picture?)')+
  facet_grid(pilot+Parte~.,scales = "free_x")+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))



overt.overall <-  ddply(overt,  c("Condition","Parte","pilot", "Valence"), 
                     function(overt)c(mean=mean(overt$mean, na.rm=T), se=se(overt$mean, na.rm=T)))
ggplot(overt.overall, aes(x=Condition, y=mean, fill=Valence)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  facet_grid(pilot+Parte~.,scales = "free_x")+
  ylab('% Foil choices')+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))

target <-  ddply(subset(results, (Condition == 'D-Both' | Condition =='C-Both')& Parte=='OVERT' ), c("subject","Condition","Parte","pilot", "Valence"), 
                 function(results)c(mean=mean(results$Both, na.rm=T)))

target.overall <-  ddply(target,  c("Condition","Parte","pilot", "Valence"), 
                        function(target)c(mean=mean(target$mean, na.rm=T), se=se(overt$mean, na.rm=T)))
ggplot(target.overall, aes(x=Condition, y=mean, fill=Valence)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  ylab("% Both choices")+
  facet_grid(pilot+Parte~.,scales = "free_x")+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))


ap$img<- 'AP/BLURR'
target$img<- 'Both'
overt$img<- 'Foil'

all <- rbind(target,ap)
all<- rbind(all,overt)

all.overall <- ddply(all, c("Condition","Parte","pilot", "img"),
                   function(all)c(mean=mean(all$mean, na.rm=T), se= se(all$mean)))

ggplot(all.overall, aes(x=Condition, y=mean, fill=img)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  facet_grid(pilot~Parte,scales = "free_x")+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9))

##Predicates

ap.predicate <-  ddply(subset(results, Condition != 'NA' & Parte!='OVERT'), c("subject","Condition","Parte","pilot", "Predicate"), 
             function(results)c(mean=mean(results$APBLUR, na.rm=T)))
ap.predicate.overall <-  ddply(ap.predicate,  c("Condition","Parte","pilot", "Predicate"), 
                     function(ap.predicate)c(mean=mean(ap.predicate$mean, na.rm=T), se=se(ap.predicate$mean, na.rm=T)))


overt.predicate <-  ddply(subset(results, (Condition != 'D-Both' & Condition !='C-Both')& Parte=='OVERT' ), c("subject","Condition","Parte","pilot", "Predicate"), 
                function(results)c(mean=mean(results$Foil, na.rm=T)))

overt.predicate.overall <-  ddply(overt.predicate,  c("Condition","Parte","pilot", "Predicate"), 
                               function(overt.predicate)c(mean=mean(overt.predicate$mean, na.rm=T), se=se(overt.predicate$mean, na.rm=T)))


target.predicate <-  ddply(subset(results, (Condition == 'D-Both' | Condition =='C-Both')& Parte=='OVERT' ), c("subject","Condition","Parte","pilot", "Predicate"), 
                 function(results)c(mean=mean(results$Both, na.rm=T)))

target.predicate.overall <-  ddply(target.predicate,  c("Condition","Parte","pilot", "Predicate"), 
                               function(target.predicate)c(mean=mean(target.predicate$mean, na.rm=T), se=se(target.predicate$mean, na.rm=T)))

ap.predicate.overall$img <- 'AP/BLUR'
overt.predicate.overall$img <- 'Foil'
target.predicate.overall$img <- 'Both'

all.predicate<- rbind(ap.predicate.overall, overt.predicate.overall) 
all.predicate<- rbind(all.predicate, target.predicate.overall) 

ggplot(all.predicate, aes(x=Condition, y=mean, fill=img)) +
  scale_y_continuous(breaks=c(0,.25,.5,.75,1), limits=c(0,1)) +
  geom_bar(colour="black",position='dodge', stat="identity") +
  facet_grid(Predicate~pilot+Parte,scales = "free_x")+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(.9)) +
 theme(axis.text.x = element_text(angle=90, hjust=1)) 


#Information
information1 <- get.results(file.path(getwd(), "1705-PrimingAdjL1" ,"results", "results"),"NewForm",col.names=c("variable","values") , del.col= NULL)
information1<- subset(information1, variable!='_REACTION_TIME_')
information1$Col10 <- NULL 
information1$Col11 <- NULL 
information1$Col12 <- NULL 
information1$Col13 <- NULL 
information1$Col14 <- NULL 
information1$controller <- NULL
information1 <- dcast(information1, subject +md5.hash ~ variable, value.var="values")
information1$list <- 'L1'
information1$Experiment <- 'E2'

information2 <- get.results(file.path(getwd(), "1705-PrimingAdjL2" ,"results", "results"),"NewForm",col.names=c("variable","values") , del.col= NULL)
information2<- subset(information2, variable!='_REACTION_TIME_')
information2$Col10 <- NULL 
information2$Col11 <- NULL 
information2$Col12 <- NULL 
information2$Col13 <- NULL 
information2$Col14 <- NULL 
information2$controller <- NULL
information2 <- dcast(information2, subject +md5.hash ~ variable, value.var="values")
information2$list <- 'L2'
information2$Experiment <- 'E2'

information3 <- get.results(file.path(getwd(), "1705-PrimingAdj-Exp2L1" ,"results", "results"),"NewForm",col.names=c("variable","values") , del.col= NULL)
information3<- subset(information3, variable!='_REACTION_TIME_')
information3$Col10 <- NULL 
information3$Col11 <- NULL 
information3$Col12 <- NULL 
information3$Col13 <- NULL 
information3$Col14 <- NULL 
information3$controller <- NULL
information3 <- dcast(information3, subject +md5.hash ~ variable, value.var="values")
information3$list <- 'L1'
information3$Experiment <- 'E1'

information4 <- get.results(file.path(getwd(), "1705-PrimingAdj-Exp2L2" ,"results", "results"),"NewForm",col.names=c("variable","values") , del.col= NULL)
information4<- subset(information4, variable!='_REACTION_TIME_')
information4$Col10 <- NULL 
information4$Col11 <- NULL 
information4$Col12 <- NULL 
information4$Col13 <- NULL 
information4$Col14 <- NULL 
information4$controller <- NULL
information4 <- dcast(information4, subject +md5.hash ~ variable, value.var="values")
information4$list <- 'L2'
information4$Experiment <- 'E1'

information <- rbind(information1, information2, information3, information4)
information$md5.hash <- factor(information$md5.hash)
rm(information1, information2, information3, information4)


  
#Results
results1 <- get.results(file.path(getwd(), "1705-PrimingAdjL1", "results", "results"),'PictureAccept', del.col= NULL, col.names=c("sentence","answer","nada","rt"))
results1$list <- 'L1'
results2 <- get.results(file.path(getwd(), "1705-PrimingAdjL2", "results", "results"),'PictureAccept', del.col= NULL, col.names=c("sentence","answer","nada","rt"))
results2$list <- 'L2'
results3 <- get.results(file.path(getwd(), "1705-PrimingAdj-Exp2L1", "results", "results"),'PictureAccept', del.col= NULL, col.names=c("sentence","answer","nada","rt"))
results3$list <- 'L1'
results4 <- get.results(file.path(getwd(), "1705-PrimingAdj-Exp2L2", "results", "results"),'PictureAccept', del.col= NULL, col.names=c("sentence","answer","nada","rt"))
results4$list <- 'L2'
results <- rbind(results1, results2, results3, results4)
rm(results1,results2, results3, results4)

for (s in levels(factor(results$subject)))
{results$idturk[results$subject == s ] <- information$idturk[information$subject == s ]}
results$idturk <- factor(results$idturk)

results$subject <- results$idturk
information$subject <- information$idturk


results <- results %>%
  dplyr::select(-nada,-Col12, -Col13, -Col14,-group, -controller)%>%
  
  #Experiment_ConditionPrime_ConditionTarget_PredicateCondition_ImgCondition_PredicatePrime_PredicateTarget_ValencePrime_ValenceTarget_ResponseOrder
  separate(type, c('Experiment','Condition.Prime','Condition.Target','Predicate_scale','Image_side','Predicate.Prime', 'Polarity.Prime','Predicate.Target', 'Polarity.Target', 'Image.Position'),
           sep = "_", remove = TRUE, convert = FALSE) %>%
  mutate(answer = as.factor(if_else(answer==1,'L','R')))%>%
  mutate(exemplar=if_else(grepl('bag',results$sentence, ignore.case=TRUE),'bag',
                          if_else(grepl('book',results$sentence, ignore.case=TRUE), 'book',
                                  if_else(grepl('watch',results$sentence, ignore.case=TRUE), 'watch',
                                          if_else(grepl('bird',results$sentence, ignore.case=TRUE), 'bird',
                                                  if_else(grepl('instrument',results$sentence, ignore.case=TRUE), 'instrument',
                                                          if_else(grepl('car',results$sentence, ignore.case=TRUE), 'car',
                                                                  if_else(grepl('drum',results$sentence, ignore.case=TRUE), 'drum','trumpet'))))))))%>%
  
  
  mutate(Polarity.Prime= as.factor(if_else(Polarity.Prime==1, 'neg', 'pos'))) %>%
  mutate(Polarity.Target= as.factor(if_else(Polarity.Target==1, 'neg', 'pos'))) %>%
  mutate(Experiment= as.factor(Experiment)) %>%
  mutate(element.number= as.factor(if_else(element.number==0 & Condition.Prime != 'Control', 'Prime1', 
                                           if_else(element.number==1, 'Prime2',
                                                   if_else(element.number==2, 'Target', 'Control')))))

experimental_items <-  results %>%
  filter(Condition.Prime!='Control' & Condition.Prime!='practice') %>%
  separate(Image.Position, c('Prime1.Foil','Prime2.Foil','Target.Blur'),
           sep = "-", remove = TRUE, convert = FALSE) %>%
  mutate(Accuracy= if_else(element.number=='Prime1'& Prime1.Foil != answer,TRUE,
                           if_else(element.number=='Prime2'& Prime2.Foil != answer, TRUE, 
                                   if_else(element.number=='Target', NA, FALSE))))%>%
  mutate (Blur.Selection= if_else(element.number=='Target'& Target.Blur == answer,TRUE, 
                                 if_else(element.number!='Target', NA, FALSE))) %>%
  mutate(Condition.Prime = factor(Condition.Prime)) %>%
  mutate(Condition.Target = factor(Condition.Target)) %>%
  mutate(Predicate_scale = factor(Predicate_scale)) %>%
  mutate(Predicate.Prime = factor(Predicate.Prime)) %>%
  
  mutate(Image_side = factor(Image_side)) %>%
  mutate(Predicate.Target = factor(Predicate.Target)) %>%
  mutate(item.number = factor(item.number))

  
experimental_items$Accuracy.P1[experimental_items$element.number=='Target'] <- 
  experimental_items$Accuracy[experimental_items$element.number=='Prime1']

experimental_items$Accuracy.P2[experimental_items$element.number=='Target'] <- 
  experimental_items$Accuracy[experimental_items$element.number=='Prime2']

experimental_items$Accuracy[experimental_items$element.number=='Target'] <- 
  if_else(experimental_items$Accuracy.P1[experimental_items$element.number=='Target'] ==TRUE & experimental_items$Accuracy.P2[experimental_items$element.number=='Target'] ==TRUE, TRUE, FALSE) 

experimental_items$Accuracy.P1 <- NULL
experimental_items$Accuracy.P2 <- NULL

levels(experimental_items$Experiment) <- c('Exp2', 'Exp1', 'practice')
experimental_items$Experiment <- relevel(experimental_items$Experiment, "Exp1")

levels(experimental_items$Condition.Target) <- c('C/Pos/Heavy-type', 'D/Neg/Light-type')
experimental_items$HOI <- as.factor(if_else(experimental_items$Condition.Prime=='C' |experimental_items$Condition.Prime=='D', 'prime', 'baseline'))
experimental_items$Condition.Prime.Re <- as.factor(if_else(experimental_items$Condition.Prime=='C' |experimental_items$Condition.Prime=='Baseline-the', 'Coll/DEF', 'Dist/Only'))


experimental_items <- experimental_items %>%
  mutate(Distributive.response = if_else(element.number=='Target' & Condition.Target =='C/Pos/Heavy-type', 
                                         Blur.Selection, 
                                         if_else(element.number=='Target' & Condition.Target =='D/Neg/Light-type',
                                           !Blur.Selection,
                                           NA)))


summary(experimental_items)





experiment1 <- subset(experimental_items, Experiment=='Exp1')
experiment2 <- subset(experimental_items, Experiment=='Exp2')


control <- results %>% 
  filter(Condition.Prime=='Control') %>%
  dplyr::select(subject, md5.hash, item.number, Experiment, Condition=Condition.Target, Predicate=Predicate_scale, Polarity=Image_side, Image.Position=Predicate.Prime, sentence, answer, rt,list) %>%
  separate(Image.Position, c('Blur_Both','Overt'),
           sep = "-", remove = TRUE, convert = FALSE) %>%
  mutate(Selection.Blur_Both = if_else(Blur_Both==answer, TRUE, FALSE)) %>%
  mutate(Condition = factor(Condition)) %>%
  mutate(Polarity = factor(Polarity)) %>%
  mutate(Predicate = factor(Predicate)) %>%
  mutate(item.number = factor(item.number)) %>%
  mutate(Accuracy = if_else(Condition=='Foil-Blur' & Selection.Blur_Both==TRUE, TRUE, 
                            if_else(Condition=='True-Blur' & Selection.Blur_Both==FALSE, TRUE, 
                                    if_else(Condition=='Both-C' | Condition=='Both-D', NA, FALSE))))



levels(control$Experiment) <- c('Exp2', 'Exp1', 'practice')
control$Experiment <- relevel(control$Experiment, "Exp1")

summary(control)

#saving results
write.csv(control, file = "controls.csv", row.names=FALSE)
write.csv(experimental_items, file = "experimental_items.csv", row.names=FALSE)
write.csv(information, file = "information.csv", row.names=FALSE)

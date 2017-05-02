
#Information
information <- get.results(file.path(getwd(), "results", "results"),"NewForm",col.names=c("variable","values") , del.col= NULL)
information<- subset(information, variable!='_REACTION_TIME_')
information$Col10 <- NULL 
information$Col11 <- NULL 
information$Col12 <- NULL 
information$Col13 <- NULL 
information$Col14 <- NULL 
information$controller <- NULL
information <- dcast(information, subject +md5.hash ~ variable, value.var="values")
  
#Results
results <- get.results(file.path(getwd(), "results", "results"),'PictureAccept', del.col= NULL, col.names=c("sentence","answer","nada","rt"))

results <- results %>%
  dplyr::select(-nada,-Col12, -Col13, -Col14,-group, -controller)%>%
  separate(type, c('Experiment','Condition.Prime','Condition.Target','Predicate_scale','Image_side','Predicate.Prime', 'Polarity.Prime','Predicate.Target', 'Polarity.Target', 'Image.Position'),
           sep = "_", remove = TRUE, convert = FALSE) %>%
  mutate(answer = as.factor(if_else(answer==1,'L','R')))%>%
  mutate(Polarity.Prime= as.factor(if_else(Polarity.Prime==1, 'neg', 'pos'))) %>%
  mutate(Polarity.Target= as.factor(if_else(Polarity.Target==1, 'neg', 'pos'))) %>%
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

experimental_items$Accuracy[experimental_items$element.number=='Target'] <- 
  experimental_items$Accuracy[experimental_items$element.number=='Prime2']

  
  

summary(experimental_items)
  
control <- results %>% 
  filter(Condition.Prime=='Control') %>%
  dplyr::select(subject, md5.hash, item.number, Experiment, Condition=Condition.Target, Predicate=Predicate_scale, Polarity=Image_side, Image.Position=Predicate.Prime, sentence, answer, rt) %>%
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





summary(control)

#saving results
write.csv(control, file = "controls.csv", row.names=FALSE)
write.csv(experimental_items, file = "experimental_items.csv", row.names=FALSE)
write.csv(information, file = "information.csv", row.names=FALSE)

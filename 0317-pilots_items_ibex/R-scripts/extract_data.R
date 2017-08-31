
#
pilots <- c('1a','1b','2a','2b')


#Information
for (i in pilots){
  information <- get.results(file.path(getwd(), paste('1703-Primingadjectives',i,sep=""), "results", "results"),"NewForm",col.names=c("variable","values") , del.col= NULL)
  information<- subset(information, variable!='_REACTION_TIME_')
  information$Col10 <- NULL 
  information$Col11 <- NULL 
  information$Col12 <- NULL 
  information$Col13 <- NULL 
  information$Col14 <- NULL 
  information$controller <- NULL
  information <- dcast(information, subject +md5.hash ~ variable, value.var="values")
  information$pilot <- i
  assign(paste0('information',i), information)
  rm(information)
  }
  
information <- rbind(information1a,information1b,information2a,information2b)
rm(information1a,information1b,information2a,information2b)



#Results
for (i in pilots){
results <- get.results(file.path(getwd(), paste('1703-Primingadjectives',i,sep=""), "results", "results"),'PictureAccept', del.col= NULL, col.names=c("sentence","answer","nada","rt"))
results$pilot <- i
results <- results %>%
  dplyr::select(-nada,-Col12, -Col13, -Col14,-group, -controller)%>%
  separate(type, c('Parte','Condition','Predicate','Valence','Exemplars','Images'), sep = "_", remove = TRUE, convert = FALSE)%>%
  separate(Images, c('Left','Right'), sep = "/", remove = TRUE, convert = FALSE)%>%
  mutate(answer = as.factor(if_else(answer==1,'Left','Right')))%>%
  mutate(img_answer = as.factor(if_else(answer=='Left', Left, Right)))%>%
  mutate(Valence= as.factor(if_else(Valence==1, 'neg', 'pos'))) %>%
  mutate(Parte= as.factor(if_else(Parte=='a', 'AP', 
                                  if_else(Parte=='b','BLUR','OVERT')))) %>%
  mutate(Condition= as.factor(Condition))%>%
  mutate(Predicate= as.factor(Predicate))%>%
  mutate(Both= if_else(img_answer=='Both', TRUE, FALSE))%>%
  mutate(C= if_else(img_answer=='C', TRUE, FALSE))%>%
  mutate(D= if_else(img_answer=='D', TRUE, FALSE))%>%
  mutate(APBLUR = if_else(img_answer=='AP', TRUE, if_else(img_answer=='BLUR',TRUE, FALSE)))%>%
  mutate(Foil= if_else(img_answer=='Foil', TRUE, FALSE))
  assign(paste0('results',i), results)
  rm(results)
  
}
results <- rbind(results1a,results1b,results2a,results2b)
rm(results1a,results1b,results2a,results2b)
results$pilot <- factor(results$pilot)
levels(results$pilot) <- c('AP-OVERT', 'BLUR-OVERT', 'OVERT-AP', 'OVERT-BLUR')

#saving results
write.csv(results, file = "results.csv", row.names=FALSE)
write.csv(information, file = "information.csv", row.names=FALSE)

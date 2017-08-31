
# Data cleaning / management
require(tidyverse)
require(plyr)
require(ggplot2)
require(reshape2)


#MASS and lmer
require(lme4)

############################
# Parsimonious mixed models
############################

# Implements a basic version of Bates et al (2015) parsimonious models
# Expects models with maximal RE structure (in the sense of Barr et al (2013)) and does the following:
# 	1) runs PCA on each RE structure,
# 	2) eliminates components with variance below 'tol', relative to the main component,
# 	3) checks that no remaining component is under 'tol' (the updated model does not have correlations between RE components), otherwise eliminates them.

# The function seems to work well even when the input model had not converged.

# The function should work with glmer as well (only tested with family=binomial(link="logit") though)

# By default, the output is not comparable with the original model because they are not fitted on the same data (i.e., anova(model, parsimonious(model)) will return an error). Use option "comparable=TRUE" to force the new model to be comparable with the original model. This will define the factors used in the new RE structures locally. Note that by doing so, the new model will not be comparable with models obtained by further update. If you wish to compare the new model to further updated models but set the option comparable to TRUE, you must refit the new model on its own model.frame first (i.e., run "update(new_model,data=model.frame(new_model))").

require(lme4)
require(RePsychLing)


parsimonious<-function(mod,tol=1e-3,comparable=F){
  RE<-names(ranef(mod))
  dat.name<-getCall(mod)[[3]]
  newdat<-model.frame(mod)
  if (comparable & length(dat.name)>1) {
    warning("The data of the model is given by a complex expression. This is not compatible with option 'comparable=T'. Reverting to default behavior 'comparable=F'")
    comparable<-F
  }
  # If the RE structure is already minimal, do nothing:
  if (length(RE)==length(getME(mod,"Ztlist"))) {return(mod)}
  else{
    # Get the formula without the RE:
    trms<-attributes(terms(formula(mod)))$term.labels
    sf<-paste(deparse(formula(mod)),collapse="")
    sf<-gsub("[[:space:]]+"," ",sf)
    for(j in grep("\\|+",trms)){
      sf<-gsub(trms[j],"",x=sf,fixed=T)
    }
    sf<-gsub("\\+ \\(([[:space:]]|\\(|\\)|\\+)*\\)","",sf)
    ff<-as.formula(sf)
    for(i in 1:length(RE)){			# Usually, 1 for subjects, 2 for items
      rot<-rePCA(mod)[[RE[i]]]$rotation
      # Check if this RE is not already minimal:
      if (length(rot)>1){
        mat<-do.call(cbind,getME(mod,"mmList")[grep(paste("| ",RE[i],sep=""),names(getME(mod,"mmList")),fixed=T)])
        rmat<-data.frame(mat%*%rot)
        names(rmat)<-paste(RE[i],names(rmat),sep='_')
        if (comparable & length(dat.name)==1){
          assign(as.character(dat.name),cbind(eval(dat.name),rmat))
        } else {
          newdat<-cbind(newdat,rmat)
        }
        
        nsdevs<-rePCA(mod)[[i]]$sdev/rePCA(mod)[[i]]$sdev[1]
        # Decide how many components we should keep:
        keep<-length(nsdevs[nsdevs>tol])
        # Add the new RE to the formula:
        ff<-update(ff,as.formula(paste(".~.+(0+",paste(names(rmat)[1:keep],collapse="+ "),ifelse(keep==1,"|","||"),RE[i],")")))
      }
      else{
        # If RE is minimal, reproduce the original with compatible names
        assign(paste(RE[i],"_X1",sep=""), 1)
        if (comparable & length(dat.name)==1){
          eval(parse(text=paste(as.character(dat.name),"<-cbind(",as.character(dat.name),",",RE[i],"_X1)",sep="")))
        } else {
          eval(parse(text=paste("newdat <-cbind(newdat,",RE[i],"_X1)",sep="")))
        }
        ff<-update(ff,as.formula(paste(".~.+(0+", paste(RE[i],"_X1",sep=""),"|",RE[i],")")))	
      }			
    }
    if (comparable& length(dat.name)==1) {
      pmod<-update(mod,ff)
    } else {
      pmod<-update(mod,ff,data=newdat)
    }
    # Clean up remaining components (some may end up under tol after removing correlations)
    ff2<-formula(pmod)
    changes<-F
    for(i in 1:length(RE)){
      k<-which(rePCA(pmod)[[RE[i]]]$sdev<tol*rePCA(pmod)[[RE[i]]]$sdev[1])
      ff2<-update(ff2,as.formula(paste(c("~.",paste(RE[i],"_X",k,"|",RE[i],")",sep="")),collapse="-(0+")))
      changes<-ifelse(length(k)>0,T,changes)
    }
    if(ff2==ff|!changes){
      return(pmod)
    }
    else{
      return(update(pmod,ff2))
    }
  }
}

#LDA
#require(lda)

# Standard error of the mean
se <- function(x, ...) {
  n <- length(x)
  return(sd(x, ...)/sqrt(n))
}

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}


get.results <-
  function (d,
            controller,
            elem.number=NULL,
            del.col=c(2,4),
            col.names=NULL,
            list=NULL,
            save.to="") {
    
    # ----- Check input parameters------
    if ((is.data.frame(d)==FALSE)&(is.character(d)==FALSE)){stop ("d should be a data.frame or a character")}
    if (is.character(controller)==FALSE) {stop ("controller should be a character")}
    if ((is.numeric(elem.number)==FALSE) &(is.null(elem.number)==FALSE)) {stop ("elem.number should be numeric")}
    if ((is.character(list)==FALSE) &(is.null(list)==FALSE)){stop ("list should be character")}
    if ((is.numeric(del.col)==FALSE)&(is.null(del.col)==FALSE)) {stop ("del.col should be numeric")}
    if ((is.character(col.names)==FALSE) &(is.null(col.names)==FALSE)){stop ("col.names should be character")}
    if (is.character(save.to)==FALSE) {stop ("save.to should be a character")}
    #---------------------------------
    
    # ensure that ALL the columns are read. If data.frame is passed, make sure the columns are named properly.
    if (is.character(d)) {d <- read.ibex(d, col.names)
    } else{ 
      colnames(d)[1:7] <- c("subject",
                            "md5.hash",
                            "controller",
                            "item.number",
                            "element.number",
                            "type",
                            "group")
      
      if (length(col.names)<NCOL(d)-7) {
        col.names <-c(col.names, paste0("Col",seq(from=8+length(col.names), to=NCOL(d))))
        colnames(d)[8:NCOL(d)] <- col.names
      }      
    }
    
    #------------------------------------   
    # check whether all the parameters provided are in the data. Report which ones are not
    
    tmp <- check.missing(controller, d[[3]], "controllers")
    check.missing(elem.number, d[[5]], "elem.numbers") 
    
    # We can pass a vector of controllers, but since different
    # controllers create different number of columns, the
    # result may not be what we want. Let user know about it.
    if (length(controller)-tmp >1) {message (length(controller)-tmp, " existing controllers requested.",
                                             "The columns may contain inconsistent info.\n")  }   
    #------------------------------------
    
    # If elem.number specified subset with it; otherwise - without it
    if (is.null(elem.number)==FALSE){
      res <- d[(d[[3]] %in% controller) & (d[[5]] %in% elem.number),]}
    else {
      res <- d[d[[3]] %in% controller, ]
    }
    res <- droplevels(res)
    
    # we don't need old row counts, so we delete them
    rownames(res) <- NULL
    
    # if the number of rows of the data set is zero
    # then probably the subsetting didn't work.
    if (NROW(res) == 0) 
    {stop("The subsetting with the given parameters didn't work.\n")}
    
    # ---------- deleting columns ------------
    # Here there is slightly more code than is necessary for just deletion.
    # Mostly we gather info about which columns are deleted to report it
    # to the user
    
    # if some columns are specified for deletion...
    if (is.null(del.col)==FALSE){
      
      # ---------- check validity of column indices  ---------------
      # If some index exceeds the number of columns in data.frame or is negative,
      # it is omitted.
      # ? ???? ?? ????????? ????? ? ???????? ?????? ???????, ?? ?? ??????? ??? ???
      out.of.bounds <- c (which(del.col>ncol(d)), which(del.col<0))
      if (length(out.of.bounds)>0){
        message ("Columns with the following indices specified for deletion do not exist in the data: ", 
                 del.col[out.of.bounds])
        del.col <- del.col[-out.of.bounds]
      }
      
      # determine which columns were specified by user
      if(!missing(del.col)) user.del.col <- unique(del.col)
      else user.del.col <- NULL
      
      # ----- decide which columns are to be deleted -------
      #       (in addition to specified by user)
      
      # The 7-th column in IBEX results is the group number. It is used in Latin 
      # Square designs, but quite often is unused. If it is unused, IBEX returns NULL. 
      # The column in this case is of no use. 
      if (res[1,7] == "NULL") del.col <- c(del.col,7)
      
      # if only one controller specified, delete the column
      if (length(controller==1)) del.col <- c(del.col,3)
      
      # the same for element number
      if (missing(elem.number)|NROW(unique(res[5]))==1) del.col <- c(del.col,5)
      
      #-------- deletion list: done ------------------------
      
      
      # sort the columns indices for easier reporting, handle duplicates
      del.col <- sort(unique(del.col))
      
      
      # create empty data.frame for info about deleted columns      
      del.col.info <- data.frame(matrix(ncol=3, nrow=length(del.col),
                                        dimnames=list(NULL, c("Index",
                                                              "Name",
                                                              "Reason")))) 
      
      # Get info about which columns were specified for deletion by user                            
      
      if (!is.null(sys.call(-1))) {
        
        # Get the params of the caller function (as string)
        call.info <- deparse(sys.call(-1), width.cutoff=500L)
        
        #------------- Extracting column indices specified in del.col -------------
        call.info <- gsub("[\n ]+","", call.info)
        m  <- regexpr("del.col=c\\([0123456789:,]+\\)", call.info)
        call.del.ind <- regmatches(call.info,m)
        m <- regexpr("[0123456789:,]+", call.del.ind)
        call.del.ind <- regmatches(call.del.ind,m)
        
        if (length( grep(":", call.del.ind) )>0) {
          call.del.ind <- strsplit(call.del.ind,",")
          
          #parsing call.del.ind chunks containing ":". E.g 1:4 is converted to 1 2 3 4
          my.fun <- function(x) { 
            if (grep(":", x)) {
              tmp <- unlist(strsplit(x,":")) 
              tmp <- as.numeric(tmp)
              return(seq(from=tmp[1], to=tmp[2]))  
            }
          }
          
          call.del.ind <-  unlist( sapply(call.del.ind[[1]], FUN=my.fun), use.names=FALSE)
        } else {
          call.del.ind <- unlist(strsplit(call.del.ind,","), use.names=FALSE)
        }
        
        # If the caller function is get.results.daj (only it has "sep.quest" parameter)
        # and the two data.frames are requested, correct indices of 
        # columns for deletion by 5 (the number of additional columns in the first
        # data.frame)
        if (length(grep("sep.quest=T", call.info))==1) {
          call.del.ind <- as.integer(call.del.ind)
          call.del.ind[which(call.del.ind>12)]  <- call.del.ind[which(call.del.ind>12)]-5
        }
        
      } else {
        if (!is.null(user.del.col)) call.del.ind <- user.del.col
        else call.del.ind <- NULL
      }
      
      
      
      #------- Make info table about deleted tables ---------------------
      del.col.info[1] <- del.col
      del.col.info[2] <- colnames(res)[del.col]
      
      del.col.info[(del.col.info$Index==3), 3] <- "Auto (only one controller exists)" 
      del.col.info[(del.col.info$Index==5), 3] <- "Auto (only one elem.number exists)" 
      del.col.info[(del.col.info$Index==7), 3] <- "Auto (contains only NULL values)"
      del.col.info[(del.col.info$Index==10), 3] <- "Auto (contains only NULL values)"
      del.col.info[(del.col.info$Index==15), 3] <- "Auto (contains only NULL values)"
      del.col.info[(del.col.info$Index==11), 3] <- "Auto (contains only FALSE values)"
      
      # remove unexisting column indices. We get "call.del.ind" directly from
      # the call information, so there the unexisting columns indices are still present
      call.del.ind <- call.del.ind[-out.of.bounds]
      if (length(call.del.ind)!=0)
        del.col.info[which(del.col.info$Index %in% call.del.ind),3] <- "User request"      
      
      del.col.info[is.na(del.col.info[,3]), 3] <- "Default"
      
      
      # delete columns
      res[del.col] <- list(NULL) 
      
    } # --------------  columns deleting done --------------------
    
    
    # Output info about how many and which columns were deleted
    if (is.null(del.col)==FALSE) {
      cat ("\n", NROW(del.col.info)," column(s) deleted:\n\n")
      print(del.col.info, right=FALSE, row.names=FALSE)
      cat("\n")}
    else {cat ("\nNo columns were deleted\n")}
    
    # Adding List column if asked
    if (is.null(list)==FALSE) {    
      list <- rep(list[1], times=NROW(res))
      res$List <- list    
    }
    
    if (save.to != "") {write.csv(res, file=paste(save.to,".csv",sep=""), row.names=FALSE)}
    
    # deleting all unused levels of factors
    return(res)
    
  }

check.missing <-
  function (x, string, name) {
    missing.values <- which(!(x %in% string))
    missing.values <- x[missing.values]
    
    if (length(missing.values)==length(x)&length(x)>0) 
      stop ("None of the ", name," (", paste0(missing.values, collapse=", "), ") is found in the data")
    if (length(missing.values)>0) 
      message ("The following ", name, " are not found in the data: ",
               paste0(missing.values, collapse=", "))  
    return(length(missing.values))
    
  }
read.ibex <-
  function (d, col.names, ...) {
    
    if (!is.character(d)) stop ("d must be a character")
    
    n.cols <- 14
    
    col.names <- c("subject",
                   "md5.hash",
                   "controller",
                   "item.number",
                   "element.number",
                   "type",
                   "group", col.names)
    
    # If there are more column names specified than there are columns in the data,
    # add empty columns  
    if (n.cols<length(col.names)) n.cols <- length(col.names)
    if (n.cols>length(col.names)) 
      col.names <- c (col.names, paste0("Col",seq(from=length(col.names)+1, to=n.cols)))
    
    colClasses <- c("factor", "character", "character", "numeric","numeric", "character","character", rep(NA, n.cols-7))
    d <- read.csv(d,header=FALSE, fill=TRUE, comment.char="#", 
                  col.names=col.names,
                  colClasses=colClasses,
                  as.is=FALSE, ...)
  }



#Plots


my_colours <- c("#0000CC", "#CC0000")

theme_mm <- theme_grey() +
  theme(
    plot.margin=unit(x=c(1,1,1,1),units="mm"),
    axis.title.y=element_text(angle=90,vjust=.3),
    axis.title.x=element_blank(),
    axis.text.x=element_text(size=10), 
    strip.background =  element_rect(fill = "white", colour = "white"),
    strip.text.x = element_text(size = 10, vjust=0.5, colour="grey30"),
    panel.background =  element_rect(fill = "white", colour = "black"),
    panel.grid.major.y = element_line(colour = 'gray', linetype = 'solid', size=.5),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(size=10, vjust=0.5,colour="grey30"),
    legend.text=element_text(size=9),
    legend.title = element_text(size=9),
    complete=FALSE
  )


theme_set(theme_mm)
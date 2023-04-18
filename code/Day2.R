#everything is at least a vector!

#########data.frame
#vector[x] where x is the position/range that should be displayed
#different ways to check a variable (column)
ex$variable
ex[, variable]
ex[[variable]]
ex[, c(var1, var2)] #for multiple variables

ex$variable[1:10]#for specific rows in a column
ex[1:10, variable]

table(ex$variable) #frequency table
ex$variabe > 10 # T/F
ex$variable[ex$variable >10] #values themselves. Does the statement in [] not output logic values? weird

#add a column of new variable
ex$newvarname <- (ex$variable > 10)
ex[, "newvarname"] <- (ex$variable > 10)


#changing data class
vars.categoric <- c("RN_INDI", "Q_PHX_DX_STK", "Q_PHX_DX_HTDZ", "Q_PHX_DX_HTN", "Q_PHX_DX_DM", "Q_PHX_DX_DLD", "Q_PHX_DX_PTB", 
              "Q_HBV_AG", "Q_SMK_YN", "Q_DRK_FRQ_V09N")
vars.categoric <- names(ex)[c(2, 4:12)]                              ## same
vars.categoric <- c("RN_INDI", grep("Q_", names(ex), value = T))     ## same: extract variables starting with "Q_"
 
vars.continuous <- setdiff(names(ex), vars.categoric)                     ## Exclude categorical variables
vars.continuous <- names(ex)[!(names(ex) %in% vars.categoric)]            ## same: !- not, %in%- including
    #vars are vectorc of variable names (character), not a matrix of the value of these variables

for (vn in vars.categoric){                                          ## for loop: as.factor
  ex[, vn] <- as.factor(ex[, vn])
}

for (vn in vars.continuous){                                        ## for loop: as.numeric
  ex[, vn] <- as.numeric(ex[, vn])
}

as.factor(ex$Q_PHX_DX_STK) #to convert from matrix directly
as.numeric(as.character(ex$Q_PHX_DX_STK)) # to convert logic factor to numeric, change to char first

#apply functions
apply(data, 1, func) # dataset, rowwise(1) or columnwise(2), function to be applied to data. input dim doesnt have to equal output dim
lapply(data, func) #applies function to every elem columnwise. output always list
#dealing with NAs
tapply(data, index, function(x){
  mean(x, na.rm = T)}) #data (column), label by which data is sorted (column), function to be applied to data. used to calculate a set of data instead of individual elements
na.omit(data) #omits row that has NA

#subset
ex2012 <- ex[ex$EXMD_BZ_YYYY >= 2012, ] # data frame of ex1 whose EXMD_BZ_YYYY are >2012
subset(ex1, EXMD_BZ_YYYY >= 2012) #simplified
exyy <- ex$EXMD_BZ_YYYY[ex$EXMD_BZ_YYYY >= 2012] # vector of EXMD_BZ_YYYY whose values are >2012


#aggregate(): Summary stats, tapply extended
aggregate(ex1[, c("WSTC", "BMI")], list(ex1$Q_PHX_DX_HTN, ex1$Q_PHX_DX_DM), mean) ## two columns in ex, label by which sorted (logic vals), apply mean to two columns 
aggregate(cbind(WSTC, BMI) ~ Q_PHX_DX_HTN + Q_PHX_DX_DM, data = ex1, mean) #dependent ~ independent, dataset, function
lm(dependent_var ~ independent_var, data = datasetname) #linear model 
aggregate(. ~ Q_PHX_DX_HTN  + Q_PHX_DX_DM, data = ex1, function(x){c(mean = mean(x), sd = sd(x))})    ##all variables against independent, function makes new columns for each variable's mean and sd

order(ex1$HGHT) #index of HGHT in ascending order
ex1$HGHT[order(-ex1$HGHT)] #values of HGHT in descending order
  ex1$HGHT[c(500, 168, 3, 328)] #equivalent
ex1[order(ex1$HGHT), ] #all of ex1 data in order of HGHT



#wide to long, long to wide format
long <- melt(ex1, id = c("EXMD_BZ_YYYY", "RN_INDI"), measure.vars = c("BP_SYS", "BP_DIA"), variable.name = "BP_type", value.name = "BP")
#data, id = variables to be maintained, measure.vars = variables to be combined, variable.name = name of newly combined var, value.name = value of newly combined var
wide <- dcast(long, EXMD_BZ_YYYY + RN_INDI ~ BP_type, value.var = "BP")
#data, variables to be maintained ~ variables to open, values of variables to be opened

#merge
ex1.merge <- merge(ex1.Q, ex1.measure, by = c("EXMD_BZ_YYYY", "RN_INDI", "HME_YYYYMM"), all = T)
#data 1, data 2,  columns in common, all = T to maintain all rows, F to erase rows that don't correspond in both columns 







#########tidyverse and dplyr functions 


#########data.table

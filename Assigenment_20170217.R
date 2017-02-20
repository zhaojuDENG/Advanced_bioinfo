# test_1
library(ggplot2)
x <- c(-10:10) # define x as integer from -10:10, with increments of 1
y <- 2*cos(x)  # define y
test_1<- data.frame(cbind(x=c(-10:10),y= 2*cos(x))) # construct a data frame that including these two variables
ggplot(test_1,aes(x=x,y=y))+geom_line()+geom_point() # graph with line and data points



#test_2 !!! this result(242/405) is different from the demo result with 246/401, maybe I am wrong with the steps in querying the database?
# track of thought: 1) establish of the connection with database
                   #2) get all the avaliable list of cancer studies
                   #3) select the case list of all Throid Carcinoma
                   #4) select all the Throid Carcinoma cases that with Next generation sequencing data
                   #4) retrive the genetice profiles for the mutations in Throid Carcinoma cases
                   #5) select the mutaion data related to BRAF gene
                   #6) count the N of cases with different mutations
install.packages("cgdsr",dependencies = T)
library(cgdsr)
# Create CGDS object
mycgds <- CGDS("http://www.cbioportal.org/public-portal/")

test(mycgds)

# Get list of cancer studies at server
getCancerStudies(mycgds)

# Get available case lists (collection of samples) for Thyroid cancer
getCancerStudies(mycgds)$name # Thyroid Carcinoma (TCGA, Provisional) is in the row #143
mycancerstudy <- getCancerStudies(mycgds)[143,1] # cancer study id=thca_tcga
mycaselist <- getCaseLists(mycgds,mycancerstudy)[3,1] # get all the sequenced case list of thyroid cancer =All (Next-Gen) sequenced samples (405 samples) 

# Get available genetic profiles for thca_tcga_mutations 
mygeneticprofile <- getGeneticProfiles(mycgds,mycancerstudy)[8,1]

# Get data slices for a BRAF gene, genetic profile and case list
geneticprofile <- getProfileData(mycgds,'BRAF',mygeneticprofile,mycaselist)
dim(geneticprofile) 
table(geneticprofile) 
# results of the number of people with each kind of mutations
# K591_A598dup        K601E         N581_A598dup      P490_Q494del    T488_P492del       V600E 
 # 1                     1               1                  1            1                237 

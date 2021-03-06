############################
####  CLASSE DEFINITION ####
############################

## CLASS DESCRIPTION:
## - instance of obkClinicalEvent store a clinical event associated with an individual
## - individual.ID is the ID of the individual to which the clinical event refers to
## - type is the type of clinical event from a constraint list
## - characteristic is a descriptor of the event of given type
## - start.date is the starting date
## - end.date is the ending date
## - location is the location of the event
## - non defined elements are set as NULL

setClass("obkClinicalEvent", representation(individual.ID="characterOrNULL", type="characterOrNULL", characteristic="characterOrNULL", start.date="DateOrNULL", end.date="DateOrNULL", duration="numericOrNULL", location="characterOrNULL"), prototype(individual.ID=NULL, type=NULL, characteristic=NULL, start.date=NULL, end.date=NULL, start.date=NULL, duration=NULL, location=NULL))

setClassUnion("obkClinicalEventOrNULL", c("obkClinicalEvent", "NULL"))




######################
####  CONSTRUCTOR ####
######################

## INPUT DESCRIPTION:
## individual.ID: a character
## type : a character (information of medical relevnce, e.g. symptom, vaccination, hospitalization...)
## characteristic : a character (characterizes the event of the given type)
## start.date : a Date
## end.date : a Date
## duration : a numeric
## location : a character
setMethod("initialize", "obkClinicalEvent", function(.Object, individual.ID=NULL, type=NULL, characteristic=NULL ,start.date=NULL, end.date=NULL, duration=NULL, location=NULL, format.Date="%Y-%m-%d") {

    ## RETRIEVE PROTOTYPED OBJECT ##
    x <- .Object

    ## escape if no type info provided ##
    if(is.null(individual.ID)||is.null(type)) return(x)


    ## PROCESS ARGUMENTS ##

    ## force character type if the ID is not NULL
    x@type <- as.character(type)

    ## force character type if the ID is not NULL
    if(!is.null(characteristic)) x@characteristic <- as.character(characteristic)

    ## force character type if the ID is not NULL
    if(!is.null(individual.ID)) x@individual.ID <- as.character(individual.ID)

    ## force start.date in the standard date format
    if(!is.null(start.date)) x@start.date <- as.Date(start.date, format=format.Date)

    ## force start.date in the standard date format
    if(!is.null(end.date)) x@end.date <- as.Date(end.date, format=format.Date)

    ## force duration in the numeric format
    if(!is.null(duration)) x@duration <- as.numeric(duration)

    ## force character type if the location is not NULL
    if(!is.null(location)) x@location <- as.character(location)

    return(x)

}) # end obkClinicalEvent constructor

####################
####  ACCESSORS ####
####################

################
## get.type ##
################
setMethod("get.type","obkClinicalEvent", function(x, ...){
    return(x@type)
})

################
## get.id ##
################
setMethod("get.id","obkClinicalEvent", function(x, ...){
    return(x@individual.id)
})

################
## get.characteristic ##
################
setMethod("get.characteristic","obkClinicalEvent", function(x, ...){
    return(x@characteristic)
})

######################
####  SHOW METHOD ####
######################

setMethod ("show", "obkClinicalEvent", function(object){
    ID <- get.id(object)
    type.event <- get.type(object)
    start <- get.start.date(object)
    end <- get.end.date(object)
    duration <- get.duration(object)

    cat(paste("individual (ID) =", ID,"Type =", type.event))
    if(!is.null(start)) cat(paste("Start date =",start))
    if(!is.null(end)) cat(paste("End date =",end))
    if(!is.null(duration)) cat(paste("Duration of event =",duration))

})

####################
## get.start.date ##
####################
setMethod("get.start.date", "obkClinicalEvent", function(x, ...){
  return(x@start.date)
})

####################
## get.end.date ##
####################
setMethod("get.end.date", "obkClinicalEvent", function(x, ...){
  return(x@end.date)
})

####################
## get.duration ##
####################
setMethod("get.duration", "obkClinicalEvent", function(x, ...){
  return(x@duration)
})

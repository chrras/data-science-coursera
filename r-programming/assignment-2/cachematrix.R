## Put comments here that give an overall description of what your
## functions do

## Initialize a set of functions to get and set the matrix x or its inverse. The
## function return a list which can be passed to the cacheSolve function.

makeCacheMatrix <- function(x = matrix()) {
        inverse <- NULL
        set <- function(y) {
                x <<- y
                inverse <<- NULL
        }
        get <- function() x
        setinverse <- function(i) inverse <<- i
        getinverse <- function() inverse
        list(set = set,
             get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## The function cacheSolve return the inverse of a matrix from the cache if it
## exist. If not, it calculate it, store it, and returning it. cacheSolve takes
## an argument, created by the makeCacheMatrix function.

cacheSolve <- function(x, ...) {
        inverse <- x$getinverse()
        if(!is.null(inverse)) {
                message("Getting cached data")
                return(inverse)
        }
        data <- x$get()
        inverse <- solve(data)
        x$setinverse(inverse)
        inverse
}


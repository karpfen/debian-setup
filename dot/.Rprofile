local ({
        r <- getOption('repos')
        #r['CRAN'] <- 'https://cran.uni-muenster.de'
        r['CRAN'] <- 'https://cran.wu.ac.at'
        options(repos = r)
        })
# http://stackoverflow.com/questions/24387660/how-to-change-libpaths-permanently-in-r
# Note that the order of these has to be reversed for initial installation of
# nvimcom, then they can be reset.
.libPaths(c ('~/R/x86_64-pc-linux-gnu-library/3.3', .libPaths ()))
.libPaths(c ('/usr/local/lib/R/site-library', .libPaths ()))
 
#options (stringsAsFactors=FALSE)
#options (max.print=100)
options (width = 80)
options (scipen = 10)
options (editor = 'nvim')
#options (prompt='R> ', digits=4)

.env <- new.env()
.env$setpar <- function (mar=c(3, 3, 2, 1), mgp=c(1.7, 0.3, 0))
{
    par (mar = mar, mgp = mgp)
}
attach(.env)

.First <- function(){
    if (interactive()){
        # see :h nvimcom-not-loaded
        #if (Sys.getenv ("NVIMR_TMPDIR") == "")
        #        options (defaultPackages = c ("utils", "grDevices", "graphics",
        #            "stats", "methods"))
        #else
        #        options (defaultPackages = c ("utils", "grDevices", "graphics",
        #            "stats", "methods", "nvimcom"))

        if ('colorout' %in% rownames (utils::installed.packages ()))
        {
            library (colorout)
            setOutputColors (negnum = 52, zero = 236, number = 236, normal = 24,
                             verbose = FALSE, true = 29, false = 52, date = 3,
                             string = 22)
        }

        rv <- R.Version ()$version.string
        rn <- R.Version ()$nickname
        rpl <- R.Version ()$platform
        rsys <- Sys.info ()
        ss <- system ('. /etc/os-release; echo ${VERSION}', intern = T)

        lns <- list ()
        lns [[1]] <- paste0 (rv, '--- \'', rn, '\'')
        lns [[2]] <- paste0 ('Debian ', ss, ' (kernel ', rsys ['release'], ')')
        lns [[3]] <- paste0 ('machine = ', rpl, ': ', rsys ['nodename'])
        lns [[4]] <- paste0 ('wd: ', getwd ())
        lns <- sapply (lns, function (i)
                       {
                           if ( (nchar (i) %% 2) != 0)
                               i <- paste0 (i, ' ')
                           return (i)
                       })
        print (lns)

        chk_file <- "~/.Rold_pkg_check"
        do_check <- TRUE
        today <- strsplit (as.character (Sys.time ()), " ") [[1]] [1]
        if (file.exists (chk_file))
        {
            chk_date <- utils::read.table (chk_file, as.is = TRUE) [1, 1]
            if (chk_date == today)
                do_check <- FALSE
        }
        if (do_check)
        {
            if (curl::has_internet ())
            {
                message ('Old package check for ', today, ' : ',
                         appendLF = FALSE)
                old <- utils::old.packages ()
                if (!is.null (old))
                    message ('Updatable packages: ',
                             do.call (paste, as.list (rownames (old))), '\n')
                else
                    message ('All packages up to date\n')
                # only check for new packages once per day
                write (today, file = chk_file)
            } else
                message ('nope, no internet\n')
        }
    }
}


if(Sys.getenv('TERM') == 'xterm-256color')
    library('colorout')
Sys.setenv("PKG_CXXFLAGS"="-fopenmp")
Sys.setenv("PKG_LIBS"="-fopenmp")

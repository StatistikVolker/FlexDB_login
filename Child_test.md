<!-- Child_test.Rmd -->

Test
=======================================================================
Sidebar {.sidebar}
-----------------------------------------------------------------------

### Choose a date



```r
# choose next special weekday from given date
# wday = 5 chooses next thursday
mkr.nextweekday <- function(date, wday = 5) {
     date <- as.Date(date)
     diff <- wday - wday(date)
     if( diff < 0 )
          diff <- diff + 7
     return(date + diff)
}


uiOutput("Date")
```

<!--html_preserve--><div id="Date" class="shiny-html-output"></div><!--/html_preserve-->

```r
output$Date <- renderUI({
     dateInput(
          inputId = "Date",
          label = "Date",
          value = mkr.nextweekday(Sys.Date(), 5), # next thursday
          daysofweekdisabled = c(1,2,3,5,6,7), # only thursdays
          format = "dd. MM yyyy",
          startview = "month",
          weekstart = 1,
          language = "de" # German dates
          )
})
```


Column
-------------------------------------------------------------------------

<!--### <font size="5"> Date is <b><!--html_preserve--><span id="out03ab5e5b48b1801b" class="shiny-text-output"></span><!--/html_preserve--> </b> </font> -->


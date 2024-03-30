<cfparam name="book" default="">
<cfdump var="#form#">

<cftry> 
    <cfset addEditFunctions = createObject("addedit") /> 
        <cfset addEditFunctions.processForms(form)>
        <div class="row"> 
            <div id="main" class="col-9"> 
                <cfif book neq "">
                    <cfoutput>#mainForm()# </cfoutput>
                </cfif>
            </div> 
            <div id="leftgutter" class="col-lg-3 order-first"> 
                <cfoutput> #sideNav()#</cfoutput> 
            </div> 
        </div>

    <cfcatch type="any"> 
        <cfoutput> #cfcatch.Message# </cfoutput> 
    </cfcatch> 
</cftry> 

<cffunction name="mainForm">
    <cfset var thisBookDetails= addEditFunctions.bookDetails(book)>
    <cfoutput> 
        <form action="#cgi.script_name#?tool=addedit" method="post">
            <div class="form-floating mb-3">             
            <input type="text" id="isbn13" name="isbn13" class="form-control" value="" placeholder="Please enter the ISBN13 of the book" /> 
            <label for="isbn13">ISBN13:</label> 
            </div>

            <div class="form-floating mb-3">
            <input type="text" id="title" name="title" class="form-control" value="#thisBookDetails.title[1]#" placeholder="Book Title" />
            <label for="title">Book Title</label> 
            </div>

            <div class="form-floating mb-3">    
                <input type="number" id="year" name="year" step=".1" class="form-control" value="" placeholder="Year published" />    
                <label for="year">year: </label> 
            </div>

            <div class="form-floating mb-3">    
                <input type="text" id="isbn" name="isbn" class="form-control" value="" placeholder="ISBN of book" />    
                <label for="weight">ISBN: </label> 
            </div>

            <div class="form-floating mb-3">    
                <input type="number" id="pages" name="pages" step=".1" class="form-control" value="" placeholder="Number of pages" />    
                <label for="pages">Page count: </label> 
            </div>

            <div class="form-floating mb-3">    
                <input type="number" id="weight" name="weight" step=".1" class="form-control" value="" placeholder="Weight of book" />    
                <label for="weight">Weight: </label> 
            </div>

            <button type="submit" class="btn btn-primary">Add Book</button>
        </form> 
         
    </cfoutput>    
</cffunction> 

<cffunction name="sideNav">Side Nav 
    <cfset allbooks = addEditFunctions.sideNavBooks()> 
    <div> Book List </div> 
        <cfoutput> 
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a href="#cgi.script_name#?tool=addedit&book=new" class="nav-link">
                        New book
                    </a>
                </li>         
                <cfloop query="allbooks"> 
                    <li class="nav-item"> 
                        <a class="nav-link" href="#cgi.script_name#?tool=addedit&book=#isbn13#">#trim(title)#</a> 
                    </li> 
                </cfloop> 
            </ul> 
        </cfoutput>


</cffunction>

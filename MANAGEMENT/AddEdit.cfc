

component { 

    

    function processForms( required struct formData ){          
        if( formData.keyExists("isbn13") && formData.isbn13.len()==13 && formData.title.len() > 0  ) 

        {    writedump( formData );   
            var qs = new query( datasource = application.dsource );
            qs.setSql("IF NOT EXISTS (SELECT * from books WHERE isbn13=:isbn13)
                INSERT INTO books (isbn13,title,year,isbn,pages,weight) values (:isbn13,:title,:year,:isbn,:pages,:weight);
            UPDATE books SET  
                title=:title, 
                weight=:weight, 
                year=:year,  
                isbn=:isbn,  
                pages=:pages  
                WHERE isbn13=:isbn13
            ");
            qs.addParam(name="isbn13",cfsqltype="CF_SQL_NVARCHAR",value=formData.isbn13,null=formData.isbn13.len()!=13 );
            qs.addParam(name="title",cfsqltype="CF_SQL_NVARCHAR",value=formData.title,null=formData.title.len()==0); 
            qs.addParam(name="year",cfsqltype="CF_SQL_NVARCHAR",value=formData.year);
            qs.addParam(name="isbn",cfsqltype="CF_SQL_NVARCHAR",value=formData.isbn);
            qs.addParam(name="pages",cfsqltype="CF_SQL_NVARCHAR",value=formData.pages);
            qs.addParam(name="weight", cfsqltype="CF_SQL_NVARCHAR", value=formData.weight);
            
            qs.execute()
        }  
        
    }

    function sideNavBooks(  ){            
            var qs = new query( datasource = application.dsource );
            qs.setSql("select * from books order by title");
            return qs.execute().getResult();
        }

    function bookDetails(isbn13){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from books where isbn13=:isbn13");
        qs.addParam(name="isbn13",CFSQLTYPE="CF_SQL_NVARCHAR",value=arguments.isbn13);
        return qs.execute().getResult();
    }    
}    

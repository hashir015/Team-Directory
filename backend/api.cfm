<!--- 
    api.cfm
    REST API endpoint for Team Directory with full CRUD operations
    
    Security Features:
    - Input sanitization to prevent XSS
    - Validation for required fields and length limits
    - Proper error handling and status codes
    
    Endpoints:
    - GET    /api.cfm         - Get all employees
    - POST   /api.cfm         - Create new employee
    - PUT    /api.cfm?id=X    - Update employee
    - DELETE /api.cfm?id=X    - Delete employee
--->
<cfprocessingdirective pageencoding="utf-8">
<cfsetting enablecfoutputonly="true" showdebugoutput="false">

<!--- ============================================= --->
<!--- CORS Headers                                  --->
<!--- ============================================= --->
<cfheader name="Access-Control-Allow-Origin" value="*">
<cfheader name="Access-Control-Allow-Methods" value="GET, POST, PUT, DELETE, OPTIONS">
<cfheader name="Access-Control-Allow-Headers" value="Content-Type">

<!--- Handle Preflight OPTIONS request --->
<cfif cgi.request_method EQ "OPTIONS">
    <cfexit>
</cfif>

<!--- ============================================= --->
<!--- Configuration                                 --->
<!--- ============================================= --->
<cfset variables.dataDir = expandPath("./data")>
<cfset variables.jsonPath = variables.dataDir & "/employees.json">
<cfset variables.initialDataPath = variables.dataDir & "/initial-employees.json">

<!--- ============================================= --->
<!--- Security: Input Sanitization Function         --->
<!--- ============================================= --->
<cffunction name="sanitizeInput" returntype="string" access="private" 
    hint="Sanitizes input to prevent XSS attacks">
    <cfargument name="input" type="string" required="true">
    <cfargument name="maxLength" type="numeric" required="false" default="255">
    
    <!--- Trim whitespace --->
    <cfset var cleaned = trim(arguments.input)>
    
    <!--- HTML encode to prevent XSS --->
    <cfset cleaned = htmlEditFormat(cleaned)>
    
    <!--- Enforce max length --->
    <cfif len(cleaned) GT arguments.maxLength>
        <cfset cleaned = left(cleaned, arguments.maxLength)>
    </cfif>
    
    <cfreturn cleaned>
</cffunction>

<!--- ============================================= --->
<!--- Validation Function                           --->
<!--- ============================================= --->
<cffunction name="validateEmployee" returntype="struct" access="private"
    hint="Validates employee data and returns sanitized values or errors">
    <cfargument name="data" type="struct" required="true">
    <cfargument name="requireAllFields" type="boolean" required="false" default="true">
    
    <cfset var result = { valid = true, errors = [], employee = {} }>
    
    <!--- Validate FIRSTNAME --->
    <cfif arguments.requireAllFields OR structKeyExists(arguments.data, "FIRSTNAME")>
        <cfif NOT structKeyExists(arguments.data, "FIRSTNAME") OR NOT len(trim(arguments.data.FIRSTNAME))>
            <cfset arrayAppend(result.errors, "First name is required")>
            <cfset result.valid = false>
        <cfelseif len(trim(arguments.data.FIRSTNAME)) GT 50>
            <cfset arrayAppend(result.errors, "First name must be 50 characters or less")>
            <cfset result.valid = false>
        <cfelse>
            <cfset result.employee.FIRSTNAME = sanitizeInput(arguments.data.FIRSTNAME, 50)>
        </cfif>
    </cfif>
    
    <!--- Validate LASTNAME --->
    <cfif arguments.requireAllFields OR structKeyExists(arguments.data, "LASTNAME")>
        <cfif NOT structKeyExists(arguments.data, "LASTNAME") OR NOT len(trim(arguments.data.LASTNAME))>
            <cfset arrayAppend(result.errors, "Last name is required")>
            <cfset result.valid = false>
        <cfelseif len(trim(arguments.data.LASTNAME)) GT 50>
            <cfset arrayAppend(result.errors, "Last name must be 50 characters or less")>
            <cfset result.valid = false>
        <cfelse>
            <cfset result.employee.LASTNAME = sanitizeInput(arguments.data.LASTNAME, 50)>
        </cfif>
    </cfif>
    
    <!--- Validate ROLE --->
    <cfif arguments.requireAllFields OR structKeyExists(arguments.data, "ROLE")>
        <cfif NOT structKeyExists(arguments.data, "ROLE") OR NOT len(trim(arguments.data.ROLE))>
            <cfset arrayAppend(result.errors, "Role is required")>
            <cfset result.valid = false>
        <cfelseif len(trim(arguments.data.ROLE)) GT 100>
            <cfset arrayAppend(result.errors, "Role must be 100 characters or less")>
            <cfset result.valid = false>
        <cfelse>
            <cfset result.employee.ROLE = sanitizeInput(arguments.data.ROLE, 100)>
        </cfif>
    </cfif>
    
    <cfreturn result>
</cffunction>

<!--- ============================================= --->
<!--- Data Access Functions                         --->
<!--- ============================================= --->
<cffunction name="loadEmployees" returntype="array" access="private"
    hint="Loads employees from JSON file">
    <cfif fileExists(variables.jsonPath)>
        <cfreturn deserializeJSON(fileRead(variables.jsonPath, "utf-8"))>
    <cfelse>
        <cfreturn []>
    </cfif>
</cffunction>

<cffunction name="saveEmployees" returntype="void" access="private"
    hint="Saves employees to JSON file">
    <cfargument name="employees" type="array" required="true">
    <cffile action="write" file="#variables.jsonPath#" 
            output="#serializeJSON(arguments.employees)#" charset="utf-8">
</cffunction>

<cffunction name="getNextId" returntype="numeric" access="private"
    hint="Gets the next available employee ID">
    <cfargument name="employees" type="array" required="true">
    <cfset var maxId = 0>
    <cfloop array="#arguments.employees#" item="emp">
        <cfif structKeyExists(emp, "ID") AND emp.ID GT maxId>
            <cfset maxId = emp.ID>
        </cfif>
    </cfloop>
    <cfreturn maxId + 1>
</cffunction>

<cffunction name="getInitialEmployees" returntype="array" access="private"
    hint="Returns initial employee data">
    <cfreturn [
        {"ID":1,"FIRSTNAME":"Ali","LASTNAME":"Khan","ROLE":"Software Engineer"},
        {"ID":2,"FIRSTNAME":"Ahmed","LASTNAME":"Raza","ROLE":"Frontend Developer"},
        {"ID":3,"FIRSTNAME":"Usman","LASTNAME":"Ali","ROLE":"Backend Developer"},
        {"ID":4,"FIRSTNAME":"Hamza","LASTNAME":"Sheikh","ROLE":"Full Stack Developer"},
        {"ID":5,"FIRSTNAME":"Bilal","LASTNAME":"Hussain","ROLE":"UI/UX Designer"},
        {"ID":6,"FIRSTNAME":"Ahsan","LASTNAME":"Malik","ROLE":"QA Engineer"},
        {"ID":7,"FIRSTNAME":"Hassan","LASTNAME":"Iqbal","ROLE":"DevOps Engineer"},
        {"ID":8,"FIRSTNAME":"Fahad","LASTNAME":"Khan","ROLE":"Software Engineer"},
        {"ID":9,"FIRSTNAME":"Saad","LASTNAME":"Ahmed","ROLE":"React Developer"},
        {"ID":10,"FIRSTNAME":"Umer","LASTNAME":"Farooq","ROLE":"ColdFusion Developer"},
        {"ID":11,"FIRSTNAME":"Zain","LASTNAME":"Butt","ROLE":"Intern"},
        {"ID":12,"FIRSTNAME":"Adeel","LASTNAME":"Shah","ROLE":"Software Engineer"},
        {"ID":13,"FIRSTNAME":"Shahzaib","LASTNAME":"Khan","ROLE":"Backend Developer"},
        {"ID":14,"FIRSTNAME":"Asad","LASTNAME":"Mehmood","ROLE":"Frontend Developer"},
        {"ID":15,"FIRSTNAME":"Taha","LASTNAME":"Yousaf","ROLE":"Intern"},
        {"ID":16,"FIRSTNAME":"Noman","LASTNAME":"Riaz","ROLE":"QA Engineer"},
        {"ID":17,"FIRSTNAME":"Arslan","LASTNAME":"Javed","ROLE":"DevOps Engineer"},
        {"ID":18,"FIRSTNAME":"Imran","LASTNAME":"Ali","ROLE":"Project Manager"},
        {"ID":19,"FIRSTNAME":"Kamran","LASTNAME":"Akhtar","ROLE":"Tech Lead"},
        {"ID":20,"FIRSTNAME":"Rizwan","LASTNAME":"Malik","ROLE":"Software Architect"},
        {"ID":21,"FIRSTNAME":"Maryam","LASTNAME":"Khan","ROLE":"UI/UX Designer"},
        {"ID":22,"FIRSTNAME":"Ayesha","LASTNAME":"Iqbal","ROLE":"Frontend Developer"},
        {"ID":23,"FIRSTNAME":"Fatima","LASTNAME":"Sheikh","ROLE":"React Developer"},
        {"ID":24,"FIRSTNAME":"Hina","LASTNAME":"Raza","ROLE":"QA Engineer"},
        {"ID":25,"FIRSTNAME":"Sara","LASTNAME":"Ahmed","ROLE":"Product Manager"}
    ]>
</cffunction>

<!--- ============================================= --->
<!--- Response Helper Function                      --->
<!--- ============================================= --->
<cffunction name="sendJsonResponse" returntype="void" access="private">
    <cfargument name="data" type="any" required="true">
    <cfargument name="statusCode" type="numeric" required="false" default="200">
    <cfargument name="statusText" type="string" required="false" default="OK">
    
    <cfif arguments.statusCode NEQ 200>
        <cfheader statuscode="#arguments.statusCode#" statustext="#arguments.statusText#">
    </cfif>
    <cfcontent type="application/json">
    <cfoutput>#serializeJSON(arguments.data)#</cfoutput>
</cffunction>

<!--- ============================================= --->
<!--- Main Request Handler                          --->
<!--- ============================================= --->
<cftry>
    <!--- Ensure data directory exists --->
    <cfif NOT directoryExists(variables.dataDir)>
        <cfdirectory action="create" directory="#variables.dataDir#">
    </cfif>

    <!--- Route based on HTTP method --->
    <cfswitch expression="#cgi.request_method#">
        
        <!--- ================================== --->
        <!--- GET - Retrieve all employees       --->
        <!--- ================================== --->
        <cfcase value="GET">
            <cfset employees = loadEmployees()>
            
            <!--- Initialize with sample data if empty --->
            <cfif arrayLen(employees) EQ 0>
                <cfset employees = getInitialEmployees()>
                <cfset saveEmployees(employees)>
            </cfif>
            
            <cfset sendJsonResponse(employees)>
        </cfcase>
        
        <!--- ================================== --->
        <!--- POST - Create new employee         --->
        <!--- ================================== --->
        <cfcase value="POST">
            <!--- Parse request body --->
            <cfset requestBody = toString(getHttpRequestData().content)>
            <cfif NOT len(trim(requestBody))>
                <cfset sendJsonResponse({"error": "Request body is required"}, 400, "Bad Request")>
                <cfexit>
            </cfif>
            
            <cfset inputData = deserializeJSON(requestBody)>
            
            <!--- Validate input --->
            <cfset validation = validateEmployee(inputData, true)>
            <cfif NOT validation.valid>
                <cfset sendJsonResponse({"error": arrayToList(validation.errors, "; ")}, 400, "Bad Request")>
                <cfexit>
            </cfif>
            
            <!--- Load existing employees --->
            <cfset employees = loadEmployees()>
            
            <!--- Create new employee --->
            <cfset newEmployee = {
                "ID": getNextId(employees),
                "FIRSTNAME": validation.employee.FIRSTNAME,
                "LASTNAME": validation.employee.LASTNAME,
                "ROLE": validation.employee.ROLE
            }>
            
            <!--- Add and save --->
            <cfset arrayAppend(employees, newEmployee)>
            <cfset saveEmployees(employees)>
            
            <cfset sendJsonResponse(newEmployee, 201, "Created")>
        </cfcase>
        
        <!--- ================================== --->
        <!--- PUT - Update existing employee     --->
        <!--- ================================== --->
        <cfcase value="PUT">
            <!--- Validate ID parameter --->
            <cfif NOT structKeyExists(url, "id") OR NOT isNumeric(url.id)>
                <cfset sendJsonResponse({"error": "Valid employee ID is required"}, 400, "Bad Request")>
                <cfexit>
            </cfif>
            
            <cfset employeeId = int(url.id)>
            
            <!--- Parse request body --->
            <cfset requestBody = toString(getHttpRequestData().content)>
            <cfif NOT len(trim(requestBody))>
                <cfset sendJsonResponse({"error": "Request body is required"}, 400, "Bad Request")>
                <cfexit>
            </cfif>
            
            <cfset inputData = deserializeJSON(requestBody)>
            
            <!--- Validate input (partial update allowed) --->
            <cfset validation = validateEmployee(inputData, false)>
            <cfif NOT validation.valid>
                <cfset sendJsonResponse({"error": arrayToList(validation.errors, "; ")}, 400, "Bad Request")>
                <cfexit>
            </cfif>
            
            <!--- Load and find employee --->
            <cfset employees = loadEmployees()>
            <cfset found = false>
            
            <cfloop from="1" to="#arrayLen(employees)#" index="i">
                <cfif employees[i].ID EQ employeeId>
                    <!--- Update fields --->
                    <cfif structKeyExists(validation.employee, "FIRSTNAME")>
                        <cfset employees[i].FIRSTNAME = validation.employee.FIRSTNAME>
                    </cfif>
                    <cfif structKeyExists(validation.employee, "LASTNAME")>
                        <cfset employees[i].LASTNAME = validation.employee.LASTNAME>
                    </cfif>
                    <cfif structKeyExists(validation.employee, "ROLE")>
                        <cfset employees[i].ROLE = validation.employee.ROLE>
                    </cfif>
                    
                    <cfset found = true>
                    <cfset updatedEmployee = employees[i]>
                    <cfbreak>
                </cfif>
            </cfloop>
            
            <cfif NOT found>
                <cfset sendJsonResponse({"error": "Employee not found"}, 404, "Not Found")>
                <cfexit>
            </cfif>
            
            <cfset saveEmployees(employees)>
            <cfset sendJsonResponse(updatedEmployee)>
        </cfcase>
        
        <!--- ================================== --->
        <!--- DELETE - Remove employee           --->
        <!--- ================================== --->
        <cfcase value="DELETE">
            <!--- Validate ID parameter --->
            <cfif NOT structKeyExists(url, "id") OR NOT isNumeric(url.id)>
                <cfset sendJsonResponse({"error": "Valid employee ID is required"}, 400, "Bad Request")>
                <cfexit>
            </cfif>
            
            <cfset employeeId = int(url.id)>
            
            <!--- Load employees --->
            <cfset employees = loadEmployees()>
            <cfset found = false>
            <cfset newList = []>
            
            <cfloop array="#employees#" item="emp">
                <cfif emp.ID EQ employeeId>
                    <cfset found = true>
                    <cfset deletedEmployee = emp>
                <cfelse>
                    <cfset arrayAppend(newList, emp)>
                </cfif>
            </cfloop>
            
            <cfif NOT found>
                <cfset sendJsonResponse({"error": "Employee not found"}, 404, "Not Found")>
                <cfexit>
            </cfif>
            
            <cfset saveEmployees(newList)>
            <cfset sendJsonResponse({"success": true, "deleted": deletedEmployee})>
        </cfcase>
        
        <!--- ================================== --->
        <!--- Unsupported Method                 --->
        <!--- ================================== --->
        <cfdefaultcase>
            <cfset sendJsonResponse({"error": "Method not allowed"}, 405, "Method Not Allowed")>
        </cfdefaultcase>
        
    </cfswitch>

<cfcatch type="any">
    <!--- Log error for debugging --->
    <cflog file="team-directory-api" text="Error: #cfcatch.message# - #cfcatch.detail#">
    
    <!--- Return sanitized error response --->
    <cfset errorMessage = htmlEditFormat(cfcatch.message)>
    <cfset sendJsonResponse({"error": errorMessage}, 500, "Internal Server Error")>
</cfcatch>
</cftry>

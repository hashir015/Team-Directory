component {

    this.name = "team_directory_app";
    this.applicationTimeout = createTimeSpan(0,1,0,0);

    // ColdFusion datasource (used as fallback if configured)
    this.datasource = "team_directory_db";

    // Tell CF where the REST-enabled CFCs are
    this.restsettings = {
        cfclocation = "controllers",
        skipcfc = false
    };

    // Handle errors gracefully
    public boolean function onError(any exception, string eventName) {
        cfheader(name="Content-Type", value="text/html");
        writeOutput('<html><head><title>Error</title></head><body style="font-family:Arial,sans-serif;margin:40px;">');
        writeOutput('<h1 style="color:##dc3545;">Application Error</h1>');
        writeOutput('<div style="background:##f8d7da;padding:20px;border-radius:8px;">');
        writeOutput('<strong>Message:</strong> ' & exception.message & '<br>');
        if (structKeyExists(exception, "detail") && len(exception.detail)) {
            writeOutput('<strong>Detail:</strong> ' & exception.detail & '<br>');
        }
        if (structKeyExists(exception, "tagContext") && arrayLen(exception.tagContext) > 0) {
            writeOutput('<strong>Location:</strong> ' & exception.tagContext[1].template & ':' & exception.tagContext[1].line);
        }
        writeOutput('</div></body></html>');
        return true;
    }

}

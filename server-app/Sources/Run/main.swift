/*--------------------------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
 *-------------------------------------------------------------------------------------------------------------*/
import Vapor
import ServerApp

print("Application is starting ...", #file)

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)

let app = Application(env)

app.http.server.configuration.port = 8080
app.http.server.configuration.hostname = "0.0.0.0"

defer { 
    print("Application terminated")
    app.shutdown() 
}
try configure(instance: app)

try app.run()

print("Application has been started ...")







